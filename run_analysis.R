## This is the project Assignment for Month 3 
## Tim Margraf 3/10/2019
library(stringr)
library(stats)
library(data.table)
library(RMySQL)
library(sqldf)
library(dplyr)
library(quantmod)

## setwd("C:/Users/t15bxn8/Desktop/DataSciences/Projects/Month3Week4Project")


mergeDataSets <- function()
{
  trainSet <- read.table("X_train.txt", colClasses = "numeric")
  testSet <- read.table("X_test.txt", colClasses = "numeric")
  trainSetActivities <- read.table("Y_train.txt", colClasses = "character")
  testSetActivities <- read.table("Y_test.txt", colClasses = "character")
  trainSubjects <- read.table("subject_train.txt", colClasses = "numeric")
  testSubjects <- read.table("subject_test.txt", colClasses = "numeric")
  combinedSubjects <- rbind(trainSubjects,testSubjects)
  combinedSet <- rbind(trainSet,testSet)
  combinedSet <- cbind(combinedSubjects, combinedSet)
  combinedActivitySet <- rbind(trainSetActivities,testSetActivities)
  columnNames <- read.table("features.txt", colClasses="character")
  activities <- read.table("activity_labels.txt", colClasses = c("numeric", "character"))
  Activity <- c(length(combinedSet))
  
  columnNameVector <- c("Subject", columnNames[2]$V2) ## set the column names to values
  ## Before assigning column names, need to figure out what's wrong with these column names and result in errors when running select()
  
  ## Eliminate bad chars
  columnNameVector <- gsub(",","",columnNameVector)
  columnNameVector <- gsub("\\(","",columnNameVector)
  columnNameVector <- gsub("\\)","",columnNameVector)
  columnNameVector <- gsub("-","",columnNameVector)
  
  ## There are dupes!!!!!!!!!!!!!  Remove them so that the select() function will not fail
  ## Remove dupes by appending a column number at the end of each column name
  for (i in numbers<-c(1:561))
  {
    columnNameVector[i] <- paste(columnNameVector[i], "_", i,sep="")
    columnNameVector[i] <- gsub("^f", "The Frequency of ", columnNameVector[i])
    columnNameVector[i] <- gsub("^t", "The Time for ", columnNameVector[i])
    columnNameVector[i] <- gsub("^angle", "The Angle of ", columnNameVector[i])
    columnNameVector[i] <- gsub("mean", " (The mean of) ", columnNameVector[i])
    columnNameVector[i] <- gsub("std", " (The standard deviation of) ", columnNameVector[i])
  }
  
  names(combinedSet) <- columnNameVector  ## set the column names to values from features file
  
  for (i in activities$V1)  ## Create a vector of row names related to the activity of that sample (row)
  {
    for (j in c(1:length(combinedActivitySet$V1)))
      if (i == combinedActivitySet$V1[j])
      {
        combinedActivitySet$V1[j] <- paste(activities$V2[i], "_", as.character(j), sep="")
        Activity[j] <- activities$V2[i]
      }
  }
  combinedSet <- cbind(Activity, combinedSet)
  
  rownames(combinedSet) <- combinedActivitySet$V1  ## set the rows to describe the activity for that
  
  trimmedSet <- select(combinedSet, contains("Activity"), contains("SUbject"), contains("mean"), contains("standard deviation"))

  return(trimmedSet)
}

generateFinalDataSet <- function()
{
  trimmedDataSet <- mergeDataSets()
  
  activities <- read.table("activity_labels.txt", colClasses = c("numeric", "character"))
  activityNames <- activities$V2
  subjects <- trimmedDataSet$Subject_1
  subjects <- distinct(data.table(subjects))
  subjects <- c(subjects$subjects)
  
  
########  NEED TO BUILD OUT THE FINAL DATA SET STRUCTURE, THEN START ADDING TO IT IN THE LOOP  
  
  FinalDataSet <- data.frame(stringsAsFactors = FALSE)
  
  count = 0
  for(activity in activityNames)
  {
    for(subject in subjects)
    {
      rowWithAverages <- c(activity, subject)
##      count <- count+1
##      print(count)
      tempDataSet <- trimmedDataSet[trimmedDataSet$Subject_1 == subject,]  ## trim further to only use this subject
      tempDataSet <- tempDataSet[tempDataSet$Activity == activity,]  ## trim further to only include this activity
      tempDataSet <- select(tempDataSet, contains("mean"), contains("standard deviation"))  ## take out 2 extra columns
      ### FOR LOOP TO BUILD THE AVERAGES BY COLUMN NAMES AND ADD THEM TO A ROW IN FinalDataSet
      mean1 <- mean(as.numeric(tempDataSet[[4]]))
      for(i in 1:length(tempDataSet))
      {
        rowWithAverages[i+2] <- mean(as.numeric(tempDataSet[[i]]))
      }
      FinalDataSet <- rbind(FinalDataSet, rowWithAverages)
      if(count==0)
        FinalDataSet <- data.frame(lapply(FinalDataSet, as.character), stringsAsFactors=FALSE)
      count <- count+1
    }
  }
  
  names(FinalDataSet) <- names(trimmedDataSet)
  write.table(FinalDataSet,file="FinalDataSet.txt",row.names = FALSE)
  
}