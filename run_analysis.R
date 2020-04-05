#################################################################################
## Getting and Cleaning data -> Coursera Data Science Specialization
## Final Project
## Date: 04/03/2020
#################################################################################

#################################################################################
## This script aims to merge and clean the dataset that can be used
## for later analysis. 
#################################################################################

#################################################################################
## Dataset:
## One of the most exciting areas in all of data science right now is 
## wearable computing - see for example this article . Companies like
## Fitbit, Nike, and Jawbone Up are racing to develop the most advanced
## algorithms to attract new users. The data linked to from the course
## website represent data collected from the accelerometers from the
## Samsung Galaxy S smartphone.
#################################################################################

#################################################################################
## End Goal:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation 
##    for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data 
##    set with the average of each variable for each activity and each subject.
#################################################################################

# Set the working directory
setwd("C://Users//zhe//Documents//Coursera//Data Science Specialization//2. Getting and Cleaning Data//Final project")

# Load the library
library(dplyr)

#################################
# 0. Download & Read the data
#################################

## Check if the data folder already exists
if (!file.exists("./data")) {
        dir.create("./data")
}

## Download the file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/final_data.zip")

## Unzip the data
unzip("./data/final_data.zip") 
unlink("./data", recursive = TRUE)

# Read all the datasets
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE, col.names = c("n","feature_value"), header = FALSE)  
activity_label <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE, col.names = c("code", "activity"), header = FALSE)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE, col.names = "subject", header = FALSE)
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", stringsAsFactors = FALSE, col.names = features$feature_value, header = FALSE)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", stringsAsFactors = FALSE, col.names = "code", header = FALSE)
subject_train <-read.table("UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = FALSE, col.names = "subject", header = FALSE)
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE, col.names = features$feature_value, header = FALSE)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", stringsAsFactors = FALSE, col.names = "code", header = FALSE)
    
################################################################
# 1. Merge the train & Test data to create one dataset &
# 3. Uses descriptive activity names to name the activities
################################################################
# Combine the training datasets
train <- cbind(subject_train, y_train, x_train)

# Combine the test datasets
test <- cbind(subject_test, y_test, x_test)

# Merge training and test datasets & merge in the activity label
merged <- rbind(train, test)
merged2 <- merge(merged, activity_label, by = "code", all = TRUE)

# Remove the individual datasets
rm(features)
rm(activity_label)
rm(subject_test)
rm(x_test)
rm(y_test)
rm(subject_train)
rm(x_train)
rm(y_train)
rm(test)
rm(train)
rm(merged)
    

################################################################
# 2. Extracts only the measurements on the mean and SD
################################################################    
final <- merged2 %>%
            select(subject, code, activity, contains("mean"), contains("std"))
str(final)   ## QC -> looks good
names(final) ## QC
    
    
################################################################
# 4. Label the dataset with descriptive variable names
################################################################      
names(final) <- gsub("Acc", "Accelerometer", names(final))    
names(final) <- gsub("Gyro", "Gyroscope", names(final))    
names(final) <- gsub("^t", "Time", names(final))  
names(final) <- gsub("^f", "Frequency", names(final))  
names(final) <- gsub("Mag", "Magnitude", names(final))  
names(final) <- gsub("BodyBody", "Body", names(final))  
names(final) <- gsub("\\.", "", names(final))  
names(final) <- gsub("mean", "Mean", names(final))    
names(final) <- gsub("std", "STD", names(final))  
names(final) <- gsub("MeanFreq", "MeanFrequency", names(final))  
names(final) <- gsub("angle", "Angle", names(final)) 
names(final) <- gsub("tBody", "TimeBody", names(final)) 
names(final) <- gsub("gravity", "Gravity", names(final)) 

# QC
names(final)  
str(final)
n_distinct(final$subject, final$activity)  ## 180
    
##############################################################################################
# 5. Create 2nd dataset with average of each variable for each activity and each subject
##############################################################################################   
final2 <- final %>%
            group_by(subject, activity) %>%
            summarise_all(funs(mean)) %>%
            arrange(subject, activity)

# QC
nrow(final2)
n_distinct(final2$subject, final2$activity) ## 180
str(final2) 
head(final2, n=10)

# Export the final dataset
write.table(final2, file="Clean_data.txt", row.name=FALSE)


