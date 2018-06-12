# GettingCleaningDataset
This project contains files for the "Getting and Cleaning Data" course project.
The goal of the project is to clean and summarize the [UCI Human Activity 
Recognition Using Smartphones Data Set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

## Project Contents
1. README.md
1. run_analysis.R
1. CodeBook.md
1. UCI_HAR_summary.txt

### run_analysis.R
This R script performs the following:
* Downloads and extracts the original data set to "./data"
* Merges that loaded training and test data
* Subsets and tidies the data by descriptive labeling and extracting only mean and standard deviation measurements
* Create new tidy dataset that summarizes the average of each variable for each activity and each subject

Software versions used:
* R 3.4.4
* dplyr 0.7.5
* tidyr 0.8.1

### CodeBook.md
The codebook describes the contents of the new dataset.

### UCI_HAR_summary.txt
New dataset created by run_analysis.R







