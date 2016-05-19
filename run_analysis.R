#0.1 Loading the Libraries
library(reshape2)
library(data.table)
library(dplyr)

#0.2 Getting the data
X_test <-  read.table("C:/Users/Bohrer/Documents/Coursera_Data_Science/Getting and Cleaning Data/Project/UCI HAR Dataset/test/X_test.txt")
Y_test <-  read.table("C:/Users/Bohrer/Documents/Coursera_Data_Science/Getting and Cleaning Data/Project/UCI HAR Dataset/test/Y_test.txt")
Subject_test <-  read.table("C:/Users/Bohrer/Documents/Coursera_Data_Science/Getting and Cleaning Data/Project/UCI HAR Dataset/test/subject_test.txt")

#Train data
X_train <-  read.table("C:/Users/Bohrer/Documents/Coursera_Data_Science/Getting and Cleaning Data/Project/UCI HAR Dataset/train/X_train.txt")
Y_train <-  read.table("C:/Users/Bohrer/Documents/Coursera_Data_Science/Getting and Cleaning Data/Project/UCI HAR Dataset/train/Y_train.txt")
Subject_train <-  read.table("C:/Users/Bohrer/Documents/Coursera_Data_Science/Getting and Cleaning Data/Project/UCI HAR Dataset/train/subject_train.txt")

features <-  read.table("C:/Users/Bohrer/Documents/Coursera_Data_Science/Getting and Cleaning Data/Project/UCI HAR Dataset/features.txt")
activity_labels <- read.table("C:/Users/Bohrer/Documents/Coursera_Data_Science/Getting and Cleaning Data/Project/UCI HAR Dataset/activity_labels.txt")

#0.3 Renaming the variables
colnames(X_train) <- features[,2]
colnames(X_test) <- features[,2]

#Merging the data

activity <- rbind(Y_train, Y_test) #this will be the activity column
colnames(activity) <- "Activity"

subject <- rbind(Subject_train, Subject_test)
colnames(subject) <- "Subject"

#Combining the train and test values for X
X_data <- rbind(X_train, X_test)
#Adding the subject and the activity
X_data <- cbind(subject,activity, X_data)

################
#2 Extracting the Mean and SD

columns <- grep(".*Mean.*|.*Std.*", names(X_data), ignore.case=TRUE)
Mean_SD <- X_data[,columns]
#3 Naming the activities in the data set

X_data$Activity <- as.character(X_data$Activity)
for (i in 1:6){
  X_data$Activity[X_data$Activity == i] <- as.character(activity_labels[i,2])
}


#4 Descriptive variable names
names(X_data)<-gsub("std()", "SD", names(X_data))
names(X_data)<-gsub("mean()", "MEAN", names(X_data))
names(X_data)<-gsub("^t", "time", names(X_data))
names(X_data)<-gsub("^f", "frequency", names(X_data))
names(X_data)<-gsub("Acc", "Accelerometer", names(X_data))
names(X_data)<-gsub("Gyro", "Gyroscope", names(X_data))
names(X_data)<-gsub("Mag", "Magnitude", names(X_data))
names(X_data)<-gsub("BodyBody", "Body", names(X_data))

#5 Form a tidy data set
X_data$Subject <- as.factor(X_data$Subject)
Tidy <- aggregate(. ~Subject + Activity, X_data, mean)
write.table(Tidy, file = "Tidy.txt", row.names = FALSE)
