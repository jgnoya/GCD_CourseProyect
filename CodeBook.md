Proyect Code Book
=================

In this file we are going to explain how works the function run_analysis and the meaning of the columns in the file obtained.

The data used for this exercise was downloaded from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
and correspond with a study of the human activity using smartphones to obtain the data.
The data collected for this study was:
* - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* - Triaxial Angular velocity from the gyroscope. 
* - A 561-feature vector with time and frequency domain variables. 
* - Its activity label. 
* - An identifier of the subject who carried out the experiment.

This data was collected for 30 volunteer people and the data was divided in two groups: Test and Training.
To know more in detail about this study its possible to consult the URL: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
or read the txt documents contained in the zip file with the data used for this proyect: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The data set obtained contains the following columns:
* Subject_ID: Id of the subject that belogns the measurements
* Activity: The activity that were performed when the measurement was taken: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING or LAYING
* tBodyAcc-mean-XYZ: In this columns we store the average of the means of the Body Acceleration measurements for the subject_id when perform the Activity selected
* tBodyAcc-std-XYZ: In this columns we store the average of the standard deviation of the Body Acceleration measurements for the subject_id when perform the Activity selected
* tGravityAcc-mean-XYZ: In this columns we store the average of the means of the Gravity Acceleration measurements for the subject_id when perform the Activity selected
* tGravityAcc-std-XYZ: In this columns we store the average of the standard deviation of the Gravity Acceleration measurements for the subject_id when perform the Activity selected
* tBodyAccJerk-mean-XYZ: In this columns we store the average of the mean of Jerk singnals for Body Acceleration for the subject_id when perform the Activity selected
* tBodyAccJerk-std-XYZ: In this columns we store the average of the standard deviation of Jerk singnals for Body Acceleration for the subject_id when perform the Activity selected
* tBodyGyro-mean-XYZ: In this column is stored the average of the mean of the measurements of the gyroscope for each subject id and avtivity
* tBodyGyroJerk-mean-X: Is the same as the previous column but with the Jerk signals
* tBodyAccMag-mean-XYZ, tGravityAccMag-mean-XYZ, tBodyAccJerkMag-mean-XYZ, tBodyGyroMag-mean-XYZ, tBodyGyroJerkMag-mean-XYZ: the magnitude of these three-dimensional signals were calculated using the Euclidean norm. In this columns are strored the average mean for each measurement for each subject id and each activity
* tBodyAccMag-std-XYZ, tGravityAccMag-std-XYZ, tBodyAccJerkMag-std-XYZ, tBodyGyroMag-std-XYZ, tBodyGyroJerkMag-std-XYZ: the magnitude of these three-dimensional signals were calculated using the Euclidean norm. In this columns are strored the average standard deviation for each measurement for each subject id and each activity
* Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-mean-XYZ, fBodyAccJerk-mean-XYZ, fBodyGyro-mean-XYZ, .... (Note the 'f' to indicate frequency domain signals). This type of columns show the average mean or the average standard deviation for the corresponding measurement, calculated for each subject id and avtivity.

To obtain this data set we join the train and test data and take only the mean and standard deviation columns. Then we group the data by subject id and activity and calculate the average for each column grouped by subject id and activity.
To do this we use functionality from plyr and dplyr packages to group, sumarize and arrange (order) the data.
