**Readme**  
for the peer graded assignment for coursera's course Getting and cleaning data

In the GIT repository the following files are stored:  

+ this README.md file, which explains the scripts and files and how they work together  
+ an R-script called run_analyis.R which performs the steps to download the file, unzip it and process the original dataset, resulting in the creation of the tidy dataset file  
+ the file Tidy UCI HAR Dataset.txt which contains the processed data in a tidy format  
+ the codebook markdown file which describes the data source, and the steps that are performed in order to get to the new dataset.

**Further information on the run_analysis.R script**  
For running the script it needs to be opened, and executed with the run function. This can be done statement by statement, or the entire text of the script can be selected before the run button is clicked. After running the script the tidy file is written in the directory UCI HAR Dataset. It is a comma separated file which uses the character ";" as a separator and carries the name "Tidy UCI HAR Dataset.txt".

**Explanation of the working of the script**  
The script start with calling the dplyr library which is used, and storing the current directory. This is done so that the working directory can be set back after the script has run. This eg prevents a second set of files being installed when the script is run multiple times

After that, the script checks if the zip-file with all the data and description files in it is already available in the working directory. If not, it downloads and unpacks the zipfile into the directory "UCI HAR Dataset", both in the active working director of the user. The working directory is set to UCI HAR Dataset to achieve more efficient code.

When the files are present, the script starts loading the data from the relevant files into variables. Since the data files have no column names in a header row, the names of the dataframe are set too.

The first files are the references for the activities and the measured features. There are 6 activity descriptions and 561 feature labels that will be used later in the script. 
Since the data files were originally set up for machine learning, the data has been split in a training set and a test set which are placed in different directories within the UCI HAR Dataset directory, with the corresponding name. The rows of the training and test set need to be combined in order to get a complete test set. Therefore the individual 6 datasets (activity, subject and measurements, both for training and test) are first read individually into a variable so that the rows can be joined (by using rbind) in the same order, eg. training first and then test into three variables that contain the complete number of rows.

The variable names have been chosen in a way that it can be derived which part of the dataset they contain: 'act' for activity, 'subj' for subject and 'meas' for measurement of the features. The second part of the variable name contains 'tr' for train, 'tst' for test and 'tot' for total. For measurements however, a subset is used of the total measurements, which is indicated by 'mnst' which stand for mean and standard deviation. The selection of the columns is done by using the grep function to select only the columns where the names contain 'mean()' and 'std()' 

Then the data columns of the three 'total'-variables are joined using the cbind function. It was chosen to build the dataset up from variables and not from 'pipes' in order to keep the code in the script readable. 

The activity codes are then joined with the corresponding activity label from the dataframe act_label by using the merge function. Since the merge function also sorts the data, and the row order is important, the join is only done after the dataset is complete. 

Then the column names are changed using the gsub function which replaces certain character combinations with more exploratory names. The rules which are used in the changing of the column names are described in the code book.

With the aggregate function the dataset is grouped by activity and subject and for every group an average of the measured data is calculated and placed into a new dataframe, dataset2. The activity labels were place in the last column of the dataframe, but since activity and subject are used to group the data, they become the first two columns of the new dataset For this calculation, the columns 3 (first column after the group variables) until 68 (the last column with measurements) are used for the average function.

Finally the data of dataset2 is written in the csv file, and the working directory is set back.
