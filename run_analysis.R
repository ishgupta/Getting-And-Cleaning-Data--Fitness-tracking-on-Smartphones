#Read the data

testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt")

activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

testActivities <- read.table("./UCI HAR Dataset/test/y_test.txt")
trainActivities <- read.table("./UCI HAR Dataset/train/y_train.txt")

testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")

trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")

features <- read.table("./UCI HAR Dataset/features.txt")

#Uses descriptive activity names to name the activities in the data set
trainActivities$V1 <- factor(trainActivities$V1, levels = activities$V1, labels=activities$V2)
testActivities$V1 <- factor(testActivities$V1, levels = activities$V1, labels=activities$V2)


#Appropriately labels the data set with descriptive variable names. 
colnames(testSubjects) <- c("Subject")
colnames(trainSubjects) <- c("Subject")
colnames(trainActivities) <- c("Activity")
colnames(testActivities) <- c("Activity")

colnames(testData) <- features$V2
colnames(trainData) <- features$V2

#Merges the training and the test sets to create one data set.
testData <- cbind(testData, testActivities)
trainData <- cbind(trainData, trainActivities)
trainData <- cbind(trainData, trainSubjects)
testData <- cbind(testData, testSubjects)
data <- rbind(trainData, testData)

#Extracts only the measurements on the mean and standard deviation for each measurement
data_mean <- sapply(data, mean, na.rm = TRUE)
data_sd <- sapply(data,sd,na.rm=TRUE)

#From the data set in step 4, creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject.
dataInTable <- data.table(data)
tidyData <- dataInTable[,lapply(.SD, mean), by="Activity,Subject"]
write.table(tidyData, file="tidyData.txt", sep="\t")
