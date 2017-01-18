# Getting and Cleaning Data - Course Project
###Marcelo Nobrega

## Repo for submission of the course project for the Getting and Cleaning data course.

### This is the course project for the Getting and Cleaning Data Coursera course.
### The R script run_analysis.R does the following:
	1. Download the data set if it doesn't exist in the working directory
	2. Load train, test, features and activity labels
	3. Assign the column names to train and test files
	4. Merge train and test data sets creating the "fullData" matrix
	5. Extract the mean and std measurements from the "fullData" and creates a new matrix named meanStdData
	6. Name the activities in the meanStdData set by merging the meanStdData data set with activityLabels loaded in step 2
	7. Appropriately labels the final data set named FinalData
	8. Creates a second data set called newtidyData with the average values for each activity and subject
	9. Write a file containing the newTidyData set 
