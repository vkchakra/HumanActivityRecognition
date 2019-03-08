
# Download Data

filename <- "Coursera_DS3_Final.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Read and convert  Data

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")




# 1. Merge the Training and Testing Sets into 1 data set called data.all

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

# 2. Extract only the measurements on the mean and standard deviation for each measurement.

sdData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))


#3: Use descriptive activity names to name the activities in the data set.

sdData$code <- activities[sdData$code, 2]


#4: Appropriately label the data set with descriptive variable names.

names(sdData)[2] = "activity"
names(sdData)<-gsub("Acc", "Accelerometer", names(sdData))
names(sdData)<-gsub("Gyro", "Gyroscope", names(sdData))
names(sdData)<-gsub("BodyBody", "Body", names(sdData))
names(sdData)<-gsub("Mag", "Magnitude", names(sdData))
names(sdData)<-gsub("^t", "Time", names(sdData))
names(sdData)<-gsub("^f", "Frequency", names(sdData))
names(sdData)<-gsub("tBody", "TimeBody", names(sdData))
names(sdData)<-gsub("-mean()", "Mean", names(sdData), ignore.case = TRUE)
names(sdData)<-gsub("-std()", "STD", names(sdData), ignore.case = TRUE)
names(sdData)<-gsub("-freq()", "Frequency", names(sdData), ignore.case = TRUE)
names(sdData)<-gsub("angle", "Angle", names(sdData))
names(sdData)<-gsub("gravity", "Gravity", names(sdData))

#Step 5: From the data set in step 4, create a second, independent sd data set with the average of each variable for each activity and each subject.

Result <- sdData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(Result, "Result.txt", row.name=FALSE)
