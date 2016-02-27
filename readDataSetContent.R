# This function reads the files that describe
# the features and activities contained in the data set
# and store them in a list of data.table objects

readDataSetContent <- function(path) {

      # Read files that contains features name:
      fdesc <- read.table(paste(path,"features.txt",sep="/"),sep=" ")
      names(fdesc) <- c("featureid","feature")
      
      # Read files that contains activities of the data set:
      actLabels <- read.table(paste(path,"activity_labels.txt",sep="/"),sep=" ")
      names(actLabels) <- c("activityid","activity")
      
      output <- list(data.table(fdesc),data.table(actLabels))
      
}