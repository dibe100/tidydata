# tidydata


    Merges the training and the test sets to create one data set.
    
1. files are read and data is inserted in objects.
2. Then variables are join with rbind and inserted in a dataframe.

    Extracts only the measurements on the mean and standard deviation for each measurement.
    
1. Variables Mean and Standard deviation are obtained and inserted in a DataSet_measures_mean_std object.
    
    Uses descriptive activity names to name the activities in the data set
1. Variables are renamed with the label contained in activity_labels.txt

    Appropriately labels the data set with descriptive variable names.
    
 1. All varaibles are renamed with apropiate names
 
    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    
 1. New data set is created through write.table function. 
