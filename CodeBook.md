

Background on source data
==========================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

-----------------------------------------------------------------------------------------------------------------------

Procedure used to generated the "new_data_set"
-------------------------------------------------
Note: Only the "mean()" and "std()" was extracted to produce the following Variables all other variables where dropped.

1. Download dataset into the working directory as "Dataset.zip"
2. unzip the dataset into the working directory
3. Obtain variable names from the file @ "./UCI HAR Dataset/features.txt" and assign it to the vector "columnNames"
4. Obtain activity names from the file @ "./UCI HAR Dataset/activity_labels.txt" and assign it to the vector "activityNames"
5. Read in test data for Variables, Activities, & Subjects
6. Read in training data for Variables, Activities, & Subjects
7. Merge the test and training data for Variables, Activities, & Subjects
8. Apply Descriptive test to the combined test and training data for Variables, Activities, & Subjects
9. Futher combine Variable, Activity, & Subject data into one composite data set
10. Convert all of the Activity IDs into Activity Names in the Composite data set
11. Subset the composite dataset so that it will include only the Variables "Subject.ID", "Activity.Description" and any variable that represents a mean or standard deviation measurement
12. Generate mean data for every subjectID, activityName combination
13. Convert the dataset into a data.frame()
14. Export the data.frame() into a file.."new_data_set.txt"


-----------------------------------------------------------------------------------------------------------------------



Data Variable Descriptions
---------------------------

Subject.ID
----------
The ID of the individual from which the the data was sourced.


Activity.Description
--------------------
A description of the activity that was being performed
Activities included: (WALKING WALKING_UPSTAIRS WALKING_DOWNSTAIRS SITTING STANDING & LAYING)


*** The following are time domain Variables/signals

* Mean and Standard Deviation Measurements for the 3-axis Body Acceleration
tBodyAcc-mean()-X
tBodyAcc-mean()-Y
tBodyAcc-mean()-Z
tBodyAcc-std()-X
tBodyAcc-std()-Y
tBodyAcc-std()-Z
                        
* Mean and Standard Deviation Measurements for the 3-axis Gravity Acceleration
tGravityAcc-mean()-X
tGravityAcc-mean()-Y
tGravityAcc-mean()-Z
tGravityAcc-std()-X
tGravityAcc-std()-Y
tGravityAcc-std()-Z

* Mean and Standard Deviation Measurements for the 3-axis Body Jerk Acceleration
tBodyAccJerk-mean()-X
tBodyAccJerk-mean()-Y
tBodyAccJerk-mean()-Z
tBodyAccJerk-std()-X
tBodyAccJerk-std()-Y
tBodyAccJerk-std()-Z

* Mean and Standard Deviation Measurements for the 3-axis Body Gyroscope
tBodyGyro-mean()-X
tBodyGyro-mean()-Y
tBodyGyro-mean()-Z
tBodyGyro-std()-X
tBodyGyro-std()-Y
tBodyGyro-std()-Z

* Mean and Standard Deviation Measurements for the 3-axis Body Jerk Gyroscope
tBodyGyroJerk-mean()-X
tBodyGyroJerk-mean()-Y
tBodyGyroJerk-mean()-Z
tBodyGyroJerk-std()-X
tBodyGyroJerk-std()-Y
tBodyGyroJerk-std()-Z

* Mean and Standard Deviation Measurements for the magnitude of Body Acceleration Jerk Gyroscope
tBodyAccMag-mean()
tBodyAccMag-std()

* Mean and Standard Deviation Measurements for the magnitude of Gravity Acceleration
tGravityAccMag-mean()
tGravityAccMag-std()

* Mean and Standard Deviation Measurements for the magnitude of Gravity Acceleration
tBodyAccJerkMag-mean()
tBodyAccJerkMag-std()

* Mean and Standard Deviation Measurements for the magnitude of Body Gyroscope
tBodyGyroMag-mean()
tBodyGyroMag-std()

* Mean and Standard Deviation Measurements for the magnitude of Body Gyroscope Jerk
tBodyGyroJerkMag-mean()
tBodyGyroJerkMag-std()

*** The following are frequency domain Variables/signals

* Mean and Standard Deviation Measurements for the 3-axis Body Acceleration
fBodyAcc-mean()-X
fBodyAcc-mean()-Y
fBodyAcc-mean()-Z
fBodyAcc-std()-X
fBodyAcc-std()-Y 
fBodyAcc-std()-Z

* Mean and Standard Deviation Measurements for the 3-axis Body Acceleration Jerk
fBodyAccJerk-mean()-X
fBodyAccJerk-mean()-Y
fBodyAccJerk-mean()-Z
fBodyAccJerk-std()-X
fBodyAccJerk-std()-Y
fBodyAccJerk-std()-Z

* Mean and Standard Deviation Measurements for the 3-axis Body Gyroscope
fBodyGyro-mean()-X
fBodyGyro-mean()-Y
fBodyGyro-mean()-Z
fBodyGyro-std()-X
fBodyGyro-std()-Y
fBodyGyro-std()-Z

* Mean and Standard Deviation Measurements for the magnitude of Body Acceleration Jerk Gyroscope
fBodyAccMag-mean()
fBodyAccMag-std()

* Mean and Standard Deviation Measurements for the magnitude of Body Acceleration Jerk

fBodyBodyAccJerkMag-mean(),
fBodyBodyAccJerkMag-std()

* Mean and Standard Deviation Measurements for the magnitude of Body Gyroscope

fBodyBodyGyroMag-mean(),
fBodyBodyGyroMag-std()

* Mean and Standard Deviation Measurements for the magnitude of Body Gyroscope Jerk

**fBodyBodyGyroJerkMag-mean(),
**fBodyBodyGyroJerkMag-std())
