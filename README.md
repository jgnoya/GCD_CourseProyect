GCD_CourseProyect
=================

Repo with the final proyect for the course Getting and Cleaning Data

In the file CodeBook.md is explained what calculates the run_analysis function and how is calculated.
Now in this file we explain how to run the function run_analysis:

Before execute the run_analysis function in R studio is necesary to perform the following actions:
* 1.- Download de raw data from this location
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
* 2.- Unzip the file downloaded: getdata_projectfiles_UCI HAR Dataset.zip. Now in the directory were the file was unziped there are the following structure of directories:
.\getdata_projectfiles_UCI HAR Dataset\UCI HAR Dataset
* 3.- Open the R Studio and set the working path to the directory where the file getdata_projectfiles_UCI HAR Dataset.zip was unziped. For example in the file was unziped in the directory c:\TestR execute this sentence in R Studio:
setwd("C:\\TestR")
* 4.- Load the function in R Studio with: source("run_analysis.R")
* 5.- Execute run_analysis()
* 6.- When the execution finishes you have in your workin directory a file called tidy_data_set.txt with the result of the analysis
