# This function reads the inertial data in the directory
# "path/folder" and returns a data.table that includes
# subject related data, activity data and features data

readInertialDataSet <- function(folder, path) {
      
      # Directory path for input data:
      basePath <- paste(path,folder,sep="/")
      xfile <- paste(basePath,paste("X_",folder,".txt",sep=""),sep="/")
      yfile <- paste(basePath,paste("y_",folder,".txt",sep=""),sep="/")
      subjectfile <- paste(basePath,paste("subject_",folder,".txt",sep=""),sep="/")
      
      # Read fixed width file with feature data. Buffersize is set to 1
      # to avoid memory problems (at cost of major processing time):
      featData <- read.fwf(xfile,rep.int(16,561),buffersize = 1)
      
      # Reads activity and subject data:
      actData <- read.table(yfile,sep=" ")
      #names(actData) <- "activityid"
      subjectData <- read.table(subjectfile,sep=" ")
      #names(subjectData) <- "subjectid"
      
      # Returns subject, activity and feature data in one data table:
      data <- data.table(subjectData,actData,featData)
      
}
      