library(plyr)

# 0. Read data from the files into the variables 
path_rf <- file.path("./data" , "UCI HAR Dataset")

## Read the Activity files, values of Varible Activity consist of data from “Y_train.txt” and “Y_test.txt”
dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)

## Read the Subject files, values of Varible Subject consist of data from “subject_train.txt” and subject_test.txt"
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"), header = FALSE)
dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)

## Read Features files, values of Varibles Features consist of data from “X_train.txt” and “X_test.txt”
dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)


# 1. Merges the training and the test sets to create one data set

##  Concatenate the data tables by rows
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

## set names to variables, Names of Varibles Features come from “features.txt”

names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2        

## Merge columns to get the data frame Data for all data
dataCombine <- cbind(dataSubject, dataActivity)
DataAll <- cbind(dataCombine, dataFeatures) 

# 2. Extracts only the measurements on the mean and standard deviation for each measurement

## Subset Name of Features by measurements on the mean and standard deviation
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

## Subset the data frame Data by seleted names of Features
selectedNames<-c("subject", "activity", as.character(subdataFeaturesNames))
Data<-subset(DataAll,select=selectedNames)

# 3. Uses descriptive activity names to name the activities in the data set

## Read descriptive activity names from “activity_labels.txt”
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)

## factorize Variale activity in the data frame Data using descriptive activity names
Data$activity <- as.character(Data$activity)
 for (i in 1:6){
   Data$activity[Data$activity == i] <- as.character(activityLabels[i,2])
 }
Data$activity <- as.factor(Data$activity)


# 4. Appropriately labels the data set with descriptive variable names
## In the former part, variables Activity and Subject and names of the activities have been labelled using descriptive names.
## In this part, Names of Features will labelled using descriptive variable names.
names(Data)<-gsub("^t", "time", names(Data))            ## prefix t is replaced by time
names(Data)<-gsub("^f", "frequency", names(Data))       ## prefix f is replaced by frequency
names(Data)<-gsub("Acc", "Accelerometer", names(Data))  ## Acc is replaced by Accelerometer
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))     ## Gyro is replaced by Gyroscope
names(Data)<-gsub("Mag", "Magnitude", names(Data))      ## Mag is replaced by Magnitude
names(Data)<-gsub("BodyBody", "Body", names(Data))      ## BodyBody is replaced by Body


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Aggregate the Data for Activity and each Subject, using Mean. Then write the table into a file

DataAggregate<-aggregate(. ~subject + activity, Data, mean)
DataAggregate<-DataAggregate[order(DataAggregate$subject,DataAggregate$activity),]
write.table(DataAggregate, file = "tidydata.txt", row.names=FALSE)
