# run_analysis
#
# This function cleans the Human Activity Recognition dataset, and
# produces two output tidy data sets: one for all trials, and one for 
# averaged trial values for each subject and activity. 
#
# Refer to README.md for more detailed information.
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
    unzip(zip.file, exdir = "data")
  }
  
  # Read in files.
  features <- as.data.table(
    read.table("data/features.txt", stringsAsFactors = FALSE)
  )
  
  activity <- as.data.table(
    read.table("data/activity_labels.txt", stringsAsFactors = FALSE)
  )

  train.x <- as.data.table(read.table("data/train/X_train.txt"))
  train.y <- unlist(read.table("data/train/y_train.txt"))
  train.subject <- unlist(read.table("data/train/subject_train.txt"))
    
  test.x <- as.data.table(read.table("data/test/X_test.txt"))
  test.y <- unlist(read.table("data/test/y_test.txt"))
  test.subject <- unlist(read.table("data/test/subject_test.txt"))
 
  # Determine measures of interest (mean and std for 33 standard measures).
  features <- features[grepl("mean\\(\\)|std\\(\\)", features$V2), ]
  
  # Subset only columns for measures of interest.
  train.x <- train.x[, features$V1, with = FALSE]
  test.x <- test.x[, features$V1, with = FALSE]
  
  # Clean variable names from features.txt:
  #    1. Remove () and replace "-" with "." for convention.
  #    2. Correct "BodyBody" to "Body" (it's a typo).
  #    3. Move "mean" or "std" to the end, for convention.
  features$V2 <- gsub("\\(\\)", "", features$V2)
  features$V2 <- gsub("-", ".", features$V2)
  features$V2 <- gsub("BodyBody", "Body", features$V2)
  features$V2 <- gsub(".(mean|std).([X-Z])", "\\2.\\1", features$V2)
  
  # Add column names for train and test group records.
  setnames(train.x, features$V2)
  setnames(test.x, features$V2)
  
  # Convert activity numbers vector to descriptive names.
  lapply(activity$V1, 
    function(e) {
      train.y <<- gsub(e, activity$V2[e], train.y)
      test.y <<- gsub(e, activity$V2[e], test.y)
    }
  )
      
  # Add descriptive activity names for train and test group records.
  train.x$activity <- train.y
  test.x$activity <- test.y
  
  # Add subject numbers for train and test group records.
  train.x$subject <- train.subject
  test.x$subject <- test.subject
  
  # Create new variables indicating "train" or "test".
  train.x$group <- "train"
  test.x$group <- "test"
  
  # Merge test and train group records together to one data.table.
  dt <- rbind(train.x, test.x)
  
  # Melt data to convert it to narrow format.
  dt.melt <- melt(dt, 
    id = c("subject", "group", "activity")
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