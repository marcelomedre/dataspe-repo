## Getting and Cleaning data project
###############################################################################
## Marcelo Medre Nobrega
## marcelo.medre@gmail.com
## 17/01/2017
###############################################################################

# The purpose of this project is to demonstrate your ability to collect, work with, 
# and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 
# You will be graded by your peers on a series of yes/no questions related to the project.
# You will be required to submit: 1) a tidy data set as described below, 2) a link to a 
# Github repository with your script for performing the analysis, and 3) a code book
# that describes the variables, the data, and any transformations or work that you 
# performed to clean up the data called CodeBook.md. You should also include a README.md
# in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

# One of the most exciting areas in all of data science right now is wearable computing -
# see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing
# to develop the most advanced algorithms to attract new users. The data linked to from 
# the course website represent data collected from the accelerometers from the Samsung 
# Galaxy S smartphone. A full description is available at the site where the data was obtained:
  
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Here are the data for the project:
  
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# You should create one R script called run_analysis.R that does the following.

# 1 - Merges the training and the test sets to create one data set.
# 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
# 3 - Uses descriptive activity names to name the activities in the data set
# 4 - Appropriately labels the data set with descriptive variable names.
# 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

getwd()
setwd("C:/Users/Marcelo/Desktop/Coursera/Project/dataspe-repo")
library(dplyr)
library(data.table)
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/GaCdProj.zip", method = "auto")
unzip("./data/GaCdProj.zip", exdir = "./data/Project")
list.files("./data/Project/UCI HAR Dataset/")

# 1 - Merges the training and the test sets to create one data set.
#### Reading the data set

# train files
x_train <- read.table("./data/Project/UCI HAR Dataset/train/X_train.txt") #import X_train data
y_train <- read.table("./data/Project/UCI HAR Dataset/train/y_train.txt") #import y_train data
subjecttrain <- read.table("./data/Project/UCI HAR Dataset/train/subject_train.txt") #import subject_train data

# test files
x_test <- read.table("./data/Project/UCI HAR Dataset/test/X_test.txt") #import X_test data
y_test <- read.table("./data/Project/UCI HAR Dataset/test/y_test.txt") #import y_test data
subjecttest <- read.table("./data/Project/UCI HAR Dataset/test/subject_test.txt") #import subject_test data

#Reading the features data
features <- read.table("./data/Project/UCI HAR Dataset/features.txt")

#Reading activity labels
activityLabels <-read.table("./data/Project/UCI HAR Dataset/activity_labels.txt") 

# Assigning column names
colnames(x_train) <- features[,2]
colnames(y_train) <- "activityId"
colnames(subjecttrain) <- "subjectId"

colnames(x_test) <- features[,2]
colnames(y_test) <- "activityId"
colnames(subjecttest) <- "subjectId"

colnames(activityLabels) <- c("activityId", "activityType")

# Merging the train data set
dataTrain <- cbind(subjecttrain,y_train,x_train)

# Merging the test data set
dataTest <- cbind(subjecttest,y_test,x_test)

# Merging train and test datasets
fullData <- rbind(dataTrain,dataTest)

###############################################################################
# 2 - Extracts only the measurements on the mean and standard deviation for each measurement.

# Creating a vector with the column names
colnames <- colnames(fullData)
# Creating a logical vector for mean and Sts using dot (.) 
# combined with mean and std for each element of the colnames
meanStd <- (grepl("subjectId", colnames)|
                    grepl("activityId", colnames)|
                    grepl(".*mean.*", colnames)|
                    grepl(".*std.*", colnames)
            )

# Extracting the corresponding TRUE columns from fullData

meanStdData <- fullData[,meanStd]       

###############################################################################
# 3 - Uses descriptive activity names to name the activities in the data set

FinalData <- merge(meanStdData,activityLabels, by = "activityId",
                      all.x = TRUE)

names(FinalData)

###############################################################################
# 4 - Appropriately labels the data set with descriptive variable names.

# Labelling properly
colNames2 <- colnames(FinalData)
colNames2 = gsub("[-()]", " ",colNames2)
colNames2 = gsub("std","StdDev",colNames2)
colNames2 = gsub("mean","Mean",colNames2)
colNames2 = gsub("^(t)","time",colNames2)
colNames2 = gsub("^(f)","freq",colNames2)
colNames2 = gsub("([Gg]ravity)","Gravity",colNames2)
colNames2 = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames2)
colNames2 = gsub("[Gg]yro","Gyroscope",colNames2)
colNames2 = gsub("Mag","Magnitude",colNames2)
colNames2 = gsub("Acc","Accelerometer",colNames2)

colnames(FinalData) = colNames2

# 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

newTidyData <- aggregate( .~ subjectId + activityType, FinalData, mean)
newTidyData <- newTidyData[order(newTidyData$subjectId),]
write.table(newTidyData, file = "./data/newTidyData.csv", row.names = TRUE,
            sep = ",")
