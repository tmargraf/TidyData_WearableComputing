## Code Book: Getting and Cleaning Data
This code book, per instructions, modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.

### Overview / Basic Information
Tim Margraf Project Johns Hopkins Data Sciences Month 3 project:  Getting and Cleaning Data
4/28/2019
The following Code Book is per instructions from the project:  "code book that modifies and updates the available codebooks with the data"
Thus, I have taken the original information provided with the data, and added updates.  
Moved acknowledgements to the bottom for Smartlab information.

### Files
The dataset includes the following files:

- 'run_analysis.R':  My code file to create the tidy data sets.

- 'activity_labels.txt':  This file associates the activities to a numeric value.  My code read in this file to create row names.

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.  My code read in this file to create column names.

- 'X_train.txt': Training set.  My code read this file in and merged it with the test data, per instructions.

- 'y_train.txt': Training labels.  My code read this file in to be able to identify which activity pertained to which row.

- 'X_test.txt': Test set.  My code read this file in and merged it with the train file, per instructions.

- 'y_test.txt': Test labels.  My code read this file in to be able to identify which activity pertained to which row.

- 'subject_train.txt': Listing of which subject performed the test.  My code read this file in and used it to perform final averages.

- 'subject_test.txt': Listing of which subject performed the test for test data.  My code read this file in and used it to perform final averages.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

### Key Variables
- 'trainSet': The train data frame.
- 'testSet': The test data frame.
- 'combinedSet': The 2 data sets merged, data frame.
- 'columnNames': The names of the columns for the combined data set, extracted from features.txt
- 'activities': The row descriptions, derived from activity_labels.txt
- 'trimmedSet': The resulting data set, after trimming off columns not related to mean or standard deviation
- 'FinalDataSet': The final data set that gets printed using write.table()

### Methods
- 'mergeDataSets': The function that performs the main tidying function.  This method satisfies the first 4 of the 5 requirements:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.

- 'generateFinalDataSet': This function performs the final clean up, and performs step 5 in the instructions.
* Loops through all activities and subjects and finds the means for each pairing
* Assigns proper column names
* Adds these means to the final data table
* Prints out the final data set

### Key Calculations and Operations in the Code
* Merged the training data set with the test data set into one data set, satisfying the requirement "Merges the training and the test sets to create one data set."
* Created meaningful column names, satisfying the requirement "Appropriately labels the data set with descriptive variable names."
** Made each column name unique, removed dupes
* Labeled the rows with activity names, satisfying the requirement "Uses descriptive activity names to name the activities in the data set"
** Made each row name unique by appending a counter to the end
* Trimmed the final data set to remove any column that was not related to mean or standard deviation.  This satisfies the requirement "Extracts only the measurements on the mean and standard deviation for each measurement."
* Calculated the mean of each pairing of subject and activity, total 180 of them

### Important Notes: 

- All operations were done within the code.  No data cleaning or tidying was done manually.
- Code is commented to show how I did this.

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


Human Activity Recognition Using Smartphones Dataset
Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

