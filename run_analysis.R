#Note: this script assumes your workdirectory is the "UCI HAR Dataset" directory

########################################################################
#PART ONE: merge the training and the test sets to create one data set.#
########################################################################

#read in the activity labels and features
activity_labels <- read.table("./activity_labels.txt")
features <- read.table("./features.txt")

#read in the test data
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

#combine the subject information with the test and label information
merged_test <- cbind(subject_test, y_test, X_test)

#read in the train data
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

#combine the subject information with the train and label information
merged_train <- cbind(subject_train, y_train, X_train)

#Merge the training and the test sets to create one data set.
merged_sets <- rbind(merged_test, merged_train)

#give each column the correct name
names(merged_sets) <- cbind(matrix(c("subject","label"),1,2),matrix(features[,2],1,nrow(features)))

###################################################################################################
# PART TWO: extract only the measurements on the mean and standard deviation for each measurement.# 
###################################################################################################
#create a logical variable which contains only the names with means and standard deviations
names_with_mean_or_std <- grepl("mean",names(merged_sets),ignore.case = TRUE) | grepl("std",names(merged_sets),ignore.case = TRUE)
#extract only the relevant columns from the dataset
merged_sets <- cbind(merged_sets[,1:2],merged_sets[,names_with_mean_or_std])

#####################################################################################
# PART THREE: Uses descriptive activity names to name the activities in the data set#
#####################################################################################

#rename the column in activity_labels containing the activity
names(activity_labels)[2] <- "Activity"
#merge activity_labels with the merged_sets where the relevant id is the label column
merged_sets <- merge(merged_sets,activity_labels, by.x="label", by.y="V1", all.x=TRUE)

#################################################################################
# PART FOUR: Appropriately label the data set with descriptive variable names. #
#################################################################################
#define a function that creates a name for a row
nameForRow <- function(rowIndex){
  #give a descriptive name based on the original row number, subject and the activity
  paste("row",row.names(merged_sets)[rowIndex], "subject ",merged_sets$subject[rowIndex]," is ",merged_sets$Activity[rowIndex], sep=" ")
}
#apply to all rows
row.names(merged_sets) <- sapply(1:nrow(merged_sets),nameForRow)


######################################################################################
# PART FIVE: From the data set in step 4, create a second, independent tidy data set #
# with the average of each variable for each activity and each subject.              #
######################################################################################

#first make the first two columns where you make all possible combinations of subjects and activity
unique_sets <- unique(cbind(as.matrix(merged_sets$subject),as.matrix(merged_sets$Activity)))
#list of all measurement variables
measVars <- names(merged_sets)[3:88]
#replicate each row 86 times i.e. one row per measurement variable
unique_sets <- cbind(rep(unique_sets[,1],length(measVars)), rep(unique_sets[,2], length(measVars)))
#oder these columns to be increasing
unique_sets <- unique_sets[order(as.numeric(unique_sets[,1]),unique_sets[,2],decreasing=FALSE),]
#now add the correct activity measurement in each row
new_sets <- cbind(unique_sets, rep(measVars))

#make a function that looks up the correct mean for each measurement for each subject and activity
meanLookUp <- function(rowIndex){
  
  mean(merged_sets[merged_sets[,2] == new_sets[rowIndex,1] & merged_sets[,89] == new_sets[rowIndex,2], new_sets[rowIndex,3]])
}
#apply to all rows
new_col <- sapply(1:nrow(new_sets),meanLookUp)
#append your measurements to your rows
new_sets <- cbind(new_sets, new_col)

#name each column of your new_sets
colnames(new_sets) <- c("Subject", "Activity", "MeasurementName", "MeanOfMeasurement")

#uncomment the following line to export the final data set
#write.table(new_sets, file="final_set.txt",row.names=FALSE)