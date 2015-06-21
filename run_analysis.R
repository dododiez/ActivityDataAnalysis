#|----------------------------------------------------------------------------|
#| Obtain dataset from external site
#|----------------------------------------------------------------------------|

#| Cache the start time ------------------------------------------------------|
startTime <- Sys.time()

#| Download the Dataset for analysis |----------------------------------------|
filePath <- "./Dataset.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (file.exists(filePath) == FALSE)
{
     cat("Downloading data set...\n")  
     download.file(fileURL, destfile = filePath, method = "curl", quiet=TRUE)
}

#| Unzip the file into the current directory |--------------------------------|
filePath <- "./UCI HAR Dataset"

if (file.exists(filePath) == FALSE)
{
     cat("Uncompressing the data set...\n")
     unzip("./Dataset.zip", exdir = "./")
}

#|----------------------------------------------------------------------------|
#| Find the feature names for the data
#|----------------------------------------------------------------------------|
cat("Reading the feature names...\n")

#| Read in the features |-----------------------------------------------------|
features <- read.table("./UCI HAR Dataset/features.txt")

#| Extract the feature column names |-----------------------------------------|
columnNames <- features[,2]

#|----------------------------------------------------------------------------|
#| Find the activity names for the data
#|----------------------------------------------------------------------------|
cat("Reading the activity names...\n")

#| Read in the activities |---------------------------------------------------|
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

#| Extract the activity column names |----------------------------------------|
activityNames <- activities[,2]

#|----------------------------------------------------------------------------|
#| Read in test data
#|----------------------------------------------------------------------------|
cat("Reading the test data...\n")

#| Read in test feature data |------------------------------------------------|
testFeatureData <- read.table("./UCI HAR Dataset/test/X_test.txt")

#| Read in test activity data |-----------------------------------------------|
testActivityData <- read.table("./UCI HAR Dataset/test/Y_test.txt")

#| Read in test subject data |------------------------------------------------|
testSubjectData <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#|----------------------------------------------------------------------------|
#| Read in training data
#|----------------------------------------------------------------------------|
cat("Reading the training data...\n")

#| Read in training feature data |--------------------------------------------|
trainingFeatureData <- read.table("./UCI HAR Dataset/train/X_train.txt")

#| Read in training activity data |-------------------------------------------|
trainingActivityData <- read.table("./UCI HAR Dataset/train/Y_train.txt")

#| Read in training subject data |--------------------------------------------|
trainingSubjectData <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#|----------------------------------------------------------------------------|
#| Merge the test and training data
#|----------------------------------------------------------------------------|
cat("Merging the test and training data...\n")

#| Merge the feature data |---------------------------------------------------|
featureData <- rbind(testFeatureData, trainingFeatureData)

#| Merge the activity data |--------------------------------------------------|
activityData <- rbind(testActivityData, trainingActivityData)

#| Merge the subject data |---------------------------------------------------|
subjectData <- rbind(testSubjectData, trainingSubjectData)

#|----------------------------------------------------------------------------|
#| Apply labels to data
#|----------------------------------------------------------------------------|
cat("Applying labels to data...\n")

#| Apply labels to feature data |---------------------------------------------|
colnames(featureData) <- columnNames

#| Apply labels to activity data |---------------------------------------------|
colnames(activityData) <- c("Activity.Description")

#| Apply labels to subject data |---------------------------------------------|
colnames(subjectData) <- c("Subject.ID")

#|----------------------------------------------------------------------------|
#| Construct composite data set
#|----------------------------------------------------------------------------|
cat("Constructing composite data set...\n")

#| Construct composite data set |---------------------------------------------|
compositeData <- cbind(subjectData, activityData, featureData)

#|----------------------------------------------------------------------------|
#| Convert the Activity description from an identifier to desciptive text
#|----------------------------------------------------------------------------|
cat("Converting activity IDs to activity names...\n")

#| Convert activity descripter to text |--------------------------------------|
compositeData$Activity.Description <- activityNames[activityData$Activity.Description]

#|----------------------------------------------------------------------------|
#| Create a dataset that is a subset of the composite data
#|----------------------------------------------------------------------------|
cat("Converting data subset...\n")

#| Generate a vector to select column names of interest |---------------------|
selectedColumnNames <- c("Subject.ID","Activity.Description",
                         "tBodyAcc-mean()-X","tBodyAcc-mean()-Y","tBodyAcc-mean()-Z",
                         "tBodyAcc-std()-X","tBodyAcc-std()-Y","tBodyAcc-std()-Z",
                         "tGravityAcc-mean()-X","tGravityAcc-mean()-Y","tGravityAcc-mean()-Z",
                         "tGravityAcc-std()-X","tGravityAcc-std()-Y","tGravityAcc-std()-Z",
                         "tBodyAccJerk-mean()-X","tBodyAccJerk-mean()-Y","tBodyAccJerk-mean()-Z",
                         "tBodyAccJerk-std()-X","tBodyAccJerk-std()-Y","tBodyAccJerk-std()-Z")

#| Generate data subset |-----------------------------------------------------|
compositeDataSubset <- compositeData[,selectedColumnNames]

#|----------------------------------------------------------------------------|
#| Create new data set of means
#|----------------------------------------------------------------------------|
cat("Generating new 'means' data set...\n")

#| Initialize dataset generation variables |----------------------------------|
newMeasurementMeans <- NA
newMeasurmentIdentifiers <- NA
hasDataSetGenerationBegun = FALSE

#| Generate mean data for every subjectID, activityName combination |---------|

#| Iterate through all Subject IDs |------------------------------------------|
for(subjectID in unique(compositeDataSubset$Subject.ID))
{
     #| Iterate through all Activity Names |-------------------------------------|
     for(activity in activityNames)
     {
          #| Generate Row of Measurement Data and Measurement Identifier -----------|
          tempMeasurementMeansData <- sapply(compositeDataSubset[((compositeDataSubset$Subject.ID == subjectID) & (compositeDataSubset$Activity.Description == activity)),3:20], mean, simplify=TRUE)
          tempMeasurementIdentifierData <- c(subjectID, activity)
          
          #| Append new Row of Measurement Data and Measurement Identifier ---------|
          if (hasDataSetGenerationBegun == FALSE)
          {
               newMeasurementMeans <- tempMeasurementMeansData
               newMeasurmentIdentifiers <- tempMeasurementIdentifierData
               
               hasDataSetGenerationBegun <- TRUE
          }
          else
          {
               newMeasurementMeans <- rbind(newMeasurementMeans, tempMeasurementMeansData)
               newMeasurmentIdentifiers <- rbind(newMeasurmentIdentifiers, tempMeasurementIdentifierData)
          }
     }
}

#| Convert resulting datasets into data frames  ------------------------------|
newMeasurementMeans <- data.frame(newMeasurementMeans, row.names = NULL)
newMeasurmentIdentifiers <- data.frame(newMeasurmentIdentifiers, row.names = NULL)

#| Combine identifiers with measurements and apply identifier column names ---|
newDataSet <- cbind(newMeasurmentIdentifiers, newMeasurementMeans)
colnames(newDataSet)[1:2] <- c("Subject.ID", "Activity.Description")

#| Output the table -----------------------------------------------------------|
cat("Writing new data set to a file...\n")

write.table(newDataSet, "./new_data_set.txt", row.name=FALSE, sep="\t")

#| Cache the stop time --------------------------------------------------------|
stopTime <- Sys.time()

#| Calculate the total processing time ----------------------------------------|
procTime <- stopTime - startTime

#| Announce that processing is complete ---------------------------------------|
cat("Done (",procTime," seconds.)\n")
