> library(dplyr)

Attaching package: 'dplyr'

The following objects are masked from 'package:xts':

    first, last

The following objects are masked from 'package:data.table':

    between, first, last

The following objects are masked from 'package:stats':

    filter, lag

The following objects are masked from 'package:base':

    intersect, setdiff, setequal, union

> if (!file.exists(filename)){
+   fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
+   download.file(fileURL, filename, method="curl")
+ }  
Error in file.exists(filename) : object 'filename' not found
> filename <- "Coursera_DS3_Final.zip"
> 
> if (!file.exists(filename)){
+   fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
+   download.file(fileURL, filename, method="curl")
+ }
100 59.6M  100 59.6M    0     0  1977k      0  0:00:30  0:00:30 --:--:-- 1401k:-- --:--:--     0
> 
> if (!file.exists("UCI HAR Dataset")) { 
+   unzip(filename) 
+ }
> 
> features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
> activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
> subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
> x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
> y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
> subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
> x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
> y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
> 
> X <- rbind(x_train, x_test)
> Y <- rbind(y_train, y_test)
> Subject <- rbind(subject_train, subject_test)
> Merged_Data <- cbind(Subject, Y, X)
> 
> TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))
> 
> TidyData$code <- activities[TidyData$code, 2]
> 
> names(TidyData)[2] = "activity"
> names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
> names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
> names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
> names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
> names(TidyData)<-gsub("^t", "Time", names(TidyData))
> names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
> names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
> names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
> names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
> names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
> names(TidyData)<-gsub("angle", "Angle", names(TidyData))
> names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))
> 
> FinalData <- TidyData %>%
+     group_by(subject, activity) %>%
+     summarise_all(funs(mean))
Warning message:
funs() is soft deprecated as of dplyr 0.8.0
Please use a list of either functions or lambdas: 

  # Simple named list: 
  list(mean = mean, median = median)

  # Auto named with `tibble::lst()`: 
  tibble::lst(mean, median)

  # Using lambdas
  list(~ mean(., trim = .2), ~ median(., na.rm = TRUE))
