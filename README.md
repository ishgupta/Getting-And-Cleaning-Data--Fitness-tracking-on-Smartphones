

The data set for this experiment located at UCI Machine Learning is available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R file fetches the data (after it is downloaded to disk), reads it and merges different data sets together to combine the information of the Activities, and Subjects along with the data collected from Experiments. This helps in understanding which Subject had done what kind of physical activity as per the type of Activity(Standing, Walking etc.)

CodeBook gives a very brief description about the experiment done, and the details of what the data set would include.

The data set as described contains the final data for findings in X_test.txt, and X_train.txt.

The 5 activities have been coded in numbers from 1 to 5 as mentioned in the "activity_labels.txt".

The files, y_train.txt, and t_test.txt contains the Column containing data about the activities carried out while recording all the activities in the Experiment.

subject_train.txt, and subject_test.txt provides data about all of the 30 subjects who participated in the Experiment.

features.txt provides all the calculations done on the data collected from experiments, and comprises 561 type of calculations done on Data.

All of these above mentioned data are segregated but exactly map with each other.

The run_analysis.R file starts with:
1. reading the data provided in X_test.txt, and X_train.txt, and then proceeds with extracting all the other data sets for Activities, Subjects. 


testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt")

activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

testActivities <- read.table("./UCI HAR Dataset/test/y_test.txt")
trainActivities <- read.table("./UCI HAR Dataset/train/y_train.txt")

testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")

trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")

features <- read.table("./UCI HAR Dataset/features.txt")

2. Evaluate the name of Activities from the activity_labels.txt, and map it to the training and tetsing activities

#Uses descriptive activity names to name the activities in the data set
trainActivities$V1 <- factor(trainActivities$V1, levels = activities$V1, labels=activities$V2)
testActivities$V1 <- factor(testActivities$V1, levels = activities$V1, labels=activities$V2)

3. Label the Data set 

#Appropriately labels the data set with descriptive variable names. 

colnames(testSubjects) <- c("Subject")
colnames(trainSubjects) <- c("Subject")
colnames(trainActivities) <- c("Activity")
colnames(testActivities) <- c("Activity")

colnames(testData) <- features$V2
colnames(trainData) <- features$V2

4. Merge the data to form a complete set.

#Merges the training and the test sets to create one data set.

testData <- cbind(testData, testActivities)
trainData <- cbind(trainData, trainActivities)
trainData <- cbind(trainData, trainSubjects)
testData <- cbind(testData, testSubjects)

data <- rbind(trainData, testData)

5. Extract the data as required:

#Extracts only the measurements on the mean and standard deviation for each measurement
data_mean_sd <- data[,c(grep("[Mm]ean.)|std.)", names(data)),562,563)]

6. Write final data into a file:

#From the data set in step 4, creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject.
tidyData <- aggregate(data_mean_sd[,1:66], data_mean_sd[,67:68], mean)
write.table(tidyData, file="tidyData.txt", sep="\t", row.names=FALSE)
