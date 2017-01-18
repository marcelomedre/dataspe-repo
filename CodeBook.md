# Code Book

## Variables
 - x_train, y_train, subjecttrain are the train data files downloaded files.
 - x_test, y_test, subjecttest are the test data files downloaded files.
 - features is the data from features.txt file and contains the names of the variables.
 - acitivityLabels is the loaded data from activity_labels.txt file and contains the code and names of the activities.
 - subject_train and subject_test contain the data from the downloaded files.
 - fullData merges the train and test datas
 - meanStdData subsets the fullData extracting only the mean and std measurements.
 - FinalData contains the activity names of the data set
 - newTidyData contains the relevant averages data ordered by subject
