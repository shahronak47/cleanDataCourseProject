==================================================================
## Run_analysis.R
Extract the means of measurements of an experiment data set provided by Smartlab -  Non Linear Complex Systems Laboratory.
Version 1.0
==================================================================
#student name: Graham Spinks
Coursera course project
17/02/2015

==================================================================
The original data is based on a dataset by
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The R script performs the following operations:

#PART ONE: merge the training and the test sets to create one data set.

In this part we read in the original data files and carry out simple mergers 
in order to create a full data set of training and test data.

All of the columns are given a relevant name.

# PART TWO: extract only the measurements on the mean and standard deviation for each measurement.

We create a logical variable which contains only the names with means and standard deviations
and subsequently extract only the relevant columns from the dataset

# PART THREE: Uses descriptive activity names to name the activities in the data set


We rename the column in activity_labels containing the activity
and merge activity_labels with the merged_sets where the relevant id on which we merge is the label column.


# PART FOUR: Appropriately label the data set with descriptive variable names. 

We define a function that creates a name for a row and then apply that function to all 
rows such that we have descriptive variable names.


# PART FIVE: From the data set in step 4, create a second, independent tidy data set 
# with the average of each variable for each activity and each subject.              

We first make the first two columns where you make all possible combinations of subjects and activity.
We replicate each row 86 times i.e. one row per measurement variable and order these columns to be increasing.
Finally we add the correct activity measurement in each row.

Next, we make a function that looks up and calculates the correct mean for each measurement for each subject and activity
and apply that to all rows.

We then name each column of our new set.

Finally we export the data to txt format.

