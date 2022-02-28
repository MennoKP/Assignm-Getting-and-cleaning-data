Code book for the tidy file of UCI HAR dataset

The file that is described in this code book is based on the Human Activity Recognition Using Smartphones Dataset (HAR) from the University of California, Irvine (UCI). In short, as introduction, 30 volunteers have performed activities while wearing a smartphone. The information that was recorded by the smartphone's sensors during those activities have been normalised and stored in a 561 vector in a training and a test dataset. A description of the dataset, and the data can be found on the following web address: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones The data that was used as the basis for the tidy file can be found on the following location:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

The tidy file of the UCI HAR dataset is produced with a script called run_analysis.R. This script automatically downloads the dataset and the files that describe the data into the folder "UCI HAR Dataset". In this folder, the "README.txt" file contains a description of the research project that obtained the data, and all the description and data files that are available. Information about the measurement data in this file can be found in the files README.txt and features_info.txt. It is important to know that the dataset was originally set up for machine learning purposes, so the observtions are split up in a training set and a test set. The data in those sets however is comparable and can be joined to form one dataset.

In this code book, this information is the reference for the description of the data, to make sure that no essential information is lost while summarising it and to avoid unnecessary copying in order to keep this code book more readable and the scope limited to the processing that was done on the original files. The remainder of this codebook assumes that the reader has read the description of the original dataset. 

The files that are in the folder "Inertial Signals" of both the train and the test folder were not used in the creation of the tidy file 

In order to get to the new tidy dataset file, the data set of UCI HAR has been processed by an R script calles run_analysis.R. In this script the original dataset has been transformed in the following ways:

