## Nota Bene
This is a completed Course Project assignment for the GETDATA-031 course of the Data Science Specialization offered by the Johns Hopkins Bloomberg School of Public Health in August 2015. It will not be forked by me without notice here. If there are doubts about the authenticity of this project, please refer to the commit history. Thanks, and happy reading! :)

## Introduction

This assignment uses [tidy data principles \[PDF\]](http://vita.had.co.nz/papers/tidy-data.pdf) to clean an example dataset and produce tidy output.

The dataset used is the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) from the University of California at Irvine Machine Learning Repository. The data was provided as a zip file hosted on a [cloudfront mirror](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

- **Dataset**: Human Activity Recognition Using Smartphones Data
- **Description**: Inertial sensors from waist-mounted Samsung Galaxy SII smartphones were used to record data for 30 subjects as they performed each of six different "activities of daily living" (ADL).

The 30 subjects were divided into `train` (21 subjects) and `test` (9 subjects) groups. All subjects performed each activity multiple times, and numerous measurement data were collected for each trial.

### Goals
Our aim is to provide a tidy datasets for the unified experiment (that is, including all subjects from both `train` and `test` groups). The tidy dataset will consist of average measurements over trials of the same activity performed by each subject, and will only include "mean" and "standard deviation" measures for each distinct signal type recorded or calculated in the original study. These measures are enumerated in the included **CodeBook.md**.

A note to the reader: our selection of "measures of interest" according to project specifications is open to different interpretations which are all valid as long as they are documented. There were 33 distinct signal types recorded in the study, and only the explicitly defined "mean" and "standard deviation" estimates were regarded as part of the project specification - for 66 total measures of interest. Other estimates and calculations such as "weighted average frequency component mean" and "averaged signals in signal window sample of angles between vectors" were not regarded as specified.

## Instructions
Source `run_analysis.R` and call the function `run_analysis()`. The data files are expected to be located in a `./data` subdirectory of the working directory; they will be automatically acquired if not present. 

*n.b.* the .zip file provides data in a folder called "UCI HAR Dataset". This folder should be renamed to `data` upon extraction; alternatively, leave download and extraction to `run_analysis`.

## run_analysis() Specification

- **Description**: Acquires and cleans the Human Activity Recognition data to project specifications.
- **Arguments**: None.
- **Return**: A narrow, tidy `data.table` object containing *average* (mean over all trials, for each subject/activity pair) values of both mean and standard deviation estimates of distinct signal types recorded in the original study.
- **Inputs**: UCI Human Activity Recognition data (acquired within the function if not present) located in a `data/` directory located within the working directory.
- **Outputs**: `har.tidy.txt`: a space delimited data file containing the returned tidy data.

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

The 561 time and frequency domain variables are various statistics (of which we are only interested in the "mean" and "standard deviation")  estimated for each of the 33 signals collected by the experiment. These signals are reproduced below; an `-XYZ` suffix indicates three separate corresponding signals, one for each of the `X`, `Y`, and `Z` axes.

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

## Cleaned data objectives

Our objective is to produce tidy data. We will use the following criteria:

1. Each variable forms a column.
1. Each observation forms a row.
1. Each type of observational unit forms a table.

We wil additionally adhere to the following principles:

1. Descriptive and meaningful variable names
1. Expressive variable values

We elect to provide the data in narrow (also referred to as "tall" or "long"), rather than wide form, such that each table has only one measurement column. Either narrow or wide data may qualify as tidy, and the `reshape2` **R** package provides an easy interface between them.

The information contained in our tidy output data will fall into two categories: **identifying variables** and **measurement variables**.

### Identifying variables

  - **subject**: identifies the subject by number.
  - **activty**: identifies the activity by name.
  - **group**: identifies to which group the subject belonged (either "train" or "test").
  - **measure**: identifies the type of measure (of 66 measures of interest). The possible values are delineated in `CodeBook.md`.
  
### Measurement variables

  - **trialAverage**: average (arithmetic mean) value across all trials for a subject/activity pair.
  
## run_analysis() Summary

`run_analysis` makes use of the `data.table` and `reshape2` packages, and will follow this general prescription:

1. **Acquire data**: A check is first made to ensure the data is already present in a `./data` subdirectory of the working directory. If not, it is acquired from [cloudfront archive](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
1. **Read data**: Data is read in formats as appropriate.
1. **Cleaning data**:
  - **Feature selection**: Cull only the 66 measures of interest from the read data.
  - **Expressive variable names**: Assign expressive variable names and values to the data, using pattern matching where appropriate to conform provided names to our own convention (refer to **CodeBook.md**). 
  - **Add identifying variables**: Add subject number (from `subject_*.txt`) activity name (from `y_*.txt`, mapped to `activity.txt`), and group (either "train" or "test"). *n.b.* group is not strictly specified, but we want to prevent loss of data resolution.
  - **Merge data**: Combine all data related to test and trial groups in one dataset.
1. **Tidy data**: The combined, augmented dataset is molten into narrow form using the `reshape2` package's `melt` function. ``Subject`, `group`, and `activity` are taken as identifiers. This is now the tidy output data.
1. **File output**: Written to the working directory as `har.tidy.txt` using `write.table` with `row.name = FALSE`.
1. **Return**: The tidy dataset is returned from the function.

## Attribution and License
The dataset used in this assignment requires the following citation and license:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.