# Getting and Cleaning Data

## Course Project

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Repository Files

README.md: this file
run_analysis.R: R script to transform raw data set in a tidy one
CodeBook.md: information about raw and tidy data set and elaboration made to transform them
tidydata.txt : the clean data extracted from the original data using run_analysis.R


## Basic Assumption
The R code in run_analysis.R proceeds under the assumption that the zip file available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip is downloaded and extracted into a folder "data" in the R Home Directory: 
R_Home_Directory/data

## Steps to work on this course project
After you download and unzip that file,
Run `source("run_analysis.R")`, then it will generate a new file  `tidydata.txt` in your working directory.

## Libraries Used

library(data.table)
library(dplyr)
