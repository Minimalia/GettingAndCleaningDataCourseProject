# GettingAndCleaningDataCourseProject
Getting and Cleaning data course project

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
OBJECTIVE
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

This submission is made for "Getting and Cleaning Data Course Project".
The objective of the R code provided in this repository is to obtain a tidy
data set after processing the data that can be downloaded from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This data was collected for the following Human Activity Recognition project:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The scripts should:

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names.
5. From the data set in step 4, create a second, independent tidy data set 
   with the average of each variable for each activity and each subject.

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
REPOSITORY OVERVIEW
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
Repository includes the following data:

- R scripts used for data set processing:
	- run_analysis.R
	- readInertialDataSet.R
	- readDataSetContent.R

- Output tidy data set after processing input data:
	- HumanActivityRecognitionSummaryTidyDataSet
	
- CODEBOOK that describe the variables of output tidy data set:
	- CODEBOOK.txt

- README file:
	- README.txt

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
PROCESS AND SCRIPTS DESCRIPTION
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

The process to obtain the output tidy data set is the following:
1.- Download and unzip the data set to your R working directory.

2.- Install the following packages if needed:

	  - data.table
	  
	  - dplyr
	  
3.- Download the following R scripts to R working directory:

	  - run_analysis.R
	  
	  - readInertialDataSet.R
	  
	  - readDataSetContent.R
	  
4.- Execute "run_analysis.R" that performs the following operations:
    
	  - Load required packages and source "readInertialDataSet.R"
	  and "readDataSetContent.R" functions

	  - Read test and training data using the functions:
	  
		- readInertialDataSet.R: reads activity, subject and variable data
			from the data set merging the information together in a single
			data.table object. Notice that execution time is higher because
			read.fwf function is used with buffer size set to 1 to avoid
			memory problems.

		- readDataSetContent.R: reads activity labels and variable names 
			used for properly naming the data set

	  - Merges test and training data in one data set
	  
	  - Extracts only measurements on the mean and standard deviation
	  
	  - Create a tidy data set that provides the average value of each variable
	  for every activity and subject.

	  - Saves the output data to a txt file using "write.table" with row.name = FALSE.
	  
	  - This script prints in R console information messages to be aware of
	  the current operation being performed.
	  
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
OUTPUT DESCRIPTION
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

"HumanActivityRecognitionSummaryTidyDataSet" is built using write.table.

The following code can be used to visualize the data in R after downloading 
the file to R working directory:

  	tidydata <- read.table("HumanActivityRecognitionSummaryTidyDataSet", header = TRUE)
  	View(tidydata)
