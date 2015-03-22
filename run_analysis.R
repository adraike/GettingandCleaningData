###############################################################################################
# R script performs the following tasks: 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average
#    of each variable for each activity and each subject.
###############################################################################################

setwd("~/R/GettingandCleaningData/UCI HAR Dataset")

# Step 1. Merge the training and the test sets to create one data set.

# Load the raw files for dataset 1
features = read.table('./features.txt',header=FALSE); 
activity_label = read.table('./activity_labels.txt',header=FALSE); 
subject_train = read.table('./train/subject_train.txt',header=FALSE); 
x_train = read.table('./train/X_train.txt',header=FALSE); 
y_train = read.table('./train/y_train.txt',header=FALSE); 

# Assign column names to dataset 1
colnames(activity_label) = c('activity_id','activity_label');
colnames(subject_train) = "subject_id";
colnames(x_train) = features[,2]; 
colnames(y_train) = "activity_id";

dataset_1 = cbind(y_train,subject_train,x_train);

# Load the raw files for dataset 2
subject_test = read.table('./test/subject_test.txt',header=FALSE); 
x_test = read.table('./test/X_test.txt',header=FALSE); 
y_test = read.table('./test/y_test.txt',header=FALSE); 

# Assign column names
colnames(subject_test) = "subject_id";
colnames(x_test) = features[,2]; 
colnames(y_test) = "activity_id";

dataset_2 = cbind(y_test,subject_test,x_test);


# dataset_1 + dataset_2 = dataset_3
dataset_3 = rbind(dataset_1,dataset_2);

# dataset 3 column names to vector
colNames  = colnames(dataset_3); 

# Step 2. Extract only the measurements on the mean and standard deviation for each measurement. 

logicalVector = (grepl("activity..",colNames) | 
                   grepl("subject..",colNames) | 
                   grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | 
                   grepl("-std..",colNames) & !grepl("-std()..-",colNames));

dataset_3 = dataset_3[logicalVector==TRUE];

# Step 3. Use descriptive activity names to name the activities in the data set

dataset_3 = merge(dataset_3,activity_label,by='activity_id',all.x=TRUE);
colNames  = colnames(dataset_3); 

# Step 4. Appropriately label the data set with descriptive activity names. 

for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

colnames(dataset_3) = colNames;

# Step 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

dataset_3Noactivity_label  = dataset_3[,names(dataset_3) != 'activity_label'];

tidyData = aggregate(dataset_3Noactivity_label[,names(dataset_3Noactivity_label) != c('activity_id','subject_id')],by=list(activity_id=dataset_3Noactivity_label$activity_id,subject_id = dataset_3Noactivity_label$subject_id),mean);

tidyData = merge(tidyData,activity_label,by='activity_id',all.x=TRUE);

write.table(tidyData, '../tidydataset.csv',row.names=FALSE,sep=',');