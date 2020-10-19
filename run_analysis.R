setwd("E:/Dropbox/git-R/data_quiz_final_cleaning/UCI HAR Dataset")

library(plyr)
library(data.table)

# Read files from directory and save in objects
file_subject_train <- read.table('./train/subject_train.txt',header=FALSE)
file_train_x <- read.table('./train/x_train.txt',header=FALSE)
file_train_y <- read.table('./train/y_train.txt',header=FALSE)

file_subject_test <- read.table('./test/subject_test.txt',header=FALSE)
file_test_x <- read.table('./test/x_test.txt',header=FALSE)
file_test_y <- read.table('./test/y_test.txt',header=FALSE)

##1.Merges the training and the test sets to create one data set.

  DataSet_x <- rbind(file_train_x, file_test_x)
  DataSet_y <- rbind(file_train_y, file_test_y)
  DataSet_subject <- rbind(file_subject_train, file_subject_test)
  Data1<-data.frame(DataSet_x,DataSet_y, DataSet_subject)
  print(Data1)

##2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  
  DataSet_measures_mean_std <- DataSet_x[, grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2])]
  names(DataSet_measures_mean_std) <- read.table("features.txt")[grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2]), 2]
  print(DataSet_measures_mean_std)
  
## 3. Uses descriptive activity names to name the activities in the data set

DataSet_y[, 1] <- read.table("activity_labels.txt")[DataSet_y[, 1], 2]
names(DataSet_y) <- "Activities"
print(DataSet_y)

## 4. Appropriately labels the data set with descriptive variable names. 

DataSet_names <- cbind(DataSet_measures_mean_std, DataSet_y, DataSet_subject)
names(DataSet_names) <- make.names(names(DataSet_names))
names(DataSet_names) <- gsub('Acc',"Acceleration",names(DataSet_names))
names(DataSet_names) <- gsub('GyroJerk',"AngularAcceleration",names(DataSet_names))
names(DataSet_names) <- gsub('Gyro',"AngularSpeed",names(DataSet_names))
names(DataSet_names) <- gsub('Mag',"Magnitude",names(DataSet_names))
names(DataSet_names) <- gsub('^t',"TimeDomain.",names(DataSet_names))
names(DataSet_names) <- gsub('^f',"FrequencyDomain.",names(DataSet_names))
names(DataSet_names) <- gsub('\\.mean',".Mean",names(DataSet_names))
names(DataSet_names) <- gsub('\\.std',".StandardDeviation",names(DataSet_names))
names(DataSet_names) <- gsub('Freq\\.',"Frequency.",names(DataSet_names))
names(DataSet_names) <- gsub('Freq$',"Frequency",names(DataSet_names))
print(DataSet_names)

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
names(DataSet_names)
Data_Independently<-aggregate(. ~V1 + Activities, DataSet_names, mean)
Data_Independently<-Data_Independently[order(Data_Independently$V1,Data_Independently$Activities),]
write.table(Data_Independently, file = "New_data_set_tidy.txt",row.name=FALSE)
