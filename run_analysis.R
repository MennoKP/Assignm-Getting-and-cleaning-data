# Initiate
library(dplyr)
currentWD <- getwd()
# Load and unzip the data file
filename <- "DS_GaC_data_assign.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) 
}

setwd("UCI HAR Dataset")

# Read measured features and activity labels
features <- read.table("./features.txt")
names(features) <- c("feature_id","feature_label")
act_labels <- read.table("./activity_labels.txt", sep = " ")
names(act_labels) <- c("activity_id","activity_name")

# Read training and test datasets

meas_tr <- read.table("./train/X_train.txt")
act_tr <- read.table("./train/y_train.txt")
subj_tr <- read.table("./train/subject_train.txt")


meas_tst <- read.table("./test/X_test.txt")
act_tst <- read.table("./test/y_test.txt")
subj_tst <- read.table("./test/subject_test.txt")

# Combine train and test data, set column names

meas_tot <- rbind(meas_tr, meas_tst)
names(meas_tot) <- features$feature_label

act_tot <- rbind(act_tr, act_tst)
names(act_tot) <- "activity_id"

subj_tot <- rbind(subj_tr,subj_tst)
names(subj_tot) <- "subject_id"

# Subset measurement columns to measurements with only mean and standard deviation
# meanfreq was excluded because it applies to only part of the measurements
meas_mnstd <- select(meas_tot,grep("mean\\(\\)|std()",names(meas_tot)))

# Combine the measurements, activity and subject data columns into one dataset 
# and replace activity code with activity text. 

#This must be done after the cbind because the merge function sorts the rows and 
# therefore changes the pre-established order of activity, subject and measurement
dataset <- cbind(act_tot, subj_tot, meas_mnstd) %>% 
           merge(act_labels, by = "activity_id")

# Make labels more descriptive
n <- names(dataset)

n <- gsub("^t","timeDomain",n)
n <- gsub("^f","frequencyDomain",n)
n <- gsub("Acc","_accelaration",n)
n <- gsub("Gyro","_gyroscope",n)
n <- gsub("-std\\(\\)","_standardDeviation",n)
n <- gsub("-mean\\(\\)","_mean",n)
n <- gsub("Body","_body",n)
n <- gsub("Gravity", "_gravity",n)
n <- gsub("Jerk", "_jerk",n)
n <- gsub("-X","_X_axis",n)
n <- gsub("-Y","_Y_axis",n)
n <- gsub("-Z","_Z_axis",n)
n <- gsub("Mag","_magnitude",n)

names(dataset) <- n

# Aggregate the data per activity per subject calculating the avg per measurement
# measurement columns are 3 through 68
dataset2 <- aggregate.data.frame(x = dataset[,3:68],
                                 by = list(dataset$activity_name,dataset$subject_id),
                                 FUN = mean)

# Aggregate renames the grouping variables, so the names must be restored
n <- names(dataset2)
n[1] <- "activity"
n[2] <- "subject_id"
names(dataset2) <- n

# Write file
write.table(dataset2, file = "./Tidy UCI HAR Dataset.txt",
            sep = ";", row.names = F)

# Return to the directory that was active at beginning of script
setwd(currentWD)
