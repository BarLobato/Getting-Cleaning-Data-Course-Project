
library(dplyr)
library(reshape2)

# First of all, the names of the measurements are assigned to a variable called 
# "features". Those will be the variable names of the data set.

features <- readLines ("features.txt")

# Read the files with the subject's ID numbers and the group they belong
# to - training group in this case. Also, load the activities performed
# during the training.

Subjects_ID <- readLines ("subject_train.txt")
Subjects_ID <- as.numeric(Subjects_ID)
Group <- rep("Training", length(Subjects_ID))
Activity <- readLines ("Y_train.txt")
Activity <- as.numeric(Activity)

# Open the training data set and specify the column names. 

trainingset <- read.table("X_train.txt", col.names = features)

# This adds to the trainingset data frame the columns indicating the activity
# performed, the ID number of each subjects and the experimental group.

trainingset <- cbind(Activity, trainingset)
trainingset <- cbind(Subjects_ID, trainingset)
trainingset <- cbind(Group, trainingset)

# By using order(), the columns "Subjects_ID" and "Activity" are rearranged.

trainingset <- trainingset[order(trainingset$Subjects_ID, trainingset$Activity, decreasing = FALSE),]

# This does pretty much the same what's been done with the training group before.

Subjects_ID <- readLines ("subject_test.txt")
Subjects_ID <- as.numeric(Subjects_ID)
Group <- rep ("Test", length(Subjects_ID))
Activity <- readLines ("Y_test.txt")
Activity <- as.numeric(Activity) 

testset <- read.table ("X_test.txt", col.names = features)
testset <- cbind(Activity, testset)
testset <- cbind(Subjects_ID, testset)
testset <- cbind(Group, testset)

testset <- testset[order(testset$Subjects_ID, testset$Activity, decreasing = FALSE), ]

# The trainig data and the test data are merged.

DataSet <- rbind (trainingset, testset)

# We are asked to subset the columns corresponding to the mean and the standard
# deviation of the measurements. 

DataSet_mn_std <- select(DataSet, 1:3, matches ("mean"), -matches ("meanFreq"), -matches ("angle"), matches ("std"))

# This renames the columns so the variable names are more intuitive.

