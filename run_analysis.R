# run_analysis
#
# This function cleans the Human Activity Recognition dataset, and
# produces two output tidy data sets: one for all trials, and one for 
# averaged trial values for each subject and activity. 
#
# README.md contains more detailed information.
# CodeBook.md describes the data structure.
#
# Args: None.
# Input: HAR dataset located in data/ subdirectory.
#   The data will be acquired from online if not present.
# Dependencies: data.table, reshape2
# Output: tidy.whole.txt, tidy.average.txt
# Return: Named list of data tables, with names 'tidy.whole' and 'tidy.average'


run_analysis <- function() {
  # Libraries.
  library(data.table)
  library(reshape2)

  # Check all required files exist.
  required.files <- c(
    "data/features.txt",
    "data/activity_labels.txt",
    "data/train/X_train.txt",
    "data/train/y_train.txt",
    "data/train/subject_train.txt",
    "data/test/X_test.txt",
    "data/test/y_test.txt",
    "data/test/subject_test.txt"
  )
  
  if(sum(!file.exists(required.files)) > 0) {
    # Download & unzip dataset if missing files.
    zip.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    zip.file <- "data.zip"
    download.file(zip.url, destfile = zip.file, mode = "wb")
    unzip(zip.file, exdir = ".")
    
    # Rename directory contained in zip for convenience.
    file.rename("./UCI HAR Dataset", "./data")
  }
  
  # Read in files.
  features <- as.data.table(
    read.table(
      "data/features.txt", 
      stringsAsFactors = FALSE,
      col.names = c("number", "name")
    )
  )
  
  activity <- as.data.table(
    read.table(
      "data/activity_labels.txt", 
      stringsAsFactors = FALSE,
      col.names = c("number", "name")
    )
  )

  train.x <- as.data.table(read.table("data/train/X_train.txt"))
  train.y <- unlist(read.table("data/train/y_train.txt"))
  train.subject <- unlist(read.table("data/train/subject_train.txt"))
    
  test.x <- as.data.table(read.table("data/test/X_test.txt"))
  test.y <- unlist(read.table("data/test/y_test.txt"))
  test.subject <- unlist(read.table("data/test/subject_test.txt"))
  
  # Determine measures of interest (mean and std for 33 standard measures).
  features <- features[grepl("mean\\(\\)|std\\(\\)", features$name), ]
  
  # Subset only columns for measures of interest.
  train.x <- train.x[, features$number, with = FALSE]
  test.x <- test.x[, features$number, with = FALSE]
  
  # Clean variable names from features.txt:
  #   1. Remove () and replace "-" with "." for convention.
  #   2. Rename "t" and "f" to "time" and "freq" for clarity.  
  #   3. Rename measurement types to be expressive (i.e acceleration, jerk).
  #   4. Correct "BodyBody" to "Body" (it's a typo).
  #   5. Move "mean" or "std" (-> "sd") to the end, for convention.
  #   6. "Mag" -> "Magnitude" and both Magnitude
  #   7. Make sure both "Magnitude" and "[X-Z]" axis enclosed by "."
 
  features$name <- gsub("\\(\\)", "", features$name)
  features$name <- gsub("-", ".", features$name)
  features$name <- gsub("t([A-Z])", "time\\1", features$name)
  features$name <- gsub("f([A-Z])", "freq\\1", features$name)
  features$name <- gsub("AccJerk", "LinearJerk", features$name)
  features$name <- gsub("GyroJerk", "AngularJerk", features$name)
  features$name <- gsub("Acc", "LinearAcceleration", features$name)
  features$name <- gsub("Gyro", "AngularVelocity", features$name)
  features$name <- gsub("BodyBody", "Body", features$name)
  features$name <- gsub(".(mean|std).([X-Z])", ".\\2.\\1", features$name)
  features$name <- gsub(".std", ".sd", features$name)
  features$name <- gsub("Mag.", ".Magnitude.", features$name)
 
  # Give descriptive column names for 66 measures of interest.
  setnames(train.x, features$name)
  setnames(test.x, features$name)

  # Add "group" variable to preserve original group information.
  train.x$group <- "train"
  test.x$group <- "test"
  
  # Merge train and test groups.
  dt.whole <- rbind(train.x, test.x)
  y.whole <- c(train.y, test.y)
  subject.whole <- c(train.subject, test.subject)
  
  # Convert activity numbers vector to descriptive names.
  y.whole <- factor(y.whole, levels = activity$number, labels = activity$name)

  # Add "activity" and "subject" variables to dataset.
  dt.whole$activity <- y.whole
  dt.whole$subject <- subject.whole

  # Create "trialNumber" variable as counter for different trials
  # of the same activity type performed by each subject.
  dt.whole[, trialNumber := seq_len(nrow(.SD)), by = .(subject, activity)]

  # Melt data.whole into tidy narrow format.
  tidy.whole <- melt(dt.whole, 
    id = c("subject", "group", "activity", "trialNumber"),
    variable.name = "measure"
  )
  
  # Create second data.table for trial averages per subject/activity pair.
  tidy.average <- tidy.whole[, 
    .(average = mean(value)),
    by = .(subject, group, activity, measure)
  ]
  
  # Output both files.
  write.table(tidy.whole, file = "tidy.whole.txt", row.names = FALSE)
  write.table(tidy.average, file = "tidy.average.txt", row.names = FALSE)
  
  # Return data tables in named list.
  invisible(list(
    tidy.whole = tidy.whole,
    tidy.average = tidy.average
  ))

}