This warning is displayed once per session. 
> write.table(FinalData, "FinalData.txt", row.name=FALSE)
> 
> str(FinalData)
tibble [180 x 88] (S3: grouped_df/tbl_df/tbl/data.frame)
 $ subject                                           : int [1:180] 1 1 1 1 1 1 2 2 2 2 ...
 $ activity                                          : chr [1:180] "LAYING" "SITTING" "STANDING" "WALKING" ...
 $ TimeBodyAccelerometer.mean...X                    : num [1:180] 0.222 0.261 0.279 0.277 0.289 ...
 $ TimeBodyAccelerometer.mean...Y                    : num [1:180] -0.04051 -0.00131 -0.01614 -0.01738 -0.00992 ...
 $ TimeBodyAccelerometer.mean...Z                    : num [1:180] -0.113 -0.105 -0.111 -0.111 -0.108 ...
 $ TimeGravityAccelerometer.mean...X                 : num [1:180] -0.249 0.832 0.943 0.935 0.932 ...
 $ TimeGravityAccelerometer.mean...Y                 : num [1:180] 0.706 0.204 -0.273 -0.282 -0.267 ...
 $ TimeGravityAccelerometer.mean...Z                 : num [1:180] 0.4458 0.332 0.0135 -0.0681 -0.0621 ...
 $ TimeBodyAccelerometerJerk.mean...X                : num [1:180] 0.0811 0.0775 0.0754 0.074 0.0542 ...
 $ TimeBodyAccelerometerJerk.mean...Y                : num [1:180] 0.003838 -0.000619 0.007976 0.028272 0.02965 ...
 $ TimeBodyAccelerometerJerk.mean...Z                : num [1:180] 0.01083 -0.00337 -0.00369 -0.00417 -0.01097 ...
 $ TimeBodyGyroscope.mean...X                        : num [1:180] -0.0166 -0.0454 -0.024 -0.0418 -0.0351 ...
 $ TimeBodyGyroscope.mean...Y                        : num [1:180] -0.0645 -0.0919 -0.0594 -0.0695 -0.0909 ...
 $ TimeBodyGyroscope.mean...Z                        : num [1:180] 0.1487 0.0629 0.0748 0.0849 0.0901 ...
 $ TimeBodyGyroscopeJerk.mean...X                    : num [1:180] -0.1073 -0.0937 -0.0996 -0.09 -0.074 ...
 $ TimeBodyGyroscopeJerk.mean...Y                    : num [1:180] -0.0415 -0.0402 -0.0441 -0.0398 -0.044 ...
 $ TimeBodyGyroscopeJerk.mean...Z                    : num [1:180] -0.0741 -0.0467 -0.049 -0.0461 -0.027 ...
 $ TimeBodyAccelerometerMagnitude.mean..             : num [1:180] -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...
 $ TimeGravityAccelerometerMagnitude.mean..          : num [1:180] -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...
 $ TimeBodyAccelerometerJerkMagnitude.mean..         : num [1:180] -0.9544 -0.9874 -0.9924 -0.1414 -0.0894 ...
 $ TimeBodyGyroscopeMagnitude.mean..                 : num [1:180] -0.8748 -0.9309 -0.9765 -0.161 -0.0757 ...
 $ TimeBodyGyroscopeJerkMagnitude.mean..             : num [1:180] -0.963 -0.992 -0.995 -0.299 -0.295 ...
 $ FrequencyBodyAccelerometer.mean...X               : num [1:180] -0.9391 -0.9796 -0.9952 -0.2028 0.0382 ...
 $ FrequencyBodyAccelerometer.mean...Y               : num [1:180] -0.86707 -0.94408 -0.97707 0.08971 0.00155 ...
 $ FrequencyBodyAccelerometer.mean...Z               : num [1:180] -0.883 -0.959 -0.985 -0.332 -0.226 ...
 $ FrequencyBodyAccelerometer.meanFreq...X           : num [1:180] -0.1588 -0.0495 0.0865 -0.2075 -0.3074 ...
 $ FrequencyBodyAccelerometer.meanFreq...Y           : num [1:180] 0.0975 0.0759 0.1175 0.1131 0.0632 ...
 $ FrequencyBodyAccelerometer.meanFreq...Z           : num [1:180] 0.0894 0.2388 0.2449 0.0497 0.2943 ...
 $ FrequencyBodyAccelerometerJerk.mean...X           : num [1:180] -0.9571 -0.9866 -0.9946 -0.1705 -0.0277 ...
 $ FrequencyBodyAccelerometerJerk.mean...Y           : num [1:180] -0.9225 -0.9816 -0.9854 -0.0352 -0.1287 ...
 $ FrequencyBodyAccelerometerJerk.mean...Z           : num [1:180] -0.948 -0.986 -0.991 -0.469 -0.288 ...
 $ FrequencyBodyAccelerometerJerk.meanFreq...X       : num [1:180] 0.132 0.257 0.314 -0.209 -0.253 ...
 $ FrequencyBodyAccelerometerJerk.meanFreq...Y       : num [1:180] 0.0245 0.0475 0.0392 -0.3862 -0.3376 ...
 $ FrequencyBodyAccelerometerJerk.meanFreq...Z       : num [1:180] 0.02439 0.09239 0.13858 -0.18553 0.00937 ...
 $ FrequencyBodyGyroscope.mean...X                   : num [1:180] -0.85 -0.976 -0.986 -0.339 -0.352 ...
 $ FrequencyBodyGyroscope.mean...Y                   : num [1:180] -0.9522 -0.9758 -0.989 -0.1031 -0.0557 ...
 $ FrequencyBodyGyroscope.mean...Z                   : num [1:180] -0.9093 -0.9513 -0.9808 -0.2559 -0.0319 ...
 $ FrequencyBodyGyroscope.meanFreq...X               : num [1:180] -0.00355 0.18915 -0.12029 0.01478 -0.10045 ...
 $ FrequencyBodyGyroscope.meanFreq...Y               : num [1:180] -0.0915 0.0631 -0.0447 -0.0658 0.0826 ...
 $ FrequencyBodyGyroscope.meanFreq...Z               : num [1:180] 0.010458 -0.029784 0.100608 0.000773 -0.075676 ...
 $ FrequencyBodyAccelerometerMagnitude.mean..        : num [1:180] -0.8618 -0.9478 -0.9854 -0.1286 0.0966 ...
 $ FrequencyBodyAccelerometerMagnitude.meanFreq..    : num [1:180] 0.0864 0.2367 0.2846 0.1906 0.1192 ...
 $ FrequencyBodyAccelerometerJerkMagnitude.mean..    : num [1:180] -0.9333 -0.9853 -0.9925 -0.0571 0.0262 ...
 $ FrequencyBodyAccelerometerJerkMagnitude.meanFreq..: num [1:180] 0.2664 0.3519 0.4222 0.0938 0.0765 ...
 $ FrequencyBodyGyroscopeMagnitude.mean..            : num [1:180] -0.862 -0.958 -0.985 -0.199 -0.186 ...
 $ FrequencyBodyGyroscopeMagnitude.meanFreq..        : num [1:180] -0.139775 -0.000262 -0.028606 0.268844 0.349614 ...
 $ FrequencyBodyGyroscopeJerkMagnitude.mean..        : num [1:180] -0.942 -0.99 -0.995 -0.319 -0.282 ...
 $ FrequencyBodyGyroscopeJerkMagnitude.meanFreq..    : num [1:180] 0.176 0.185 0.334 0.191 0.19 ...
 $ Angle.TimeBodyAccelerometerMean.Gravity.          : num [1:180] 0.021366 0.027442 -0.000222 0.060454 -0.002695 ...
 $ Angle.TimeBodyAccelerometerJerkMean..GravityMean. : num [1:180] 0.00306 0.02971 0.02196 -0.00793 0.08993 ...
 $ Angle.TimeBodyGyroscopeMean.GravityMean.          : num [1:180] -0.00167 0.0677 -0.03379 0.01306 0.06334 ...
 $ Angle.TimeBodyGyroscopeJerkMean.GravityMean.      : num [1:180] 0.0844 -0.0649 -0.0279 -0.0187 -0.04 ...
 $ Angle.X.GravityMean.                              : num [1:180] 0.427 -0.591 -0.743 -0.729 -0.744 ...
 $ Angle.Y.GravityMean.                              : num [1:180] -0.5203 -0.0605 0.2702 0.277 0.2672 ...
 $ Angle.Z.GravityMean.                              : num [1:180] -0.3524 -0.218 0.0123 0.0689 0.065 ...
 $ TimeBodyAccelerometer.std...X                     : num [1:180] -0.928 -0.977 -0.996 -0.284 0.03 ...
 $ TimeBodyAccelerometer.std...Y                     : num [1:180] -0.8368 -0.9226 -0.9732 0.1145 -0.0319 ...
 $ TimeBodyAccelerometer.std...Z                     : num [1:180] -0.826 -0.94 -0.98 -0.26 -0.23 ...
 $ TimeGravityAccelerometer.std...X                  : num [1:180] -0.897 -0.968 -0.994 -0.977 -0.951 ...
 $ TimeGravityAccelerometer.std...Y                  : num [1:180] -0.908 -0.936 -0.981 -0.971 -0.937 ...
 $ TimeGravityAccelerometer.std...Z                  : num [1:180] -0.852 -0.949 -0.976 -0.948 -0.896 ...
 $ TimeBodyAccelerometerJerk.std...X                 : num [1:180] -0.9585 -0.9864 -0.9946 -0.1136 -0.0123 ...
 $ TimeBodyAccelerometerJerk.std...Y                 : num [1:180] -0.924 -0.981 -0.986 0.067 -0.102 ...
 $ TimeBodyAccelerometerJerk.std...Z                 : num [1:180] -0.955 -0.988 -0.992 -0.503 -0.346 ...
 $ TimeBodyGyroscope.std...X                         : num [1:180] -0.874 -0.977 -0.987 -0.474 -0.458 ...
 $ TimeBodyGyroscope.std...Y                         : num [1:180] -0.9511 -0.9665 -0.9877 -0.0546 -0.1263 ...
 $ TimeBodyGyroscope.std...Z                         : num [1:180] -0.908 -0.941 -0.981 -0.344 -0.125 ...
 $ TimeBodyGyroscopeJerk.std...X                     : num [1:180] -0.919 -0.992 -0.993 -0.207 -0.487 ...
 $ TimeBodyGyroscopeJerk.std...Y                     : num [1:180] -0.968 -0.99 -0.995 -0.304 -0.239 ...
 $ TimeBodyGyroscopeJerk.std...Z                     : num [1:180] -0.958 -0.988 -0.992 -0.404 -0.269 ...
 $ TimeBodyAccelerometerMagnitude.std..              : num [1:180] -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...
 $ TimeGravityAccelerometerMagnitude.std..           : num [1:180] -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...
 $ TimeBodyAccelerometerJerkMagnitude.std..          : num [1:180] -0.9282 -0.9841 -0.9931 -0.0745 -0.0258 ...
 $ TimeBodyGyroscopeMagnitude.std..                  : num [1:180] -0.819 -0.935 -0.979 -0.187 -0.226 ...
 $ TimeBodyGyroscopeJerkMagnitude.std..              : num [1:180] -0.936 -0.988 -0.995 -0.325 -0.307 ...
 $ FrequencyBodyAccelerometer.std...X                : num [1:180] -0.9244 -0.9764 -0.996 -0.3191 0.0243 ...
 $ FrequencyBodyAccelerometer.std...Y                : num [1:180] -0.834 -0.917 -0.972 0.056 -0.113 ...
 $ FrequencyBodyAccelerometer.std...Z                : num [1:180] -0.813 -0.934 -0.978 -0.28 -0.298 ...
 $ FrequencyBodyAccelerometerJerk.std...X            : num [1:180] -0.9642 -0.9875 -0.9951 -0.1336 -0.0863 ...
 $ FrequencyBodyAccelerometerJerk.std...Y            : num [1:180] -0.932 -0.983 -0.987 0.107 -0.135 ...
 $ FrequencyBodyAccelerometerJerk.std...Z            : num [1:180] -0.961 -0.988 -0.992 -0.535 -0.402 ...
 $ FrequencyBodyGyroscope.std...X                    : num [1:180] -0.882 -0.978 -0.987 -0.517 -0.495 ...
 $ FrequencyBodyGyroscope.std...Y                    : num [1:180] -0.9512 -0.9623 -0.9871 -0.0335 -0.1814 ...
 $ FrequencyBodyGyroscope.std...Z                    : num [1:180] -0.917 -0.944 -0.982 -0.437 -0.238 ...
 $ FrequencyBodyAccelerometerMagnitude.std..         : num [1:180] -0.798 -0.928 -0.982 -0.398 -0.187 ...
 $ FrequencyBodyAccelerometerJerkMagnitude.std..     : num [1:180] -0.922 -0.982 -0.993 -0.103 -0.104 ...
 $ FrequencyBodyGyroscopeMagnitude.std..             : num [1:180] -0.824 -0.932 -0.978 -0.321 -0.398 ...
 $ FrequencyBodyGyroscopeJerkMagnitude.std..         : num [1:180] -0.933 -0.987 -0.995 -0.382 -0.392 ...
 - attr(*, "groups")= tibble [30 x 2] (S3: tbl_df/tbl/data.frame)
  ..$ subject: int [1:30] 1 2 3 4 5 6 7 8 9 10 ...
  ..$ .rows  :List of 30
  .. ..$ : int [1:6] 1 2 3 4 5 6
  .. ..$ : int [1:6] 7 8 9 10 11 12
  .. ..$ : int [1:6] 13 14 15 16 17 18
  .. ..$ : int [1:6] 19 20 21 22 23 24
  .. ..$ : int [1:6] 25 26 27 28 29 30
  .. ..$ : int [1:6] 31 32 33 34 35 36
  .. ..$ : int [1:6] 37 38 39 40 41 42
  .. ..$ : int [1:6] 43 44 45 46 47 48
  .. ..$ : int [1:6] 49 50 51 52 53 54
  .. ..$ : int [1:6] 55 56 57 58 59 60
  .. ..$ : int [1:6] 61 62 63 64 65 66
  .. ..$ : int [1:6] 67 68 69 70 71 72
  .. ..$ : int [1:6] 73 74 75 76 77 78
  .. ..$ : int [1:6] 79 80 81 82 83 84
  .. ..$ : int [1:6] 85 86 87 88 89 90
  .. ..$ : int [1:6] 91 92 93 94 95 96
  .. ..$ : int [1:6] 97 98 99 100 101 102
  .. ..$ : int [1:6] 103 104 105 106 107 108
  .. ..$ : int [1:6] 109 110 111 112 113 114
  .. ..$ : int [1:6] 115 116 117 118 119 120
  .. ..$ : int [1:6] 121 122 123 124 125 126
  .. ..$ : int [1:6] 127 128 129 130 131 132
  .. ..$ : int [1:6] 133 134 135 136 137 138
  .. ..$ : int [1:6] 139 140 141 142 143 144
  .. ..$ : int [1:6] 145 146 147 148 149 150
  .. ..$ : int [1:6] 151 152 153 154 155 156
  .. ..$ : int [1:6] 157 158 159 160 161 162
  .. ..$ : int [1:6] 163 164 165 166 167 168
  .. ..$ : int [1:6] 169 170 171 172 173 174
  .. ..$ : int [1:6] 175 176 177 178 179 180
  ..- attr(*, ".drop")= logi TRUE
