run_analysis <- function(){
  # First load this libraries needed for some functions
  library(plyr)
  library(dplyr)
  #setwd("C:\\Users\\JGN\\Documents\\The Data Science Specialization\\03.- Getting and Cleaning Data\\Project");

  # Here we read all the data needed:
  # - X_train.txt
  # - Y_train.txt
  # - subject_train.txt
  # - X_test.txt
  # - Y_test.txt
  # - subject_text.txt
  # - activity_labels.txt
  # - features.txt
  message("Reading x_train");
  x_train = read.table("getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt");
  message("Reading subject_train");
  subject_train = read.table("getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\subject_train.txt");
  message("Reading y_train");
  y_train = read.table("getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\Y_train.txt");
  message("Reading x_test");
  x_test = read.table("getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt");
  message("Reading subject_test");
  subject_test = read.table("getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt");
  message("Reading y_test");
  y_test = read.table("getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\Y_test.txt");
  
  message("Reading activity");
  activity = read.table("getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\activity_labels.txt");
  
  message("Reading features");
  features = read.table("getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\features.txt");
  
  # Here we replace the special characters () and , This characters may cause problems as column names in tables
  features_2 = gsub("\\(\\)", "", features$V2)
  features_3 = gsub("\\(", "-", features_2)
  features_4 = gsub("\\)", "-", features_3)
  features_5 = gsub(",", "-", features_4)
  
  # Here change the colum names in the tables subject_train, y_train, y_test, subject_text and activity
  # The purpose of changing this names is to differentiate the column names when this data is joined with
  # X_train and Y_train
  message("Adding subject and activity");
  names(subject_train)[names(subject_train) == "V1"] = "Subject_ID";
  names(y_train)[names(y_train) == "V1"] = "Activity_ID";
  names(subject_test)[names(subject_test) == "V1"] = "Subject_ID";
  names(y_test)[names(y_test) == "V1"] = "Activity_ID";
  names(activity)[names(activity) == "V1"] = "Activity_ID";
  names(activity)[names(activity) == "V2"] = "Activity";

  # Here we join the data subject_train with x_train in order to know the subject_id that belongs to each
  # measurements
  x_train_sub = cbind(as.data.frame(subject_train), as.data.frame(x_train))
  # Here we join the data y_train with x_train in order to know the activity that belongs to each
  # measurements
  x_train_act = cbind(as.data.frame(y_train), as.data.frame(x_train_sub))
  # Here we merge the activity table with x_train data to know the activity name tha correspond with the activity_id
  x_train_act_names <- merge(activity, x_train_act, by.x="Activity_ID", by.y="Activity_ID", x.all=TRUE);
  # Here we change the column names V1,...,Vn with the corresponding names according with the features table
  numFeatures = length(features_5);
  for(i in 1:numFeatures){
    names(x_train_act_names)[names(x_train_act_names) == gsub(" ", "", paste("V", as.character(i)))] = features_5[i];
  }
     
  # Here we join the data subject_test with x_test in order to know the subject_id that belongs to each
  # measurements
  x_test_sub = cbind(as.data.frame(subject_test), as.data.frame(x_test))
  # Here we join the data y_test with x_test in order to know the activity that belongs to each
  # measurements
  x_test_act = cbind(as.data.frame(y_test), as.data.frame(x_test_sub))
  # Here we merge the activity table with x_test data to know the activity name tha correspond with the activity_id
  x_test_act_names <- merge(activity, x_test_act, by.x="Activity_ID", by.y="Activity_ID", x.all=TRUE);
  # Here we change the column names V1,...,Vn with the corresponding names according with the features table
  numFeatures = length(features_5);
  for(i in 1:numFeatures){
    names(x_test_act_names)[names(x_test_act_names) == gsub(" ", "", paste("V", as.character(i)))] = features_5[i];
  }
  
  # Here we join the train data with the test data
  message("Joining train data and test data");
  x_all_act_names = rbind(x_train_act_names, x_test_act_names);
  
  # Here we filter the data set to take only the mean measurements
  message("Filtering mean columns");
  nc <- colnames(x_all_act_names);
  numCol <- length(nc);
  cols <- c(3,2);
  j <- 3;
  for(i in 1:numCol){
    if(grepl("mean", nc[i]) || grepl("std", nc[i])){
      cols[j] = i;
      j = j + 1;
    }
  }
  
  final_data <- x_all_act_names[, cols];

  # Here we calculate the tidy data set. 
  # First we group the data to calculate the mean according this agrupation
  message("Calculating tidy data set");
  final_data2 <- group_by(final_data, Subject_ID, Activity)
  # Here we use the function summarise_each from dplyr to calculate the mean of each column according with
  # the agrupation
  final_data3 <- summarise_each(final_data2, funs(mean))
  # Here we order the data in ascending order by subject_id and activity
  final_data4 <- arrange(final_data3, Subject_ID, Activity)
  
  # Finally we write the data in a file
  write.table(final_data4,file="tidy_data_set.txt", row.name=FALSE);
}
