# Coursera Data Science Specialization - Getting and Cleaning Data
## Peer-graded Assignment: Gettinig and Cleaning Data Course Project
This file aims to provide a description of how all the scripts work and how they are connected.

### Dataset
* [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### Other Files
* `run_analysis.R` performs the data preparation steps as listed below:

    * Merges the training and the test sets to create one data set.
    * Extracts only the measurements on the mean and standard deviation for each measurement.
    * Uses descriptive activity names to name the activities in the data set
    * Appropriately labels the data set with descriptive variable names.
    * From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* `Clean_data.txt` is the exported tidy dataset that contains the mean of the each of measurements grouped by subject and activity.
* `Code_Book.md` is a code book that provides the description of the variables, the data, and any transformations or work that is performed to clean up the data.