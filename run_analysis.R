#download zipfile for data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "UCI HAR Dataset.zip"
#download dataset
if(!file.exists(filename)){
    download.file(fileUrl,filename,mode = "wb")
}
#unzip data set
projectdata <- "UCI HAR Dataset"
if(!file.exists(projectdata)){
    unzip(filename)
}
#reading training data
subTrain <- read.table(paste0(projectdata,"/train/subject_train.txt"))
xTrain <- read.table(paste0(projectdata,"/train/X_train.txt"))
yTrain <- read.table(paste0(projectdata,"/train/y_train.txt"))
#reading testing data
subTest <- read.table(paste0(projectdata,"/test/subject_test.txt"))
xTest <- read.table(paste0(projectdata,"/test/X_test.txt"))
yTest <- read.table(paste0(projectdata,"/test/y_test.txt"))
#reading feature data: do not transfer V2 to factor
feature <- read.table(paste0(projectdata,"/features.txt"),as.is = T)
names(feature) <- c("ID","label")
#reading activity data
activity <- read.table(paste0(projectdata,"./activity_labels.txt"))
names(activity) <- c("ID","label")
#combinning data
trainData <- cbind(subTrain,xTrain,yTrain)
testData <- cbind(subTest,xTest,yTest)
allData <- rbind(trainData,testData)
#rename the whole data set
names(allData) <- c("subject",feature$label,"activity")
#subset data
allData <- allData[,grepl("subject|activity|mean|std",names(allData))]
#update correct activity names
allData$activity <- activity[allData$activity, 2]
#rename allData variables
names(allData) <-gsub("^t", "time", names(allData))
names(allData) <-gsub("^f", "frequency", names(allData))
names(allData) <-gsub("Acc", "Accelerometer", names(allData))
names(allData) <-gsub("Gyro", "Gyroscope", names(allData))
names(allData) <-gsub("Mag", "Magnitude", names(allData))
names(allData) <-gsub("BodyBody", "Body", names(allData))
#final data
library(dplyr)
finalData <- allData %>% 
    group_by(subject,activity) %>%
    summarise_each(funs(mean))
#out put data
write.table(finalData, "tidy.txt", row.names = FALSE, quote = FALSE)
