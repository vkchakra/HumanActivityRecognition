The run_analysis.R script performs the following steps

Preparatory step 1 -> Download the dataset
Dataset downloaded and extracted under the folder called UCI HAR Dataset

Preparatory step 2 -> Assign each data to variables
features <- features.txt : 561 rows, 2 columns 
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
activities <- activity_labels.txt : 6 rows, 2 columns 
List of activities performed when the corresponding measurements were taken and its codes (labels)
subject_test <- test/subject_test.txt : 2947 rows, 1 column 
contains test data of 9/30 volunteer test subjects being observed
x_test <- test/X_test.txt : 2947 rows, 561 columns 
contains recorded features test data
y_test <- test/y_test.txt : 2947 rows, 1 columns 
contains test data of activities�code labels
subject_train <- test/subject_train.txt : 7352 rows, 1 column 
contains train data of 21/30 volunteer subjects being observed
x_train <- test/X_train.txt : 7352 rows, 561 columns 
contains recorded features train data
y_train <- test/y_train.txt : 7352 rows, 1 columns 
contains train data of activities�code labels

Step1 -> Merges the training and the test sets to create one data set
X (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
Y (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
Subject (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function
Merged_Data (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function

Step2 -> Extracts only the measurements on the mean and standard deviation for each measurement
sdData (10299 rows, 88 columns) is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

Step3 -> Uses descriptive activity names to name the activities in the data set
Numbers in code column of the sdData are replaced with corresponding activity taken from second column of the  activities variable

Step4 -> Appropriately labels the data set with descriptive variable names
code column in sdData renamed into activities
Acc in column�s name replaced by Accelerometer
Gyro in column�s name replaced by Gyroscope
BodyBody in column�s name replaced by Body
Mag in column�s name replaced by Magnitude
text starting with f in column�s name replaced by Frequency
text starting with t in column�s name replaced by Time

Step5 -> From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
Dataset Result (180 rows, 88 columns) is created by sumarizing sdData taking the average of each variable for each activity and each subject
The resultant dataset created by following all the steps above is stored within file ResultData.txt 