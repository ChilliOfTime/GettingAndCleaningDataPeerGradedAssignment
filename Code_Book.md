This codebook aims to provide a description of the variables, the data, and any transformations or work that is performed to clean up the data.

In this repository, it contains the `run_analysis.R` script that performs the data preparation to clean the dataset. The purpose and steps are described in the **README** file.

### **Step 1: Download the data**
Dataset is downloaded from the web as a zipped folder. The data is unzipped before the data setup. The unzipped dataset is titled `UCI HAR Dataset`.

### **Step 2: Read each data file**
* ` features` (*"features.txt"*): 561 obs of 2 variables

    This files contains a list of all the features. It is used as the header of the test and training datasets.

* `activity_label` (*"activity_labels.txt"*): 6 obs of 2 variables

    This file links the class labels with the activity name. 

* `subject_test` (*"test/subject_test.txt"*): 2947 obs of 1 variable

    In this file, each row identifies the subject who performed the activity for each window and is selected for generating the test data. It contains 9 out of the 30 volunteers.

* `x_test` (*"test/X_test.txt"*): 2947 obs of 561 variables

    The test dataset.

* `y_test` (*"test/y_test.txt""*): 2947 obs of 1 variable

    The test data activity code and labels (1-6).

* `subject_train` (*"train/subject_train.txt"*): 7352 obs of 1 variable

    In this file, each row identifies the subject who performed the activity for each window and is selected for generating the training data. It contains 21 out of the 30 volunteers.

* `x_train` (*"train/X_train.txt"*): 7352 obs of 561 variables

    The training dataset.

* `y_train` (*"train/y_train.txt"*): 7352 obs of 1 variable

    The training data activity code and labels (1-6).

### **Step 3: Merge the training and test datasets to create one dataset & Uses descriptive acitivty names to name the activites in the dataset**
* `train`: 7352 obs of 563 variables
    
    `subject_train`, `y_train`, and `x_test` are combined using the *`cbind()`* command.
* `test`: 2947 obs of 563 variables

    `subject_test`, `y_test`, and `x_test` are combined using the *`cbind()`* command.
* `merged`: 10299 obs of 563 variables

    `train` and `test` are appended using the *`rbind()`* command.
* `merged2`: 10299 obs of 564 variables

    `merged` and `activity_label` are combined to include the descriptive activity names instead of less-interpretable activity code (1-6).

*Note: all the intermediate datasets are removed from the memory, the only dataset is `merged2`* 

### **Step 4: Extracts only the measurements on the mean and standard deviation for each measurement**
* `final`: 10299 obs of 89 variables

    This dataset is created by subsetting the `merged2` dataset, selecting only the following columns: **subject**, **code**, **activity_label**, and the measurements contain either **`mean`** or **`std`**.

### **Step 5: Appropriately labels the dataset with descriptive variable names**
* In the column's name, `Acc` is replaced with `Accelerometer`.
* In the column's name, `Gyro` is replaced with `Gyroscope`.
* In the column's name, `Mag` is replaced with `Magnitude`.
* In the column's name, `BobyBody` is replaced with `Body`.
* In the column's name, `mean` is replaced with `Mean`.
* In the column's name, `std` is replaced with `STD`.
* In the column's name, `Freq` is replaced with `Frequency`.
* In the column's name, `angle` is replaced with `Angle`.
* In the column's name, `gravity` is replaced with `Gravity`.
* In the column's name, if the first character is `t`, it is replaced with `Time`.
* In the column's name, if the first character is `f`, it is replaced with `Frequency`.
* In the column's name, all the `"."` are removed.

### **Step 6: From the dataset in Step 4, creates a second, independent tidy dataset with the average of each variable for each activity and each subject**
* `final2`: 180 obs of 89 variables

    This dataset is created by summarizing the mean of the each measurement column in the `final` dataset grouped by each subject and each activity.
* `Clean_data.txt`: the clean dataset is exported by the `write.table` command.