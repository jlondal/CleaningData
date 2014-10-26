# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

setwd("/Users/jameslondall/Dropbox/DS Course/Cleaning Data")

# Merges the training and the test sets to create one data set.

train <- read.table("data/UCI HAR Dataset/train/X_train.txt")
trainLabel <- read.table("data/UCI HAR Dataset/train/y_train.txt")
testSubject <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
trainSubject <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
test <- read.table("data/UCI HAR Dataset/test/X_test.txt")
testLabel <- read.table("data/UCI HAR Dataset/test/y_test.txt") 


join.Data <- rbind(train, test)
join.Label <- rbind(trainLabel, testLabel)
join.Subject <- rbind(trainSubject, testSubject)

View(join.Data)
View(join.Label)
View(join.Subject)

# Extracts only the measurements on the mean and standard 

features <- read.table("data/UCI HAR Dataset/features.txt")
mIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2]) # Are there better option than grep?
join.Data <- join.Data[, mIndices]


names(join.Data) <- gsub("\\(\\)", "", features[mIndices, 2])

# Uses descriptive activity names to name the activities in ...

activities <- read.table("data/UCI HAR Dataset/activity_labels.txt")
activities[, 2] <- tolower(gsub("_", "", activities[, 2]))
substr(activities[2, 2], 8, 8) <- toupper(substr(activities[2, 2], 8, 8))
substr(activities[3, 2], 8, 8) <- toupper(substr(activities[3, 2], 8, 8))
activitiesLabel <- activities[join.Label[, 1], 2]
join.Label[, 1] <- activitiesLabel
names(join.Label) <- "activity"

# Appropriately labels the data set with descriptive activity ...

names(join.Subject) <- "subject"
output_df <- cbind(join.Subject, join.Label, join.Data)
write.table(output_df, "data/merged_data.txt") 

# Creates a second, independent tidy data set with the average of ...

L.subject <- length(table(join.Subject))
L.activity <- dim(activities)[1] 
L.column <- dim(output_df)[2]

result <- matrix(NA, nrow=L.subject*L.activity, ncol=L.column) 
result <- as.data.frame(result)

colnames(result) <- colnames(output_df)

#must be a better way to do this.... if you are reviewing please help? 
#Note to self you can solve stock problem using a simmialar approach but for the love of use
#pandas not R

row <- 1
for(i in 1:L.subject) {
  for(j in 1:L.activity) {
    result[row, 1] <- sort(unique(join.Subject)[, 1])[i]
    result[row, 2] <- activities[j, 2]
    bool1 <- i == output_df$subject
    bool2 <- activities[j, 2] == output_df$activity #crap spelling mistake grrrr
    result[row, 3:L.column] <- colMeans(output_df[bool1&bool2, 3:L.column])
    row <- row + 1
  }
}

View(result)
write.table(result, "data/data_with_means.txt",row.name=FALSE ) 

