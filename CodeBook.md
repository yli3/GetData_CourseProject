## Introduction
This codebook describes the structure of the `tidy.whole` and `tidy.average` datasets, and provides a dictionary for variables contained in these datasets.

## Structure

- `subject`:  `integer(1)` with possible values from 1 to 30.
- `group`: `character(1)`, either "train" or "test".
- `activity`: `character(1)`, with one of six possible values:
    -WALKING
    -WALKING\_UPSTAIRS
    -WALKING\_DOWNSTAIRS
    -SITTING
    -STANDING
    -LAYING
- `measure`: `character(1)`, with one of 66 possible values detailed in the following section.
- `value`: (*tidy.whole* only) `numeric(1)` measurement value for a given trial.
- `average`: (*tidy.average* only) `numeric(1)` measurement average value over all trials for a given subject/activity pair.

## Measure Dictionary

There are 66 different measures of interest. These measures are derived from accelerometer and gyroscopic measurements from embedded sensors in Samsung Galaxy SII smartphones. Details for how these particular measurements were derived may be found in the `features_info.txt` file included in the source Human Activity Recognition dataset.

The following naming convention is used for the 66 measures.

    prefix + component + sensor + jerk? + "."stat"." + type

1. **prefix**: 
  - *t* for a time-domain signal.
  - *f* for a frequency-domain signal.
1. **component**:
  - *Body* for body component of a signal.
  - *Gravity* for gravity component of a signal.
1. **sensor**:
  - *Acc* for an accelerometer-sourced signal.
  - *Gyro* for a gyroscope-sourced signal.
1. **jerk?**:
  - *Jerk* for a measure of jerk (the time derivative of acceleration)
  - blank for a non-jerk measure.
1. **stat**:
  - *mean* for estimated mean of a signal.
  - *std* for estimated standard deviation of a signal.
1. **type**:
  - *X*, *Y*, or *Z* for an x-, y-, or z-axis component of a signal.
  - *Mag* for the magnitude (Euclidean norm) of a 3-dimensional signal.
  
### List of measures

  tBodyAccX.mean
  tBodyAccY.mean
  tBodyAccZ.mean
  tBodyAccX.std
  tBodyAccY.std
  tBodyAccZ.std
  tGravityAccX.mean
  tGravityAccY.mean
  tGravityAccZ.mean
  tGravityAccX.std
  tGravityAccY.std
  tGravityAccZ.std
  tBodyAccJerkX.mean
  tBodyAccJerkY.mean
  tBodyAccJerkZ.mean
  tBodyAccJerkX.std
  tBodyAccJerkY.std
  tBodyAccJerkZ.std
  tBodyGyroX.mean
  tBodyGyroY.mean
  tBodyGyroZ.mean
  tBodyGyroX.std
  tBodyGyroY.std
  tBodyGyroZ.std
  tBodyGyroJerkX.mean
  tBodyGyroJerkY.mean
  tBodyGyroJerkZ.mean
  tBodyGyroJerkX.std
  tBodyGyroJerkY.std
  tBodyGyroJerkZ.std
  tBodyAccMag.mean
  tBodyAccMag.std
  tGravityAccMag.mean
  tGravityAccMag.std
  tBodyAccJerkMag.mean
  tBodyAccJerkMag.std
  tBodyGyroMag.mean
  tBodyGyroMag.std
  tBodyGyroJerkMag.mean
  tBodyGyroJerkMag.std
  fBodyAccX.mean
  fBodyAccY.mean
  fBodyAccZ.mean
  fBodyAccX.std
  fBodyAccY.std
  fBodyAccZ.std
  fBodyAccJerkX.mean
  fBodyAccJerkY.mean
  fBodyAccJerkZ.mean
  fBodyAccJerkX.std
  fBodyAccJerkY.std
  fBodyAccJerkZ.std
  fBodyGyroX.mean
  fBodyGyroY.mean
  fBodyGyroZ.mean
  fBodyGyroX.std
  fBodyGyroY.std
  fBodyGyroZ.std
  fBodyAccMag.mean
  fBodyAccMag.std
  fBodyAccJerkMag.mean
  fBodyAccJerkMag.std
  fBodyGyroMag.mean
  fBodyGyroMag.std
  fBodyGyroJerkMag.mean
  fBodyGyroJerkMag.std