DataSet_mn_std <- rename(DataSet_mn_std, mn_Body_acceleration_X = X1.tBodyAcc.mean...X, mn_Body_acceleration_Y = X2.tBodyAcc.mean...Y, mn_Body_acceleration_Z = X3.tBodyAcc.mean...Z, mn_Gravity_acceleration_X = X41.tGravityAcc.mean...X, mn_Gravity_acceleration_Y = X42.tGravityAcc.mean...Y, mn_Gravity_acceleration_Z = X43.tGravityAcc.mean...Z, mn_Jerk_body_acceleration_X = X81.tBodyAccJerk.mean...X, mn_Jerk_body_acceleration_Y = X82.tBodyAccJerk.mean...Y, mn_Jerk_body_acceleration_Z = X83.tBodyAccJerk.mean...Z, mn_Body_gyroscope_X = X121.tBodyGyro.mean...X, mn_Body_gyroscope_Y = X122.tBodyGyro.mean...Y, mn_Body_gyroscope_Z = X123.tBodyGyro.mean...Z, mn_Jerk_body_gyroscope_X = X161.tBodyGyroJerk.mean...X, mn_Jerk_body_gyroscope_Y = X162.tBodyGyroJerk.mean...Y, mn_Jerk_body_gyroscope_Z = X163.tBodyGyroJerk.mean...Z, mn_magnitude_body_acceleration = X201.tBodyAccMag.mean.., mn_magnitude_gravity_acceleration = X214.tGravityAccMag.mean.., mn_Jerk_magnitude_body_acceleration = X227.tBodyAccJerkMag.mean.., mn_magnitude_body_gyroscope = X240.tBodyGyroMag.mean.., mn_Jerk_magnitude_body_gyroscope = X253.tBodyGyroJerkMag.mean.., mn_Fourier_body_acceleration_X = X266.fBodyAcc.mean...X, mn_Fourier_body_acceleration_Y = X267.fBodyAcc.mean...Y, mn_Fourier_body_acceleration_Z = X268.fBodyAcc.mean...Z, mn_Fourier_Jerk_body_acceleration_X = X345.fBodyAccJerk.mean...X, mn_Fourier_Jerk_body_acceleration_Y = X346.fBodyAccJerk.mean...Y, mn_Fourier_Jerk_body_acceleration_Z = X347.fBodyAccJerk.mean...Z, mn_Fourier_body_gyroscope_X = X424.fBodyGyro.mean...X, mn_Fourier_body_gyroscope_Y = X425.fBodyGyro.mean...Y, mn_Fourier_body_gyroscope_Z = X426.fBodyGyro.mean...Z, mn_Fourier_magnitude_body_acceleration = X503.fBodyAccMag.mean.., mn_Fourier_Jerk_magnitude_body_acceleration = X516.fBodyBodyAccJerkMag.mean.., mn_Fourier_magnitude_body_gyroscope = X529.fBodyBodyGyroMag.mean.., mn_Fourier_Jerk_magnitude_body_gyroscope = X542.fBodyBodyGyroJerkMag.mean.., std_body_acceleration_X = X4.tBodyAcc.std...X, std_body_acceleration_Y = X5.tBodyAcc.std...Y, std_body_acceleration_Z = X6.tBodyAcc.std...Z, std_gravity_acceleration_X = X44.tGravityAcc.std...X, std_gravity_acceleration_Y = X45.tGravityAcc.std...Y, std_gravity_acceleration_Z = X46.tGravityAcc.std...Z, std_Jerk_body_acceleration_X = X84.tBodyAccJerk.std...X, std_Jerk_body_acceleration_Y = X85.tBodyAccJerk.std...Y, std_Jerk_body_acceleration_Z = X86.tBodyAccJerk.std...Z, std_body_gyroscope_X = X124.tBodyGyro.std...X, std_body_gyroscope_Y = X125.tBodyGyro.std...Y, std_body_gyroscope_Z = X126.tBodyGyro.std...Z, std_Jerk_body_gyroscope_X = X164.tBodyGyroJerk.std...X, std_Jerk_body_gyroscope_Y = X165.tBodyGyroJerk.std...Y, std_Jerk_body_gyroscope_Z = X166.tBodyGyroJerk.std...Z, std_magnitude_body_acceleration = X202.tBodyAccMag.std.., std_magnitude_gravity_acceleration = X215.tGravityAccMag.std.., std_Jerk_magnitude_body_acceleration = X228.tBodyAccJerkMag.std.., std_magnitude_body_gyroscope = X241.tBodyGyroMag.std.., std_Jerk_magnitude_body_gyroscope = X254.tBodyGyroJerkMag.std.., std_Fourier_body_acceleration_X = X269.fBodyAcc.std...X, std_Fourier_body_acceleration_Y = X270.fBodyAcc.std...Y, std_Fourier_body_acceleration_Z = X271.fBodyAcc.std...Z, std_Fourier_Jerk_body_acceleration_X = X348.fBodyAccJerk.std...X, std_Fourier_Jerk_body_acceleration_Y = X349.fBodyAccJerk.std...Y, std_Fourier_Jerk_body_acceleration_Z = X350.fBodyAccJerk.std...Z, std_Fourier_body_gyroscope_X = X427.fBodyGyro.std...X, std_Fourier_body_gyroscope_Y = X428.fBodyGyro.std...Y, std_Fourier_body_gyroscope_Z = X429.fBodyGyro.std...Z, std_Fourier_magnitude_body_acceleration = X504.fBodyAccMag.std.., std_Fourier_Jerk_magnitude_body_body_acceleration = X517.fBodyBodyAccJerkMag.std.., std_Fourier_magnitude_body_body_gyroscope = X530.fBodyBodyGyroMag.std.., std_Fourier_Jerk_magnitude_body_body_gyroscope = X543.fBodyBodyGyroJerkMag.std..)

# Finally, the data table is grouped by ID and activity, and the mean of those
# columns is calculated.

IndDataSet <- aggregate(. ~Subjects_ID + Activity, DataSet_mn_std, mean)
IndDataSet <- IndDataSet[order(IndDataSet$Subjects_ID, IndDataSet$Activity),]

# Tidy data is saved in a txt file.

write.table(IndDataSet, file = "TidyData.txt")
