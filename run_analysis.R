library(dplyr)
library(tidyr)

# 
# create data directory and download original dataset if necessary
#
if (!file.exists("./data")) {
    dir.create("./data")
}
zipfile <- "./data/UCI HAR Dataset.zip"
if (!file.exists(zipfile)) {
    download.file(
        url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
        method="curl", destfile=zipfile
    )
    unzip(zipfile, exdir="./data")
}

#
# Read and load original dataset
#
featureNames <- read.table("./data/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)[[2]]
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt",
                             col.names=c("activityNum", "activity"))
# training data
xTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt", col.names=c("activityNum"))
subjTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",
                        col.names=c("subjectId"))
# test data
xTest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("./data/UCI HAR Dataset/test/y_test.txt", col.names=c("activityNum"))
subjTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",
                        col.names=c("subjectId"))

#
# Merge the training and test sets
#
combined <- rbind(xTrain, xTest)
colnames(combined) <- featureNames
rm(xTrain, xTest)

#
# Extract mean and standard deviation for each measurement
#
meanOrStdCols <- featureNames[grepl("mean\\()|std\\()", featureNames)]
combined <- combined[, meanOrStdCols]

#
# Merge in activity and subject ids. Use descriptive names
#
activityCol <- merge(rbind(yTrain, yTest), activityLabels, 
                     by="activityNum", sort=FALSE)[["activity"]]
combined["activity"] <- sub("_", " ", tolower(activityCol))
combined["subjectId"] <- rbind(subjTrain, subjTest)

#
# Create new dataset with the average for each variable for each activity and each subject
#
summaryData <- gather(combined, variable, value, -activity, -subjectId)
summaryData <- group_by(summaryData, activity, subjectId, variable)
summaryData <- summarize(summaryData, value=mean(value))
summaryData <- rename(summaryData, mean=value)
write.table(summaryData, "./data/UCI_HAR_summary.txt", row.names=FALSE)






