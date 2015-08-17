## Nota Bene
This is a completed Course Project assignment for the GETDATA-031 course of the Data Science Specialization offered by the Johns Hopkins Bloomberg School of Public Health in August 2015. It will not be forked by me without notice here. If there are doubts about the authenticity of this project, please refer to the commit history.

## Introduction

This assignment uses [tidy data principles \[PDF\]](http://vita.had.co.nz/papers/tidy-data.pdf) to clean an example dataset and produce tidy output.

The data used is the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) from the University of California at Irvine Machine Learning Repository. The specific file used was acquired from a [cloud archive](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) made available through the course.

- **Dataset**: Human Activity Recognition Using Smartphones Data
- **Description**: Inertial sensors from Samsung Galaxy SII smartphones were used to record data for 30 subjects as they performed each of six different "activities of daily living" (ADL). The objective of this data is to learn how to recognize human activity from inertial sensor measurements. 

The 30 subjects were divided into `train` (21 subjects) and `test` (9 subjects) groups. All subjects performed each activity multiple times, and numerous measurement data were collected for each trial. Of these, we are interested in 66 measures; they are described in detail in the included **CodeBook.md**.

Our aim is to provide tidy datasets for the unified experiment (that is, including all subjects from both `train` and `test` groups). 

## Instructions

Source `run_analysis.R` and call the function `run_analysis()`. The data files are expected to be located in a `./data` subdirectory of the working directory; they will be automatically acquired if not present. 

*n.b.* the .zip file provides data in a folder called "UCI HAR Dataset". This folder should be renamed to `data` upon extraction; alternatively, leave download and extraction to `run_analysis`.

### run_analysis() Specification

- **Description**: Acquires and cleans the Human Activity Recognition data to project specifications.
- **Arguments**: None.
- **Return**: A named list with two list elements:
  - `tidy.whole`: A narrow, tidy `data.table` object containing *all* (every trial) data for each of 66 standard measures described in the CodeBook. That is, data 
  - `tidy.average`: A narrow, tidy `data.table` object containing *average* (mean over all trials, for each subject/activity pair) values of each of the 66 standard measures.
- **Inputs**: UCI Human Activity Recognition data (acquired within the function if not present) located in a `data/` directory located within the working directory.
- **Outputs**: Data files in space-delimited format, written to the working directory:
  - `tidy.whole.txt`: `tidy.whole` data file.
  - `tidy.average.txt`: `tidy.average` data file.

## State of the original data

### Files

The **trial data** files contain measurement data for each trial conducted as part of either the train (`data/train/X_train.txt`) or test (`data/test/X_test.txt`) groups. There is one vector (of 561 measurements) on each row.

The **subject** files (`data/train/subject_train.txt` and `data/test/subject_test.txt`) correspond to the trial data files. They indicate, for each row in the trial data file, from which subject (identified by a number ranging from 1 to 30) the measurements were taken.

The **activity** files (`data/train/y_train.txt` and `data/test/y_test.txt`) correspond to to the trial data files. They indicate, for each row in the trial data file, the associated activity (identified by a number ranging from 1 to 6).

The **features.txt** file contains a list of measurement names with one on each row. These are in the same order as each trial data measurement vector.

The **activity_labels.txt** file contains a list of activity labels with one each row. This provides a lookup table for the activity numbers contained in the activity files.

There are further **Inertial Signals** directories in each of the `data/train/` and `data/test/` directories, which contain raw sensor data and aren't of interest to us.

### Trial data measures
Measurement data for each trial consists of 561 time and frequency domain variables, which are described in `data/features_info.txt`.

The 561 time and frequency domain variables contain of various statistics (such as mean, max, and standard deviation)  for each of the 33 standard measures. These measures are reproduced below; an `-XYZ` suffix indicates there are three separate values, one for each of the `X`, `Y`, and `Z` axes.

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
    
In addition to the above, the 561 time and frequency domain variables also contain additional means obtained by averaging signals in a signal window sample:

    gravityMean
    tBodyAccMean
    tBodyAccJerkMean
    tBodyGyroMean
    tBodyGyroJerkMean

These do not have corresponding standard deviations and are not considered in this assignment. 

We will focus only on `mean` and `std` (standard deviation) measurements of the 33 standard measures described above, resulting in a total of 66 relevant standard measures.

## Cleaned data objectives

Our objective is to produce dataset according to tidy data principles.

Additionally, we will be providing the output in narrow, rather than wide form, such that each row contains only one measurement value. Either narrow or wide data may qualify as tidy, and the `reshape2` **R** package provides an easy interface between them.

The information contained in our tidy output data will fall into two categories: **identifying variables** and **measurement variables**.

### Identifying variables

  - **subject**: identifies the subject by number (from 1 to 30).
  - **activty**: identifies the activity by name (either WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, or LAYING)
  - **group**: identifies to which group the subject belonged (either "train" or "test")
  - **measure**: identifies the type of measure, of the 66 measures of interest. The names are listed in `CodeBook.md`.
  
### Measurement variables

  - **value**: for the `tidy.whole` dataset; this is the measured value for a given trial record.
  - **average**: for the `tidy.average` dataset only; this is a mean value across all trials for a given subject/activity pair.
  
## run_analysis() Summary

`run_analysis` makes use of the `data.table` and `reshape2` packages. It will follow the sequence below:


1. **Acquire data**: A check is first made to ensure the data is already present in a `./data` subdirectory of the working directory. If not, it is acquired from [cloudfront archive](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
1. **Read data**: Data is read in. `X_train.txt` and `X_test.txt` are read as `data.table` objects. Other files -- `activity.txt`, `features.txt`, `y_train.txt`, `y_test.txt`, `subject_train.txt`, and `subject_test.txt` -- are read as auxiliary data in various formats to help us complete and clean the `train` and `test` datasets for tidy output.
1. **Cleaning data**:
  - **Feature selection**: Subset the 66 measures of interest from the `train` and `test` datasets by pattern matching `features.txt`.
  - **Expressive measure names**: Assign expressive variable names to the `train`/`test` datasets. Pattern substitution is employed to conform original `features.txt` names to our own convention as detailed in **CodeBook.md**.
  - **Add identifying variables**: Add to the `train`/`test` datasets variables for subject number (from `subject_*.txt`), activity name (from `y_*.txt`, mapped to `activity.txt`), and group (either "train" or "test"). 
1. **Merge datasets**: The completed and cleaned `trial` and `test` datasets are merged into one dataset.
1. **Narrow data: tidy.whole**: The combined dataset is molten into tidy narrow (also known as "long" or "tall") form using the `reshape2` package's `melt` function. `Activity`, `subject`, and `group` are taken as identifiers. This is now the `tidy.whole` dataset.
1. **Averages over trials**: Each (of 30) subjects performed trials for each (of 6) activities multiple times. The per-activity average measurements for each subject are calculated and gathered into a dataset we call `tidy.average`.
1. **File output**: The two tidy datasets will be written to the working directory as `tidy.whole.txt` and `tidy.average.txt` using `write.table` with `row.name = FALSE`.
1. **Return**: Finally, the two tidy datasets are returned as `data.table` objects in a named list, with names `tidy.whole` and `tidy.average`.