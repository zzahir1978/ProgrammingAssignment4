The Cood Book

The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s assignment definition.

1. Download the dataset
	The dataset is downloaded and extracted under the folder called UCI HAR Dataset

2. Assign each data to variables
	Based on the dataset, the following are the assigned variables:-
	a. features <- features.txt : 561 rows, 2 columns 
	◦	The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
	b. activities <- activity_labels.txt : 6 rows, 2 columns 
	◦	List of activities performed when the corresponding measurements were taken and its codes (labels)
	c. subject_test <- test/subject_test.txt : 2947 rows, 1 column 
	◦	contains test data of 9/30 volunteer test subjects being observed
	d. x_test <- test/X_test.txt : 2947 rows, 561 columns 
	◦	contains recorded features test data
	e. y_test <- test/y_test.txt : 2947 rows, 1 columns 
	◦	contains test data of activities’code labels
	f. subject_train <- test/subject_train.txt : 7352 rows, 1 column 
	◦	contains train data of 21/30 volunteer subjects being observed
	g. x_train <- test/X_train.txt : 7352 rows, 561 columns 
	◦	contains recorded features train data
	h. y_train <- test/y_train.txt : 7352 rows, 1 columns 
	◦	contains train data of activities’code labels

3. Merges the training and the test sets to create one data set
	a. X (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
	b. Y (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
	c. Subject (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function
	d. Merged_Data (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function

4. Extracts only the measurements on the mean and standard deviation for each measurement
	a. TidyData (10299 rows, 88 columns) is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement
	
5. Uses descriptive activity names to name the activities in the data set
	a. Entire numbers in code column of the TidyData replaced with corresponding activity taken from second column of the activities variable
	
6. Appropriately labels the data set with descriptive variable names
	a. code column in TidyData renamed into activities
	b. All Acc in column’s name replaced by Accelerometer
	c. All Gyro in column’s name replaced by Gyroscope
	d. All BodyBody in column’s name replaced by Body
	e. All Mag in column’s name replaced by Magnitude
	f. All start with character f in column’s name replaced by Frequency
	g. All start with character t in column’s name replaced by Time
	
7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
	a. FinalData (180 rows, 88 columns) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
	b. Export FinalData into FinalData.txt file.