1. The  dataset has been made tidy, by joining the rows of the training and data sets of the three data collections: 
- the measurements that were done in an observation (derived from the files X_train.txt, X_test.txt)
- the activity code that was performed in the observation (derived from the files (y_train.txt and y_test.txt)
- the id of the subject that was involved in the observation (derived from the files (subject_train.txt and subject_test.txt)

2. From the 561 measurement features, a selection was made of only those measurements that contained either the mean or the standard deviation of a measured value.These values can be recognised by the name of the measurement, which contains "mean()" or "std()".The measurements which contained other references to mean, eg "meanFreq()" were intentionally left out. This variable for instance contains the weighted average of the frequency components to obtain a mean frequency. This does not cover only a subset of the measured signals. As a result of creating this selection, the number of feature measurements was brought back from 561 to a number of 66.

After that, the columns of the three resulting datasets were combined in one dataframe, with 10299 rows and 68 columns (66 measurements, activity_id and subject_id). It is important to know that the order in the measurement, subject and actvity file corresponds with each other. In other words: the subject-id, activity and measurement of a particular row number in the three files are part of the same observation

This way each column is a variable, each row is an observation and each type of observational unit forms a table, and the result is tidy data file

3. A column was added that contains the activity names that correspond to the activity codes from the files "y-train.txt" and "y-test.txt". The reference to populate this activity name column is the information from the file "activity_labels.txt". 

4. The labels of the data columns were updated in order to make the variable labels more descriptive. This contained the following updates:
- The "Y" value code mapped to activity label was named "activity"
- The subject_id obtained from the files "subject_train.txt" and "subject_test" was named "subject_id"
- For the selected measurements, the column names obtained from the "features.txt" file were changed, according to the following rules:
    - Name starts with "t", replaced with "timeDomain"
    - Name starts with "f", replaced with "frequencyDomain"
    - Name contains "Acc",is replaced with "_accelaration"
    - Name contains "Gyro",is replaced with "_gyroscope"
    - Name contains "-std()",is replaced with "_standardDeviation"
    - Name contains "-mean()",is replaced with "_mean"
    - Name contains "Body",is replaced with "_body"
    - Name contains "Gravity",is replaced with "_gravity"
    - Name contains "Jerk",is replaced with "_jerk"
    - Name contains "-X",is replaced with "_X_axis"
    - Name contains "-Y",is replaced with "_Y_axis"
    - Name contains "-Z",is replaced with "_Z_axis"
    - Name contains "Mag",is replaced with "_magnitude"

5. The original dataset contains one or more measurement rows per combination of subject and activity. In the processed file the average of these measurements (the mean and standard deviation values) are calculated over the rows and presented per activity/subject combination. This results in a dataset of 180 rows and 68 variables. The file is stored as a comma separated value file (separator = ";") and called "Tidy UCI HAR Dataset.txt". The file contains header rows so it must be read with the option header = TRUE.

Overview of the data columns in the tidy dataset:  
(values contain the average of the underlying measurements in the observations done per combination of activity and subject_id)  
 [1] activity                                                               
 [2] subject_id                                                             
 [3] timeDomain_body_accelaration_mean_X_axis                               
 [4] timeDomain_body_accelaration_mean_Y_axis                               
 [5] timeDomain_body_accelaration_mean_Z_axis                               
 [6] timeDomain_body_accelaration_standardDeviation_X_axis                  
 [7] timeDomain_body_accelaration_standardDeviation_Y_axis                  
 [8] timeDomain_body_accelaration_standardDeviation_Z_axis                  
 [9] timeDomain_gravity_accelaration_mean_X_axis                            
[10] timeDomain_gravity_accelaration_mean_Y_axis                            
[11] timeDomain_gravity_accelaration_mean_Z_axis                            
[12] timeDomain_gravity_accelaration_standardDeviation_X_axis               
[13] timeDomain_gravity_accelaration_standardDeviation_Y_axis               
[14] timeDomain_gravity_accelaration_standardDeviation_Z_axis               
[15] timeDomain_body_accelaration_jerk_mean_X_axis                          
[16] timeDomain_body_accelaration_jerk_mean_Y_axis                          
[17] timeDomain_body_accelaration_jerk_mean_Z_axis                          
[18] timeDomain_body_accelaration_jerk_standardDeviation_X_axis             
[19] timeDomain_body_accelaration_jerk_standardDeviation_Y_axis             
[20] timeDomain_body_accelaration_jerk_standardDeviation_Z_axis             
[21] timeDomain_body_gyroscope_mean_X_axis                                  
[22] timeDomain_body_gyroscope_mean_Y_axis                                  
[23] timeDomain_body_gyroscope_mean_Z_axis                                  
[24] timeDomain_body_gyroscope_standardDeviation_X_axis                     
[25] timeDomain_body_gyroscope_standardDeviation_Y_axis                     
[26] timeDomain_body_gyroscope_standardDeviation_Z_axis                     
[27] timeDomain_body_gyroscope_jerk_mean_X_axis                             
[28] timeDomain_body_gyroscope_jerk_mean_Y_axis                             
[29] timeDomain_body_gyroscope_jerk_mean_Z_axis                             
[30] timeDomain_body_gyroscope_jerk_standardDeviation_X_axis                
[31] timeDomain_body_gyroscope_jerk_standardDeviation_Y_axis                
[32] timeDomain_body_gyroscope_jerk_standardDeviation_Z_axis                
[33] timeDomain_body_accelaration_magnitude_mean                            
[34] timeDomain_body_accelaration_magnitude_standardDeviation               
[35] timeDomain_gravity_accelaration_magnitude_mean                         
[36] timeDomain_gravity_accelaration_magnitude_standardDeviation            
[37] timeDomain_body_accelaration_jerk_magnitude_mean  
[38] timeDomain_body_accelaration_jerk_magnitude_standardDeviation          
[39] timeDomain_body_gyroscope_magnitude_mean                               
[40] timeDomain_body_gyroscope_magnitude_standardDeviation                  
[41] timeDomain_body_gyroscope_jerk_magnitude_mean                          
[42] timeDomain_body_gyroscope_jerk_magnitude_standardDeviation             
[43] frequencyDomain_body_accelaration_mean_X_axis                          
[44] frequencyDomain_body_accelaration_mean_Y_axis                          
[45] frequencyDomain_body_accelaration_mean_Z_axis                          
[46] frequencyDomain_body_accelaration_standardDeviation_X_axis             
[47] frequencyDomain_body_accelaration_standardDeviation_Y_axis             
[48] frequencyDomain_body_accelaration_standardDeviation_Z_axis             
[49] frequencyDomain_body_accelaration_jerk_mean_X_axis                     
[50] frequencyDomain_body_accelaration_jerk_mean_Y_axis                     
[51] frequencyDomain_body_accelaration_jerk_mean_Z_axis                     
[52] frequencyDomain_body_accelaration_jerk_standardDeviation_X_axis        
[53] frequencyDomain_body_accelaration_jerk_standardDeviation_Y_axis        
[54] frequencyDomain_body_accelaration_jerk_standardDeviation_Z_axis        
[55] frequencyDomain_body_gyroscope_mean_X_axis                             
[56] frequencyDomain_body_gyroscope_mean_Y_axis                             
[57] frequencyDomain_body_gyroscope_mean_Z_axis                             
[58] frequencyDomain_body_gyroscope_standardDeviation_X_axis                
[59] frequencyDomain_body_gyroscope_standardDeviation_Y_axis                
[60] frequencyDomain_body_gyroscope_standardDeviation_Z_axis                
[61] frequencyDomain_body_accelaration_magnitude_mean                       
[62] frequencyDomain_body_accelaration_magnitude_standardDeviation          
[63] frequencyDomain_body_body_accelaration_jerk_magnitude_mean             
[64] frequencyDomain_body_body_accelaration_jerk_magnitude_standardDeviation  
[65] frequencyDomain_body_body_gyroscope_magnitude_mean                     
[66] frequencyDomain_body_body_gyroscope_magnitude_standardDeviation        
[67] frequencyDomain_body_body_gyroscope_jerk_magnitude_mean                
[68] frequencyDomain_body_body_gyroscope_jerk_magnitude_standardDeviation 

