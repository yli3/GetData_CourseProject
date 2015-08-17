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
  train.y <- as.factor(unlist(read.table("data/train/y_train.txt")))
  train.subject <- unlist(read.table("data/train/subject_train.txt"))
    
  test.x <- as.data.table(read.table("data/test/X_test.txt"))
  test.y <- as.factor(unlist(read.table("data/test/y_test.txt")))
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
    
  # Add column names for train and test group records.
  setnames(train.x, features$name)
  setnames(test.x, features$name)
  
  # Convert activity numbers vector to descriptive names.
  levels(train.y)[levels(train.y) %in% activity$number] <- activity$name
  levels(test.y)[levels(test.y) %in% activity$number] <- activity$name
  
  # Add descriptive activity names for train and test group records.
  train.x$activity <- train.y
  test.x$activity <- test.y
  
  # Add subject numbers for train and test group records.
  train.x$subject <- train.subject
  test.x$subject <- test.subject
  
  # Create new variable to preserve original group information.
  train.x$group <- "train"
  test.x$group <- "test"
  
  # Merge test and train group records together to one data.table.
  dt <- rbind(train.x, test.x)
  
  # Melt data to convert it to narrow format.
  dt.melt <- melt(dt, 
    id = c("subject", "group", "activity"),
    variable.name = "measure"
  )
  
  # Create second data.table for trial averages per subject/activity pair.
  dt.melt.average <- dt.melt[, 
    .(average = mean(value)),
    by = .(subject, group, activity, measure)
  ]
  
  # Output both files.
  write.table(dt.melt, file = "tidy.whole.txt", row.names = FALSE)
  write.table(dt.melt.average, file = "tidy.average.txt", row.names = FALSE)
  
  # Return data tables in named list.
  invisible(list(
    tidy.whole = dt.melt,
    tidy.average = dt.melt.average
  ))

}