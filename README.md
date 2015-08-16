## Nota Bene
This is a completed Course Project assignment for the GETDATA-031 course of the Data Science Specialization offered by the Johns Hopkins Bloomberg School of Public Health in August 2015.

## Introduction

This assignment uses [tidy data principles \[PDF\]](http://vita.had.co.nz/papers/tidy-data.pdf) to clean an example dataset and produce tidy output.

The data used is the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) from the University of California at Irvine Machine Learning Repository. The specific file used was acquired from a [cloud archive](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) made available through the course.

- **Dataset**: Human Activity Recognition Using Smartphones Data
- **Description**: Inertial sensors from Samsung Galaxy SII smartphones were used to record data for 30 subjects as they performed each of six different "activities of daily living" (ADL). The objective of this data is to learn how to recognize human activity from inertial sensor measurements. 

The 30 subjects were divided into `train` (21 subjects) and `test` (9 subjects) groups. All subjects performed each activity multiple times, and numerous measurement data were collected for each trial. Of these, we are interested in 66 measurements. Those measurements and the data structure of the output are described in detail in the included **CodeBook.md**.

Our aim is to merge the `train` and `test` sets and provide a unified tidy data set containing the 66 measures of interest for each trial record.

## Instructions

Data cleaning will be done in **R** using the provided **run_analysis.R** file. This file contains a function `run_analysis()` which must be called after the file is sourced. 

### run_analysis()

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

The **trial data** files contain measurement data for each trial conducted as part of either the train (`data/train/X_train.txt`) or test (`data/test/X_test.txt`) groups. There is one vector of measurements on each row.

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
  
## Method

A summary of the `run_analysis` function follows.

### Package dependencies

`run_analysis` will load and use the `data.table` and `reshape2` packages in **R**.

### Acquiring data

`run_analysis` will first check if the data is already present by looking for all required `.txt` files in the `data/` subdirectory of the working directory.

If the data is not present, then `run_analysis` will download the data from the [cloud archive](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) previously mentioned, and unzip the downloaded archive into a `data/` subdirectory.

### Cleaning data

`run_analysis` will read all trial data, subject, and activity files, as well as the features and activity files which will be used as mapping tables.

### Measure names
Regular expression pattern matching will be used on the data from `features.txt` in order to determine the column numbers and names of our 66 measures of interest. Additional use of regular expressions will convert the provided variable names to use period notation, so that the resulting column names will be of form `measure.mean` and `measure.std`. A typo in in the provided `features.txt` file will also be corrected.

The matching column numbers will be used to subset the trial data tables, and the fixed names will be used to provide column (variable) names for each measure in the resulting subsets.

### Activity names and subject numbers
We replace the numeric activity identifiers from `y_train.txt` and `y_test.txt` with the corresponding descriptive names from `activity_labels.txt`, in service of tidy data principles.

The activity names for each record, along with subject numbers from the `subject_train.txt` and `subject_test.txt` files, are incorporated into each measures data table.

### Subject groups
An additional variable is created for each measures data table indicating whether the subject belonged to the `trial` or `test` group.

The `trial` and `test` measures tables -- which now contain activity, subject, and group identifiers -- are then merged together.

### Narrow data
Although tidy data may be presented in either narrow or wide form, we elect to use narrow format for easy readability. 

To do this, we use **R**'s `reshape2` package. Its `melt` function will convert the data, originally in wide form, to narrow form. We will use `activity`, `subject`, and `group` as identifiers.

We have now created a narrow, tidy dataset of our 66 measures of interest, across all trial records in the original data. This dataset will be called `tidy.whole`.

### Averages
Each (of 30) subject performed trials for each (of 6) activity multiple times, and data from each trial is contained in the `tidy.whole` dataset.

We are also interested in the trial averages, and to that end will produce a second data set, also in narrow format, and derived from the first. 

This dataset will likewise hold `activity`, `subject`, and `group` as identifiers. Its value variable will be the *average* `measure` result from above for each subject/activity pair.

This dataset will be called `tidy.average`.

### File output
We now have two tidy datasets, and use `write.table` with `row.name = FALSE` to write each one to file. This results in the creation of two files in the working directory:

- `tidy.whole.txt`
- `tidy.average.txt`

### Return value
Finally, `run_analysis` will also return the two tidy datasets in a named list.