> 
> FinalData
# A tibble: 180 x 88
# Groups:   subject [30]
   subject activity TimeBodyAcceler~ TimeBodyAcceler~ TimeBodyAcceler~ TimeGravityAcce~
     <int> <chr>               <dbl>            <dbl>            <dbl>            <dbl>
 1       1 LAYING              0.222         -0.0405           -0.113            -0.249
 2       1 SITTING             0.261         -0.00131          -0.105             0.832
 3       1 STANDING            0.279         -0.0161           -0.111             0.943
 4       1 WALKING             0.277         -0.0174           -0.111             0.935
 5       1 WALKING~            0.289         -0.00992          -0.108             0.932
 6       1 WALKING~            0.255         -0.0240           -0.0973            0.893
 7       2 LAYING              0.281         -0.0182           -0.107            -0.510
 8       2 SITTING             0.277         -0.0157           -0.109             0.940
 9       2 STANDING            0.278         -0.0184           -0.106             0.897
10       2 WALKING             0.276         -0.0186           -0.106             0.913
# ... with 170 more rows, and 82 more variables: TimeGravityAccelerometer.mean...Y <dbl>,
#   TimeGravityAccelerometer.mean...Z <dbl>, TimeBodyAccelerometerJerk.mean...X <dbl>,
#   TimeBodyAccelerometerJerk.mean...Y <dbl>, TimeBodyAccelerometerJerk.mean...Z <dbl>,
#   TimeBodyGyroscope.mean...X <dbl>, TimeBodyGyroscope.mean...Y <dbl>,
#   TimeBodyGyroscope.mean...Z <dbl>, TimeBodyGyroscopeJerk.mean...X <dbl>,
#   TimeBodyGyroscopeJerk.mean...Y <dbl>, TimeBodyGyroscopeJerk.mean...Z <dbl>,
#   TimeBodyAccelerometerMagnitude.mean.. <dbl>, TimeGravityAccelerometerMagnitude.mean.. <dbl>,
#   TimeBodyAccelerometerJerkMagnitude.mean.. <dbl>, TimeBodyGyroscopeMagnitude.mean.. <dbl>,
#   TimeBodyGyroscopeJerkMagnitude.mean.. <dbl>, FrequencyBodyAccelerometer.mean...X <dbl>,
#   FrequencyBodyAccelerometer.mean...Y <dbl>, FrequencyBodyAccelerometer.mean...Z <dbl>,
#   FrequencyBodyAccelerometer.meanFreq...X <dbl>,
#   FrequencyBodyAccelerometer.meanFreq...Y <dbl>,
#   FrequencyBodyAccelerometer.meanFreq...Z <dbl>,
#   FrequencyBodyAccelerometerJerk.mean...X <dbl>,
#   FrequencyBodyAccelerometerJerk.mean...Y <dbl>,
#   FrequencyBodyAccelerometerJerk.mean...Z <dbl>,
#   FrequencyBodyAccelerometerJerk.meanFreq...X <dbl>,
#   FrequencyBodyAccelerometerJerk.meanFreq...Y <dbl>,
#   FrequencyBodyAccelerometerJerk.meanFreq...Z <dbl>, FrequencyBodyGyroscope.mean...X <dbl>,
#   FrequencyBodyGyroscope.mean...Y <dbl>, FrequencyBodyGyroscope.mean...Z <dbl>,
#   FrequencyBodyGyroscope.meanFreq...X <dbl>, FrequencyBodyGyroscope.meanFreq...Y <dbl>,
#   FrequencyBodyGyroscope.meanFreq...Z <dbl>, FrequencyBodyAccelerometerMagnitude.mean.. <dbl>,
#   FrequencyBodyAccelerometerMagnitude.meanFreq.. <dbl>,
#   FrequencyBodyAccelerometerJerkMagnitude.mean.. <dbl>,
#   FrequencyBodyAccelerometerJerkMagnitude.meanFreq.. <dbl>,
#   FrequencyBodyGyroscopeMagnitude.mean.. <dbl>,
#   FrequencyBodyGyroscopeMagnitude.meanFreq.. <dbl>,
#   FrequencyBodyGyroscopeJerkMagnitude.mean.. <dbl>,
#   FrequencyBodyGyroscopeJerkMagnitude.meanFreq.. <dbl>,
#   Angle.TimeBodyAccelerometerMean.Gravity. <dbl>,
#   Angle.TimeBodyAccelerometerJerkMean..GravityMean. <dbl>,
#   Angle.TimeBodyGyroscopeMean.GravityMean. <dbl>,
#   Angle.TimeBodyGyroscopeJerkMean.GravityMean. <dbl>, Angle.X.GravityMean. <dbl>,
#   Angle.Y.GravityMean. <dbl>, Angle.Z.GravityMean. <dbl>, TimeBodyAccelerometer.std...X <dbl>,
#   TimeBodyAccelerometer.std...Y <dbl>, TimeBodyAccelerometer.std...Z <dbl>,
#   TimeGravityAccelerometer.std...X <dbl>, TimeGravityAccelerometer.std...Y <dbl>,
#   TimeGravityAccelerometer.std...Z <dbl>, TimeBodyAccelerometerJerk.std...X <dbl>,
#   TimeBodyAccelerometerJerk.std...Y <dbl>, TimeBodyAccelerometerJerk.std...Z <dbl>,
#   TimeBodyGyroscope.std...X <dbl>, TimeBodyGyroscope.std...Y <dbl>,
#   TimeBodyGyroscope.std...Z <dbl>, TimeBodyGyroscopeJerk.std...X <dbl>,
#   TimeBodyGyroscopeJerk.std...Y <dbl>, TimeBodyGyroscopeJerk.std...Z <dbl>,
#   TimeBodyAccelerometerMagnitude.std.. <dbl>, TimeGravityAccelerometerMagnitude.std.. <dbl>,
#   TimeBodyAccelerometerJerkMagnitude.std.. <dbl>, TimeBodyGyroscopeMagnitude.std.. <dbl>,
#   TimeBodyGyroscopeJerkMagnitude.std.. <dbl>, FrequencyBodyAccelerometer.std...X <dbl>,
#   FrequencyBodyAccelerometer.std...Y <dbl>, FrequencyBodyAccelerometer.std...Z <dbl>,
#   FrequencyBodyAccelerometerJerk.std...X <dbl>, FrequencyBodyAccelerometerJerk.std...Y <dbl>,
#   FrequencyBodyAccelerometerJerk.std...Z <dbl>, FrequencyBodyGyroscope.std...X <dbl>,
#   FrequencyBodyGyroscope.std...Y <dbl>, FrequencyBodyGyroscope.std...Z <dbl>,
#   FrequencyBodyAccelerometerMagnitude.std.. <dbl>,
#   FrequencyBodyAccelerometerJerkMagnitude.std.. <dbl>,
#   FrequencyBodyGyroscopeMagnitude.std.. <dbl>, FrequencyBodyGyroscopeJerkMagnitude.std.. <dbl>
> dim(FinalData)
[1] 180  88
> summary(FinalData)
    subject       activity         TimeBodyAccelerometer.mean...X TimeBodyAccelerometer.mean...Y
 Min.   : 1.0   Length:180         Min.   :0.2216                 Min.   :-0.040514             
 1st Qu.: 8.0   Class :character   1st Qu.:0.2712                 1st Qu.:-0.020022             
 Median :15.5   Mode  :character   Median :0.2770                 Median :-0.017262             
 Mean   :15.5                      Mean   :0.2743                 Mean   :-0.017876             
 3rd Qu.:23.0                      3rd Qu.:0.2800                 3rd Qu.:-0.014936             
 Max.   :30.0                      Max.   :0.3015                 Max.   :-0.001308             
 TimeBodyAccelerometer.mean...Z TimeGravityAccelerometer.mean...X
 Min.   :-0.15251               Min.   :-0.6800                  
 1st Qu.:-0.11207               1st Qu.: 0.8376                  
 Median :-0.10819               Median : 0.9208                  
 Mean   :-0.10916               Mean   : 0.6975                  
 3rd Qu.:-0.10443               3rd Qu.: 0.9425                  
 Max.   :-0.07538               Max.   : 0.9745                  
 TimeGravityAccelerometer.mean...Y TimeGravityAccelerometer.mean...Z
 Min.   :-0.47989                  Min.   :-0.49509                 
 1st Qu.:-0.23319                  1st Qu.:-0.11726                 
 Median :-0.12782                  Median : 0.02384                 
 Mean   :-0.01621                  Mean   : 0.07413                 
 3rd Qu.: 0.08773                  3rd Qu.: 0.14946                 
 Max.   : 0.95659                  Max.   : 0.95787                 
 TimeBodyAccelerometerJerk.mean...X TimeBodyAccelerometerJerk.mean...Y
 Min.   :0.04269                    Min.   :-0.0386872                
 1st Qu.:0.07396                    1st Qu.: 0.0004664                
 Median :0.07640                    Median : 0.0094698                
 Mean   :0.07947                    Mean   : 0.0075652                
 3rd Qu.:0.08330                    3rd Qu.: 0.0134008                
 Max.   :0.13019                    Max.   : 0.0568186                
 TimeBodyAccelerometerJerk.mean...Z TimeBodyGyroscope.mean...X TimeBodyGyroscope.mean...Y
 Min.   :-0.067458                  Min.   :-0.20578           Min.   :-0.20421          
 1st Qu.:-0.010601                  1st Qu.:-0.04712           1st Qu.:-0.08955          
 Median :-0.003861                  Median :-0.02871           Median :-0.07318          
 Mean   :-0.004953                  Mean   :-0.03244           Mean   :-0.07426          
 3rd Qu.: 0.001958                  3rd Qu.:-0.01676           3rd Qu.:-0.06113          
 Max.   : 0.038053                  Max.   : 0.19270           Max.   : 0.02747          
 TimeBodyGyroscope.mean...Z TimeBodyGyroscopeJerk.mean...X TimeBodyGyroscopeJerk.mean...Y
 Min.   :-0.07245           Min.   :-0.15721               Min.   :-0.07681              
 1st Qu.: 0.07475           1st Qu.:-0.10322               1st Qu.:-0.04552              
 Median : 0.08512           Median :-0.09868               Median :-0.04112              
 Mean   : 0.08744           Mean   :-0.09606               Mean   :-0.04269              
 3rd Qu.: 0.10177           3rd Qu.:-0.09110               3rd Qu.:-0.03842              
 Max.   : 0.17910           Max.   :-0.02209               Max.   :-0.01320              
 TimeBodyGyroscopeJerk.mean...Z TimeBodyAccelerometerMagnitude.mean..
 Min.   :-0.092500              Min.   :-0.9865                      
 1st Qu.:-0.061725              1st Qu.:-0.9573                      
 Median :-0.053430              Median :-0.4829                      
 Mean   :-0.054802              Mean   :-0.4973                      
 3rd Qu.:-0.048985              3rd Qu.:-0.0919                      
 Max.   :-0.006941              Max.   : 0.6446                      
 TimeGravityAccelerometerMagnitude.mean.. TimeBodyAccelerometerJerkMagnitude.mean..
 Min.   :-0.9865                          Min.   :-0.9928                          
 1st Qu.:-0.9573                          1st Qu.:-0.9807                          
 Median :-0.4829                          Median :-0.8168                          
 Mean   :-0.4973                          Mean   :-0.6079                          
 3rd Qu.:-0.0919                          3rd Qu.:-0.2456                          
 Max.   : 0.6446                          Max.   : 0.4345                          
 TimeBodyGyroscopeMagnitude.mean.. TimeBodyGyroscopeJerkMagnitude.mean..
 Min.   :-0.9807                   Min.   :-0.99732                     
 1st Qu.:-0.9461                   1st Qu.:-0.98515                     
 Median :-0.6551                   Median :-0.86479                     
 Mean   :-0.5652                   Mean   :-0.73637                     
 3rd Qu.:-0.2159                   3rd Qu.:-0.51186                     
 Max.   : 0.4180                   Max.   : 0.08758                     
 FrequencyBodyAccelerometer.mean...X FrequencyBodyAccelerometer.mean...Y
 Min.   :-0.9952                     Min.   :-0.98903                   
 1st Qu.:-0.9787                     1st Qu.:-0.95361                   
 Median :-0.7691                     Median :-0.59498                   
 Mean   :-0.5758                     Mean   :-0.48873                   
 3rd Qu.:-0.2174                     3rd Qu.:-0.06341                   
 Max.   : 0.5370                     Max.   : 0.52419                   
 FrequencyBodyAccelerometer.mean...Z FrequencyBodyAccelerometer.meanFreq...X
 Min.   :-0.9895                     Min.   :-0.63591                       
 1st Qu.:-0.9619                     1st Qu.:-0.39165                       
 Median :-0.7236                     Median :-0.25731                       
 Mean   :-0.6297                     Mean   :-0.23227                       
 3rd Qu.:-0.3183                     3rd Qu.:-0.06105                       
 Max.   : 0.2807                     Max.   : 0.15912                       
 FrequencyBodyAccelerometer.meanFreq...Y FrequencyBodyAccelerometer.meanFreq...Z
 Min.   :-0.379518                       Min.   :-0.52011                       
 1st Qu.:-0.081314                       1st Qu.:-0.03629                       
 Median : 0.007855                       Median : 0.06582                       
 Mean   : 0.011529                       Mean   : 0.04372                       
 3rd Qu.: 0.086281                       3rd Qu.: 0.17542                       
 Max.   : 0.466528                       Max.   : 0.40253                       
 FrequencyBodyAccelerometerJerk.mean...X FrequencyBodyAccelerometerJerk.mean...Y
 Min.   :-0.9946                         Min.   :-0.9894                        
 1st Qu.:-0.9828                         1st Qu.:-0.9725                        
 Median :-0.8126                         Median :-0.7817                        
 Mean   :-0.6139                         Mean   :-0.5882                        
 3rd Qu.:-0.2820                         3rd Qu.:-0.1963                        
 Max.   : 0.4743                         Max.   : 0.2767                        
 FrequencyBodyAccelerometerJerk.mean...Z FrequencyBodyAccelerometerJerk.meanFreq...X
 Min.   :-0.9920                         Min.   :-0.57604                           
 1st Qu.:-0.9796                         1st Qu.:-0.28966                           
 Median :-0.8707                         Median :-0.06091                           
 Mean   :-0.7144                         Mean   :-0.06910                           
 3rd Qu.:-0.4697                         3rd Qu.: 0.17660                           
 Max.   : 0.1578                         Max.   : 0.33145                           
 FrequencyBodyAccelerometerJerk.meanFreq...Y FrequencyBodyAccelerometerJerk.meanFreq...Z
 Min.   :-0.60197                            Min.   :-0.62756                           
 1st Qu.:-0.39751                            1st Qu.:-0.30867                           
 Median :-0.23209                            Median :-0.09187                           
 Mean   :-0.22810                            Mean   :-0.13760                           
 3rd Qu.:-0.04721                            3rd Qu.: 0.03858                           
 Max.   : 0.19568                            Max.   : 0.23011                           
 FrequencyBodyGyroscope.mean...X FrequencyBodyGyroscope.mean...Y FrequencyBodyGyroscope.mean...Z
 Min.   :-0.9931                 Min.   :-0.9940                 Min.   :-0.9860                
 1st Qu.:-0.9697                 1st Qu.:-0.9700                 1st Qu.:-0.9624                
 Median :-0.7300                 Median :-0.8141                 Median :-0.7909                
 Mean   :-0.6367                 Mean   :-0.6767                 Mean   :-0.6044                
 3rd Qu.:-0.3387                 3rd Qu.:-0.4458                 3rd Qu.:-0.2635                
 Max.   : 0.4750                 Max.   : 0.3288                 Max.   : 0.4924                
 FrequencyBodyGyroscope.meanFreq...X FrequencyBodyGyroscope.meanFreq...Y
 Min.   :-0.395770                   Min.   :-0.66681                   
 1st Qu.:-0.213363                   1st Qu.:-0.29433                   
 Median :-0.115527                   Median :-0.15794                   
 Mean   :-0.104551                   Mean   :-0.16741                   
 3rd Qu.: 0.002655                   3rd Qu.:-0.04269                   
 Max.   : 0.249209                   Max.   : 0.27314                   
 FrequencyBodyGyroscope.meanFreq...Z FrequencyBodyAccelerometerMagnitude.mean..
 Min.   :-0.50749                    Min.   :-0.9868                           
 1st Qu.:-0.15481                    1st Qu.:-0.9560                           
 Median :-0.05081                    Median :-0.6703                           
 Mean   :-0.05718                    Mean   :-0.5365                           
 3rd Qu.: 0.04152                    3rd Qu.:-0.1622                           
 Max.   : 0.37707                    Max.   : 0.5866                           
 FrequencyBodyAccelerometerMagnitude.meanFreq.. FrequencyBodyAccelerometerJerkMagnitude.mean..
 Min.   :-0.31234                               Min.   :-0.9940                               
 1st Qu.:-0.01475                               1st Qu.:-0.9770                               
 Median : 0.08132                               Median :-0.7940                               
 Mean   : 0.07613                               Mean   :-0.5756                               
 3rd Qu.: 0.17436                               3rd Qu.:-0.1872                               
 Max.   : 0.43585                               Max.   : 0.5384                               
 FrequencyBodyAccelerometerJerkMagnitude.meanFreq.. FrequencyBodyGyroscopeMagnitude.mean..
 Min.   :-0.12521                                   Min.   :-0.9865                       
 1st Qu.: 0.04527                                   1st Qu.:-0.9616                       
 Median : 0.17198                                   Median :-0.7657                       
 Mean   : 0.16255                                   Mean   :-0.6671                       
 3rd Qu.: 0.27593                                   3rd Qu.:-0.4087                       
 Max.   : 0.48809                                   Max.   : 0.2040                       
 FrequencyBodyGyroscopeMagnitude.meanFreq.. FrequencyBodyGyroscopeJerkMagnitude.mean..
 Min.   :-0.45664                           Min.   :-0.9976                           
 1st Qu.:-0.16951                           1st Qu.:-0.9813                           
 Median :-0.05352                           Median :-0.8779                           
 Mean   :-0.03603                           Mean   :-0.7564                           
 3rd Qu.: 0.08228                           3rd Qu.:-0.5831                           
 Max.   : 0.40952                           Max.   : 0.1466                           
 FrequencyBodyGyroscopeJerkMagnitude.meanFreq.. Angle.TimeBodyAccelerometerMean.Gravity.
 Min.   :-0.18292                               Min.   :-0.163043                       
 1st Qu.: 0.05423                               1st Qu.:-0.011012                       
 Median : 0.11156                               Median : 0.007878                       
 Mean   : 0.12592                               Mean   : 0.006556                       
 3rd Qu.: 0.20805                               3rd Qu.: 0.024393                       
 Max.   : 0.42630                               Max.   : 0.129154                       
 Angle.TimeBodyAccelerometerJerkMean..GravityMean. Angle.TimeBodyGyroscopeMean.GravityMean.
 Min.   :-0.1205540                                Min.   :-0.38931                        
 1st Qu.:-0.0211694                                1st Qu.:-0.01977                        
 Median : 0.0031358                                Median : 0.02087                        
 Mean   : 0.0006439                                Mean   : 0.02193                        
 3rd Qu.: 0.0220881                                3rd Qu.: 0.06460                        
 Max.   : 0.2032600                                Max.   : 0.44410                        
 Angle.TimeBodyGyroscopeJerkMean.GravityMean. Angle.X.GravityMean. Angle.Y.GravityMean.
 Min.   :-0.22367                             Min.   :-0.9471      Min.   :-0.87457    
 1st Qu.:-0.05613                             1st Qu.:-0.7907      1st Qu.: 0.02191    
 Median :-0.01602                             Median :-0.7377      Median : 0.17136    
 Mean   :-0.01137                             Mean   :-0.5243      Mean   : 0.07865    
 3rd Qu.: 0.03200                             3rd Qu.:-0.5823      3rd Qu.: 0.24343    
 Max.   : 0.18238                             Max.   : 0.7378      Max.   : 0.42476    
 Angle.Z.GravityMean. TimeBodyAccelerometer.std...X TimeBodyAccelerometer.std...Y
 Min.   :-0.873649    Min.   :-0.9961               Min.   :-0.99024             
 1st Qu.:-0.083912    1st Qu.:-0.9799               1st Qu.:-0.94205             
 Median : 0.005079    Median :-0.7526               Median :-0.50897             
 Mean   :-0.040436    Mean   :-0.5577               Mean   :-0.46046             
 3rd Qu.: 0.106190    3rd Qu.:-0.1984               3rd Qu.:-0.03077             
 Max.   : 0.390444    Max.   : 0.6269               Max.   : 0.61694             
 TimeBodyAccelerometer.std...Z TimeGravityAccelerometer.std...X TimeGravityAccelerometer.std...Y
 Min.   :-0.9877               Min.   :-0.9968                  Min.   :-0.9942                 
 1st Qu.:-0.9498               1st Qu.:-0.9825                  1st Qu.:-0.9711                 
 Median :-0.6518               Median :-0.9695                  Median :-0.9590                 
 Mean   :-0.5756               Mean   :-0.9638                  Mean   :-0.9524                 
 3rd Qu.:-0.2306               3rd Qu.:-0.9509                  3rd Qu.:-0.9370                 
 Max.   : 0.6090               Max.   :-0.8296                  Max.   :-0.6436                 
 TimeGravityAccelerometer.std...Z TimeBodyAccelerometerJerk.std...X
 Min.   :-0.9910                  Min.   :-0.9946                  
 1st Qu.:-0.9605                  1st Qu.:-0.9832                  
 Median :-0.9450                  Median :-0.8104                  
 Mean   :-0.9364                  Mean   :-0.5949                  
 3rd Qu.:-0.9180                  3rd Qu.:-0.2233                  
 Max.   :-0.6102                  Max.   : 0.5443                  
 TimeBodyAccelerometerJerk.std...Y TimeBodyAccelerometerJerk.std...Z TimeBodyGyroscope.std...X
 Min.   :-0.9895                   Min.   :-0.99329                  Min.   :-0.9943          
 1st Qu.:-0.9724                   1st Qu.:-0.98266                  1st Qu.:-0.9735          
 Median :-0.7756                   Median :-0.88366                  Median :-0.7890          
 Mean   :-0.5654                   Mean   :-0.73596                  Mean   :-0.6916          
 3rd Qu.:-0.1483                   3rd Qu.:-0.51212                  3rd Qu.:-0.4414          
 Max.   : 0.3553                   Max.   : 0.03102                  Max.   : 0.2677          
 TimeBodyGyroscope.std...Y TimeBodyGyroscope.std...Z TimeBodyGyroscopeJerk.std...X
 Min.   :-0.9942           Min.   :-0.9855           Min.   :-0.9965              
 1st Qu.:-0.9629           1st Qu.:-0.9609           1st Qu.:-0.9800              
 Median :-0.8017           Median :-0.8010           Median :-0.8396              
 Mean   :-0.6533           Mean   :-0.6164           Mean   :-0.7036              
 3rd Qu.:-0.4196           3rd Qu.:-0.3106           3rd Qu.:-0.4629              
 Max.   : 0.4765           Max.   : 0.5649           Max.   : 0.1791              
 TimeBodyGyroscopeJerk.std...Y TimeBodyGyroscopeJerk.std...Z
 Min.   :-0.9971               Min.   :-0.9954              
 1st Qu.:-0.9832               1st Qu.:-0.9848              
 Median :-0.8942               Median :-0.8610              
 Mean   :-0.7636               Mean   :-0.7096              
 3rd Qu.:-0.5861               3rd Qu.:-0.4741              
 Max.   : 0.2959               Max.   : 0.1932              
 TimeBodyAccelerometerMagnitude.std.. TimeGravityAccelerometerMagnitude.std..
 Min.   :-0.9865                      Min.   :-0.9865                        
 1st Qu.:-0.9430                      1st Qu.:-0.9430                        
 Median :-0.6074                      Median :-0.6074                        
 Mean   :-0.5439                      Mean   :-0.5439                        
 3rd Qu.:-0.2090                      3rd Qu.:-0.2090                        
 Max.   : 0.4284                      Max.   : 0.4284                        
 TimeBodyAccelerometerJerkMagnitude.std.. TimeBodyGyroscopeMagnitude.std..
 Min.   :-0.9946                          Min.   :-0.9814                 
 1st Qu.:-0.9765                          1st Qu.:-0.9476                 
 Median :-0.8014                          Median :-0.7420                 
 Mean   :-0.5842                          Mean   :-0.6304                 
 3rd Qu.:-0.2173                          3rd Qu.:-0.3602                 
 Max.   : 0.4506                          Max.   : 0.3000                 
 TimeBodyGyroscopeJerkMagnitude.std.. FrequencyBodyAccelerometer.std...X
 Min.   :-0.9977                      Min.   :-0.9966                   
 1st Qu.:-0.9805                      1st Qu.:-0.9820                   
 Median :-0.8809                      Median :-0.7470                   
 Mean   :-0.7550                      Mean   :-0.5522                   
 3rd Qu.:-0.5767                      3rd Qu.:-0.1966                   
 Max.   : 0.2502                      Max.   : 0.6585                   
 FrequencyBodyAccelerometer.std...Y FrequencyBodyAccelerometer.std...Z
 Min.   :-0.99068                   Min.   :-0.9872                   
 1st Qu.:-0.94042                   1st Qu.:-0.9459                   
 Median :-0.51338                   Median :-0.6441                   
 Mean   :-0.48148                   Mean   :-0.5824                   
 3rd Qu.:-0.07913                   3rd Qu.:-0.2655                   
 Max.   : 0.56019                   Max.   : 0.6871                   
 FrequencyBodyAccelerometerJerk.std...X FrequencyBodyAccelerometerJerk.std...Y
 Min.   :-0.9951                        Min.   :-0.9905                       
 1st Qu.:-0.9847                        1st Qu.:-0.9737                       
 Median :-0.8254                        Median :-0.7852                       
 Mean   :-0.6121                        Mean   :-0.5707                       
 3rd Qu.:-0.2475                        3rd Qu.:-0.1685                       
 Max.   : 0.4768                        Max.   : 0.3498                       
 FrequencyBodyAccelerometerJerk.std...Z FrequencyBodyGyroscope.std...X
 Min.   :-0.993108                      Min.   :-0.9947               
 1st Qu.:-0.983747                      1st Qu.:-0.9750               
 Median :-0.895121                      Median :-0.8086               
 Mean   :-0.756489                      Mean   :-0.7110               
 3rd Qu.:-0.543787                      3rd Qu.:-0.4813               
 Max.   :-0.006236                      Max.   : 0.1966               
 FrequencyBodyGyroscope.std...Y FrequencyBodyGyroscope.std...Z
 Min.   :-0.9944                Min.   :-0.9867               
 1st Qu.:-0.9602                1st Qu.:-0.9643               
 Median :-0.7964                Median :-0.8224               
 Mean   :-0.6454                Mean   :-0.6577               
 3rd Qu.:-0.4154                3rd Qu.:-0.3916               
 Max.   : 0.6462                Max.   : 0.5225               
 FrequencyBodyAccelerometerMagnitude.std.. FrequencyBodyAccelerometerJerkMagnitude.std..
 Min.   :-0.9876                           Min.   :-0.9944                              
 1st Qu.:-0.9452                           1st Qu.:-0.9752                              
 Median :-0.6513                           Median :-0.8126                              
 Mean   :-0.6210                           Mean   :-0.5992                              
 3rd Qu.:-0.3654                           3rd Qu.:-0.2668                              
 Max.   : 0.1787                           Max.   : 0.3163                              
 FrequencyBodyGyroscopeMagnitude.std.. FrequencyBodyGyroscopeJerkMagnitude.std..
 Min.   :-0.9815                       Min.   :-0.9976                          
 1st Qu.:-0.9488                       1st Qu.:-0.9802                          
 Median :-0.7727                       Median :-0.8941                          
 Mean   :-0.6723                       Mean   :-0.7715                          
 3rd Qu.:-0.4277                       3rd Qu.:-0.6081                          
 Max.   : 0.2367                       Max.   : 0.2878                          
> 
objc[8831]: Class FIFinderSyncExtensionHost is implemented in both /System/Library/PrivateFrameworks/FinderKit.framework/Versions/A/FinderKit (0x7fffa121dcd0) and /System/Library/PrivateFrameworks/FileProvider.framework/OverrideBundles/FinderSyncCollaborationFileProviderOverride.bundle/Contents/MacOS/FinderSyncCollaborationFileProviderOverride (0x11002acd8). One of the two will be used. Which one is undefined.
> 