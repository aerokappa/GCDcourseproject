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

allData = (trainData | trainSubjects | trainLabels)
          (testData  | testSubjects  | testLabels)
          
This gives a (10299 x 563 array)

Identify required elements of cleaned up data set
=================================================
features associated with the mean are identified by grepping for "mean//(//)" in the features vector.

features associated with the std are identified by grepping for "std//(//)" in the features vector.

the above two vectors are combined with "Subject" and "Activity Label" to identify the cols required in our "Tidy subset"

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