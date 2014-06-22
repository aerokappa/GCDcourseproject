#
#  Read all the relevant data files
#

features <- read.table("../UCI HAR Dataset/features.txt",
                       colClasses=c("NULL","character"),
                       col.names=c(NA,"features"))

if (!exists("trainData")) {
        trainData <- read.table("../UCI HAR Dataset/train/X_train.txt",
                                col.names=features$features)        
}

if (!exists("testData")) {
        testData <- read.table("../UCI HAR Dataset/test/X_test.txt",
                                col.names=features$features)        
}

trainLabels <- read.table("../UCI HAR Dataset/train/y_train.txt",col.names=c("ActivityLabel"),colClasses=c("integer"))
trainSubjects <- read.table("../UCI HAR Dataset/train/subject_train.txt",col.names=c("Subject"))

testLabels <- read.table("../UCI HAR Dataset/test/y_test.txt",col.names=c("ActivityLabel"),colClasses=c("integer"))
testSubjects <- read.table("../UCI HAR Dataset/test/subject_test.txt",col.names=c("Subject"))

activityLabels <- read.table("../UCI HAR Dataset/activity_labels.txt",colClasses=c("NULL","character"),col.names=c(NA,"activity"))

#
#  Col bind and Row bind to merge the data
#

allData <- rbind(cbind(trainData,trainSubjects,trainLabels),cbind(testData,testSubjects,testLabels))

#
#  Identify required elements of cleaned up data set
#

meanFeatures <- grep("mean\\(\\)",features$features,ignore.case=TRUE)
stdFeatures <- grep("std\\(\\)",features$features,ignore.case=TRUE)
subj_n_label <- c("Subject","ActivityLabel")

#
#  Reshaping data
#
tidyData <- allData[,c(names(allData)[meanFeatures],
                              names(allData)[stdFeatures]
                              ,subj_n_label)]

#
#  Giving meaningful activity names
#
tidyData$ActivityLabel <- activityLabels[tidyData$ActivityLabel,]

#
# create final data set with average of each variable for each activity and subject
#
actvSubjSplit <- split(tidyData,interaction(tidyData$ActivityLabel,tidyData$Subject))

colMeanFunction <- function(x) apply(x[,1:66],2,mean)

finalDataAsMatrix <- sapply(actvSubjSplit,colMeanFunction)

finalData <- as.data.frame(t(finalDataAsMatrix))

finalData$ActivityLabel <- rep(sort(activityLabels$activity),times=30)
finalData$Subject <- rep(1:30,each=6)

#
#  Write the pretty data file!
#
write.csv(finalData[,c(68,67,1:66)],file="summarizedTidyData.csv",row.names=FALSE)