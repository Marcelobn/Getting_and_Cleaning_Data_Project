# Getting and Cleaning Data - Course Project

Task:
You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

How to use this script.
First download the data (see CodeBook) and save it into your local drive.
Put run_analysis.R into the apropriate folder with help of the setwd(), getwd() functions.
Run run_analysis.R

The script requires the use of reshape2, data.table and dyplr. Which will be automatically loaded if installed.
