Data Origin
===========

Human Activity Recognition Using Smartphones Dataset
Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Reading in the relevant data files
==================================

the following variables were read from the following data sets:

features: "../features.txt" (561 x 1)

activityLabels: "../activity_labels.txt" (6 x 1)

trainData: "../train/X_train.txt" (7352 x 561)

trainSubjects: "../train/subject_train.txt" (7352 x 1)

trainLabels: "../train/y_train.txt" (7352 x 1)

testData: "../test/X_test.txt" (2947 x 561)

testSubjects: "../test/subject_test.txt" (2947 x 1)

testLabels: "../test/y_test.txt" (2947 x 1)

colbind and rowbind to merge the data
=====================================

the working data is merged as follows (graphically speaking)

allData = 

          (trainData | trainSubjects | trainLabels)

          (testData  | testSubjects  | testLabels)
          
This gives a (10299 x 563 array)

Identify required elements of cleaned up data set
=================================================
features associated with the mean are identified by grepping for "mean//(//)" in the features vector.

features associated with the std are identified by grepping for "std//(//)" in the features vector.

the above two vectors are combined with "Subject" and "Activity Label" to identify the cols required in our "Tidy subset"

Relevant Variables
==================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The means and stds of following variables were selected in teh subset:

tBodyAcc-XYZ (3 variables, 1 each for X, Y and Z)

tGravityAcc-XYZ (3 variables, 1 each for X, Y and Z)

tBodyAccJerk-XYZ (3 variables, 1 each for X, Y and Z)

tBodyGyro-XYZ (3 variables, 1 each for X, Y and Z)

tBodyGyroJerk-XYZ (3 variables, 1 each for X, Y and Z)

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ (3 variables, 1 each for X, Y and Z)

fBodyAccJerk-XYZ (3 variables, 1 each for X, Y and Z)

fBodyGyro-XYZ (3 variables, 1 each for X, Y and Z)

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag


Variable Units
==============
All measurements are normalized - hence don't have units.  (Features are normalized and bounded within [-1,1])


Column Names
============
The columns in the data frame are named after the given names above as it is felt that these names are descriptive enough.


Reshaping data
==============

As per identified cols above.

Giving meaningful activity names
================================

the activity ids in the ActivityLabels column are replaced with the corresponding activity labels as in the ActivityLabels file.

create final data set with average of each variable for each activity and subject
=================================================================================

the intersection set of (activity, subject) is computed for the identified variables.  The mean is computed using apply and sapply.

The result is then printed using write.table