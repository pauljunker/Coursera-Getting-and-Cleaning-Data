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

  * variable_names$columndesc <- gsub("-|_|\\,|\\(|\\)","",variable_names$columndesc) #REMOVES UNWANTED CHARACTERS
  * variable_names$columndesc <- tolower(variable_names$columndesc)			  #MAKES ALL LOWER CASE


