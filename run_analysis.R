# -----------------------------------------------------------------------------
# SCRIPT for COURSE PROJECT
# -----------------------------------------------------------------------------
# Name: run_analysis
# Author: Student of Getting and Cleaning data (Coursera)
# Packages required: data.table, dplyr
# Detailed description of the steps in the body of the script

# -----------------------------------------------------------------------------
# Script initialization
# -----------------------------------------------------------------------------

# Load required packages:
library(data.table)
library(dplyr)

# Load required scripts:
source('readInertialDataSet.R')
source('readDataSetContent.R')

# -----------------------------------------------------------------------------
# Step 0:
# Reads Human Activity Recognition Using Smartphones data set from working 
# directory
# -----------------------------------------------------------------------------

print("Reading data...")

# Path and folders of training and test data sets:
dataPath = paste(getwd(),"UCI HAR Dataset",sep = "/")
folders <- list("test","train")

# List containing test and training data sets is obtained
# using "readInertialdata" function:
dataSetList <- lapply(folders,readInertialDataSet,dataPath)

# List containing feature and activities IDs and names 
# is obtained using "readDataSetContent" function:
dataSetDesc <- readDataSetContent(dataPath)

print("Data read. Starting analysis...")

# -----------------------------------------------------------------------------
# Step 1: 
# Merges the training and the test sets to create one data set
# -----------------------------------------------------------------------------

# Both elements of the list are combined:
dataSet <- rbind(dataSetList[[1]],dataSetList[[2]])


# -----------------------------------------------------------------------------
# Step 2 (it is Step 2 and part of Step 4 of Coursera instructions):
# Extracts only the measurements on the mean and standard deviation 
# for each measurement by labeling first the data set with descriptive variable
# names.
# -----------------------------------------------------------------------------

# Provide features name to data set:
names(dataSet) <- c("subjectid", "activityid",as.character(dataSetDesc[[1]]$feature))

# Select only features with mean() or std() as according to "features_info",
# they contain the mean and std of the signals processed:
subset <- select(dataSet, matches(("subjectid|activityid|mean\\(\\)|std\\(\\)")))

# -----------------------------------------------------------------------------
# Step 3:
# Uses descriptive activity names to name the activities in the data set
# -----------------------------------------------------------------------------

# Activity name is obtained through merging the information of "activity_labels"
# with data set using "activityid":
subset <- merge(dataSetDesc[[2]], subset, by = intersect(names(subset),names(dataSetDesc[[2]])))

# -----------------------------------------------------------------------------
# Step 4:
# Labels data set with descriptive variable names was done in Step 2.
# In order to finish our tidy data set, it is converted from wide data set
# to long and narrow data set with the following columns (optional step):
# activityid, activity, subjectid, variable and value
# -----------------------------------------------------------------------------

# Set key on activityid, activity and subjectid:
setkey(subset, activityid, activity, subjectid)

# From wide data set to long and narrow data set using key:
tidyData <- data.table(melt(subset, key(subset), variable.name="variable"))

# -----------------------------------------------------------------------------
# Step 5:
# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
# -----------------------------------------------------------------------------

# Copy the data of the tidy data set of Step 4:
tidySummaryData <- tidyData

# Groups by activity, subjectid and variable:
tidySummaryData <- group_by(tidySummaryData, activity)
tidySummaryData <- group_by(tidySummaryData, subjectid, add=TRUE)
tidySummaryData <- group_by(tidySummaryData, variable, add=TRUE)

# Summarize to obtain the average for these groups:
tidySummaryData <- summarize(tidySummaryData, average = mean(value))

# -----------------------------------------------------------------------------
# Outputs:
# Write.table is used to save the tidy data sets from Step 5.
# -----------------------------------------------------------------------------

# Line to save the output into a file:
write.table(tidySummaryData, file = "HumanActivityRecognitionSummaryTidyDataSet",row.name=FALSE)

print("End of the analysis")

## Code for reading output:
# tidydata <- read.table("HumanActivityRecognitionSummaryTidyDataSet", header = TRUE)
# View(tidydata)