## Introduction
This codebook describes the structure of the `tidy.whole` and `tidy.average` datasets, and provides a dictionary for variables contained in these datasets.

## Structure

- `subject`:  `integer(1)` with possible values from 1 to 30.
- `group`: `character(1)`, either "train" or "test".
- `activity`: `factor`, with six levels:
  - WALKING
  - WALKING\_UPSTAIRS
  - WALKING\_DOWNSTAIRS
  - SITTING
  - STANDING
  - LAYING
- `trialNumber`: integer(1), a unique identifier for trial number of a subject/activity pair.
- `measure`: `factor` with 66 levels, indicating the type of measure. Possible values enumerated and described in detail in the following section.
- `value`: `numeric(1)` measurement value for a given trial. (*`tidy.whole`* only) 
- `average`: `numeric(1)` measurement average value over all trials for a subject/activity pair. (*`tidy.average`* only)

## Measure Dictionary

There are 66 different measures of interest. These measures were taken by either accelerometer (which measures linear acceleration and, via time derivative, linear jerk) or gyroscope (which measures angular velocity and, via the second time derivative, angular jerk) embedded sensors in Samsung Galaxy SII smartphones.

Both the accelerometer and the gyroscope produce triaxial signals -- that is, separate signals for the *X*, *Y*, and *Z* axes. These signals were filtered for noise and further filtered into separate "Body" and "Gravity" components by assuming the components of the signals due to gravity were low frequency components.

In addition to independent axial data, the Euclidean norm is used to consider the magnitude of the whole triaxial signal.

Full details of sensor parameters and calculation steps may be found in the `features_info.txt` file included in the source Human Activity Recognition dataset. 

The following naming convention is used for the 66 measures:

    prefix + component + units + .type. + stat

1. **prefix**: 
  - *time* for a time-domain signal.
  - *freq* for a frequency-domain signal calculated via Fast Fourier Transform (FFT) on the corresponding time-domain signal.
1. **component**:
  - *Body* for component of the signal attributed to movement of the human body.
  - *Gravity* for component of the signal attributed to gravity (assumed to be low frequency).
1. **units**:
  - *LinearAcceleration* for a normalized measurement of linear acceleration (via accelerometer), in units of standard gravity (*g* being approximately `9.8` *m/s<sup>2</sup>*).
  - *LinearJerk* for a calculation of linear jerk (time derivative of linear acceleration) in units of *m/s<sup>3</sup>*.
  - *AngularVelocity* for a measurement of angular velocity (via gyroscope) in units of *rad/s*.
  - *AngularJerk* for a calculation of angular jerk (second time derivative of angular velocity) in units of *rad/s<sup>3</sup>*.
1. **type**:
  - *X*, *Y*, or *Z* for an x-, y-, or z-axis component of a signal.
  - *Magnitude* for the magnitude (Euclidean norm) of a 3-dimensional signal.
1. **stat**:
  - *mean* for the estimated mean statistic of a signal.
  - *sd* for the estimated standard deviation statistic of a signal.

For example,

     freqBodyLinearAcceleration.Magnitude.mean

denotes the frequency-domain value of the estimated mean linear acceleration triaxial signal magnitude. Because this is a linear rather than angular measurement, it comes from the embedded accelerometer signals. Because this is a linear acceleration measurement, it is in units of standard gravities *g*.

### List of measures

    timeBodyLinearAcceleration.X.mean
    timeBodyLinearAcceleration.Y.mean
    timeBodyLinearAcceleration.Z.mean
    timeBodyLinearAcceleration.X.sd
    timeBodyLinearAcceleration.Y.sd
    timeBodyLinearAcceleration.Z.sd
    timeGravityLinearAcceleration.X.mean
    timeGravityLinearAcceleration.Y.mean
    timeGravityLinearAcceleration.Z.mean
    timeGravityLinearAcceleration.X.sd
    timeGravityLinearAcceleration.Y.sd
    timeGravityLinearAcceleration.Z.sd
    timeBodyLinearJerk.X.mean
    timeBodyLinearJerk.Y.mean
    timeBodyLinearJerk.Z.mean
    timeBodyLinearJerk.X.sd
    timeBodyLinearJerk.Y.sd
    timeBodyLinearJerk.Z.sd
    timeBodyAngularVelocity.X.mean
    timeBodyAngularVelocity.Y.mean
    timeBodyAngularVelocity.Z.mean
    timeBodyAngularVelocity.X.sd
    timeBodyAngularVelocity.Y.sd
    timeBodyAngularVelocity.Z.sd
    timeBodyAngularJerk.X.mean
    timeBodyAngularJerk.Y.mean
    timeBodyAngularJerk.Z.mean
    timeBodyAngularJerk.X.sd
    timeBodyAngularJerk.Y.sd
    timeBodyAngularJerk.Z.sd
    timeBodyLinearAcceleration.Magnitude.mean
    timeBodyLinearAcceleration.Magnitude.sd
    timeGravityLinearAcceleration.Magnitude.mean
    timeGravityLinearAcceleration.Magnitude.sd
    timeBodyLinearJerk.Magnitude.mean
    timeBodyLinearJerk.Magnitude.sd
    timeBodyAngularVelocity.Magnitude.mean
    timeBodyAngularVelocity.Magnitude.sd
    timeBodyAngularJerk.Magnitude.mean
    timeBodyAngularJerk.Magnitude.sd
    freqBodyLinearAcceleration.X.mean
    freqBodyLinearAcceleration.Y.mean
    freqBodyLinearAcceleration.Z.mean
    freqBodyLinearAcceleration.X.sd
    freqBodyLinearAcceleration.Y.sd
    freqBodyLinearAcceleration.Z.sd
    freqBodyLinearJerk.X.mean
    freqBodyLinearJerk.Y.mean
    freqBodyLinearJerk.Z.mean
    freqBodyLinearJerk.X.sd
    freqBodyLinearJerk.Y.sd
    freqBodyLinearJerk.Z.sd
    freqBodyAngularVelocity.X.mean
    freqBodyAngularVelocity.Y.mean
    freqBodyAngularVelocity.Z.mean
    freqBodyAngularVelocity.X.sd
    freqBodyAngularVelocity.Y.sd
    freqBodyAngularVelocity.Z.sd
    freqBodyLinearAcceleration.Magnitude.mean
    freqBodyLinearAcceleration.Magnitude.sd
    freqBodyLinearJerk.Magnitude.mean
    freqBodyLinearJerk.Magnitude.sd
    freqBodyAngularVelocity.Magnitude.mean
    freqBodyAngularVelocity.Magnitude.sd
    freqBodyAngularJerk.Magnitude.mean
    freqBodyAngularJerk.Magnitude.sd
    
    
## Attribution and License
Information in this codebook is derived from and based on documentation of the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The dataset requires the inclusion of the following citation and license:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
