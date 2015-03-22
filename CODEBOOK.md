# Getting and Cleaning Data Course Project
## author: "adraike"

### Project Purpose
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

### Source Data
A full description of the data used in this project can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The data must be downloaded and expanded in the root directory where the R script is ran. (./UCI HAR Dataset)

[The source data for this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Variables
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- Time and frequency domain variables. 
- Activity label. 
- Subject identifier for the subject who carried out the experiment.

### Steps to create the project:
#### Step 1. Merge the training and the test sets to create one data set.

The data must be downloaded and expanded in the root directory where the R script is ran and set the source directory for the files.

Read the following data into tables: 
- features.txt
- activity_labels.txt
- subject_train.txt
- X_train.txt
- y_train.txt
- subject_test.txt
- X_test.txt
- y_test.txt

Assign names to each column and merge the (datatable_1 and datatable_2) tables to create one data set (datatable_3).

#### Step 2. Extract only the measurements on the mean and standard deviation for each measurement. 

The values for the variables are kept per assignment instructions:

* mean(): Mean value
* std(): Standard deviation

Create a logcal vector (logicalVector) that contains only the TRUE values for the ID, mean and stdev columns and FALSE values for the others.

#### Step 3. Use descriptive activity names to name the activities in the data set
Merge data subset with the activity_label table by activity_id.

#### Step 4. Appropriately label the data set with descriptive activity names.
Use gsub function for pattern replacement to clean up the data labels.

command usage: gsub(pattern, replacement, x, ignore.case = FALSE, perl = FALSE,fixed = FALSE, useBytes = FALSE)

#### Step 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
Using the aggregate and merge function to create a tidedata set with the mean of each variable per activity and subject.
Writes tidydataset that is command delimited into text file called tidydataset.csv.

