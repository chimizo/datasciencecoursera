#You should create one R script called run_analysis.R that does the following.

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#script

#activating libraries
library(plyr)
library(data.table)
library(lubridate)
library(tidyr)

# 1. Merges the training and the test sets to create one data set

#defining data

setwd("C:/Users/Andre/Desktop/UCI HAR Dataset/")

x_train <- read.table("./train/X_train.txt", header = FALSE)
x_test <- read.table("./test/X_test.txt", header = FALSE)
y_train <- read.table("./train/y_train.txt", header = FALSE)
y_test <- read.table("./test/y_test.txt", header = FALSE)
subject_train <- read.table("./train/subject_train.txt", header = FALSE)
subject_test <- read.table("./test/subject_test.txt", header = FALSE)
features <- read.table("./features.txt",header=FALSE)
activity_labels <- read.table("./activity_labels.txt",header=FALSE)
  colnames(activityLabel)<-c("activityId","activityType")

#merging
train <- rbind(x_train, y_train)
test <- rbind(x_test, y_test)
subject <- rbin(subject_train, subject_test)
x <- rbind(x_train, X_test)
y <- rbind(y_train, y_test)
all_data <- rbind(x_train, y_train, x_test, y_test, subject_train, subject_test)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
mean_stdv <- all_data(,grepl("mean|std|subject|activityId",colnames(all_data)))


# 3. Uses descriptive activity names to name the activities in the data set
mean_stdv <- join(mean_stdv, activity_labels, match = "first", by = "activityId")
mean_stdv <-data_mean_std[,-1]

# 4. Appropriately labels the data set with descriptive variable names.
names(mean_stdv) <- gsub("\\(|\\)", "", names(mean_stdv), perl  = TRUE)
names(mean_stdv) <- trim(mean_stdv)
names(mean_stdv) <- make.names(names(mean_stdv))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyData <- aggregate(all_data, mean)
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)
