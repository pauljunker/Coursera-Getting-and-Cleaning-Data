#Paul Junker’s Course Project for coursera course: Getting and Cleaning Data, 8/4/14 – 8/31/14

Attached is the script: run_analysis.R

To run, it should be put in your working directory. Also in your working directory should be the folder: UCI HAR Dataset.

For example:
* C:\R\MyWorkingDirectory\run_analysis.R
* C:\R\MyWorkingDirectory\ UCI HAR Dataset\<subfolders>

The run_analysis.R program has a fairly large amount of inline documentation in it to help graders understand the steps. Here at a high level are the steps.

1. The raw data is loaded into the following data frames: 
  * df_x_test
  * df_y_test
  * df_subject_test
  * df_x_train
  * df_y_train
  * df_subject_train
  * activity_labels
  * variable_names
2. The unwanted characters are removed from the variable descriptions in "variable_names" via the command:
  * variable_names$columndesc <- gsub("-|_|\\,|\\(|\\)","",variable_names$columndesc)
3. Next the the variable descriptions are made all lowercase:
  * variable_names$columndesc <- tolower(variable_names$columndesc)
4. The column names in df_x_test and df_x_train are updated with the names form variable_names:
  * colnames(df_x_test) <- variable_names$columndesc
  * colnames(df_x_train) <- variable_names$columndesc
  * THIS COMPLETES STEP 4 (I found it easier to do at this point)
5. The dataframes are all combined into one dataframe named data_orig:
  * df_x_test <- cbind(df_x_test, df_y_test)
  * df_x_test <- cbind(df_x_test, df_subject_test)
  * df_x_train <- cbind(df_x_train, df_y_train)
  * df_x_train <- cbind(df_x_train, df_subject_train)
  * data_orig <- rbind(df_x_test, df_x_train)
  * THIS COMPLETES STEP 1
6. The columns with just mean and std are extracted and put into the data frame data_mean_std:
  * column_numbers_mean_std <- grep("[Mm]ean|[Ss][Tt][Dd]|^activitycode|^subjectcode", names(data_orig))
  * data_mean_std <- data_orig[column_numbers_mean_std]
  * THIS COMPLETES STEP 2
7. The activity labels are added to the data and everything is put into the dataframe data_merged
  * data_merged <- merge(data_mean_std,activity_labels,by.x="activitycode",by.y="activitycode",all=TRUE)
  * THIS COMPLETES STEP 3
  * STEP 4 WAS ALREADY COMPLETED
8. The data averaged and aggregated by subject and activity and put into data_output:
  * data_output <- aggregate(data_merged[2:87], list(subject = data_merged$subjectcode, activity = data_merged$activitydesc),mean)
  * THIS COMPLETES STEP 5
9. Finally, the data is output to a text file:
  * write.table(data_output, file="junker_project.txt", row.name=FALSE)

Thank you for reviewing my work. I look forward to any suggestions you might have!




