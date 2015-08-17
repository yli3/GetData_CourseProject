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
- `measure`: `factor` with 66 levels, indicating the type of measure. Possible values enumerated and described in detail in the following section.
- `value`: `numeric(1)` measurement value for a given trial. (*`tidy.whole`* only) 
- `average`: `numeric(1)` measurement average value over all trials for a given subject/activity pair. (*`tidy.average`* only)

## Measure Dictionary

There are 66 different measures of interest. These measures were taken by either accelerometer or gyroscope embedded sensors in Samsung Galaxy SII smartphones.

Both the accelerometer (which measures linear acceleration) and the gyroscope (which measures angular velocity) produce triaxial signals -- that is, separate signals for the *X*, *Y*, and *Z* axes. These signals were filtered for noise and further filtered into separate "Body" and "Gravity" components by assuming the components of the signals due to gravity were low frequency components. 

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
  - *LinearAcceleration* for a normalized measurement of linear acceleration (via accelerometer), in units of standard gravity (*g* being approximately `9.8 m/s<sup>2</sup>`).
  - *LinearJerk* for a calculation of linear jerk (time derivative of linear acceleration) in units of `m/s<sup>3</sup>`.
  - *AngularVelocity* for a measurement of angular velocity (via gyroscope) in units of `rad/s`.
  - *AngularJerk* for a calculation of angular jerk (second time derivative of angular velocity) in units of `rad/s<sup>3</sup>`.
1. **type**:
  - *X*, *Y*, or *Z* for an x-, y-, or z-axis component of a signal.
  - *Magnitude* for the magnitude (Euclidean norm) of a 3-dimensional signal.
1. **stat**:
  - *mean* for the estimated mean statistic of a signal.
  - *sd* for the estimated standard deviation statistic of a signal.

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
