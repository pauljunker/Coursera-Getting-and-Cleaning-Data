run_analysis <- function() {

	#To run, load this function into your working directory
	#Enter: source("run_analysis.R")
	#Enter: run_analysis()

	print("process has started, please wait . . .")	

	#PUT FILE NAMES INTO VARIABLES FOR CONVENIENCE
	f_x_test <- ("./UCI HAR Dataset/test/X_test.txt")
	f_y_test <- ("./UCI HAR Dataset/test/y_test.txt")
	f_subject_test <- ("./UCI HAR Dataset/test/subject_test.txt")
	f_x_train <- ("./UCI HAR Dataset/train/X_train.txt")
	f_y_train <- ("./UCI HAR Dataset/train/y_train.txt")
	f_subject_train <- ("./UCI HAR Dataset/train/subject_train.txt")
	f_activity_labels <- ("./UCI HAR Dataset/activity_labels.txt")
	f_variable_names <- ("./UCI HAR Dataset/features.txt")

	#LOAD FILES INTO DATA FRAMES
	df_x_test <- read.table(f_x_test)
	df_y_test <- read.table(file = f_y_test, col.names = c("activitycode"))
	df_subject_test <- read.table(file = f_subject_test, col.names = c("subjectcode"))
	df_x_train <- read.table(f_x_train)
	df_y_train <- read.table(file = f_y_train, col.names = c("activitycode"))
	df_subject_train <- read.table(file = f_subject_train, col.names = c("subjectcode"))
	activity_labels <- read.table(f_activity_labels, col.names = c("activitycode","activitydesc"))
	variable_names <- read.table(f_variable_names, col.names = c("columnnumber","columndesc"))

	print("Data has been loaded. Processing continuing . . . ")
	
	#REMOVE UNWANTED CHARACTERS FROM VARIABLE NAMES
	variable_names$columndesc <- gsub("-|_|\\,|\\(|\\)","",variable_names$columndesc) #REMOVES UNWANTED CHARACTERS
	variable_names$columndesc <- tolower(variable_names$columndesc)			  #MAKES ALL LOWER CASE

	#RENAME COLUMN NAMES WITH NAMES FROM "FEATURES" FILE
	colnames(df_x_test) <- variable_names$columndesc
	colnames(df_x_train) <- variable_names$columndesc
	#******STEP 4 COMPLETED ********  #THIS WAS DONE NOW B/C THE COLUMN NAMES MAKE STEP 2 EASIER        


	#MERGE DATASETS TO CREATE ONE DATASET   
	df_x_test <- cbind(df_x_test, df_y_test) 		#STEP ONE - COMBINING TEST DATA
	df_x_test <- cbind(df_x_test, df_subject_test)		#STEP TWO - COMBINING TEST DATA
	df_x_train <- cbind(df_x_train, df_y_train)		#STEP ONE - COMBINING TRAIN DATA
	df_x_train <- cbind(df_x_train, df_subject_train)	#STEP TWO - COMBINING TRAIN DATA
	data_orig <- rbind(df_x_test, df_x_train)			#COMBINE DATA INTO ONE DATA FRAME
	#******STEP 1 COMPLETED ********

	print("Step 1 completed. Processing continuing . . . ")

	#EXTRACT JUST COLUMNS with MEAN and STD. ALSO INCLUDES ACTIVITY CODE AS IT IS NEEDED IN STEP 3
	column_numbers_mean_std <- grep("[Mm]ean|[Ss][Tt][Dd]|^activitycode|^subjectcode", names(data_orig))
	data_mean_std <- data_orig[column_numbers_mean_std]
	#******STEP 2 COMPLETED ********	

	print("Step 2 completed. Processing continuing . . .")

	#MERGE MEAN/STD DATA WITH ACTIVITY LABELS
	data_merged <- merge(data_mean_std,activity_labels,by.x="activitycode",by.y="activitycode",all=TRUE)
	#******STEP 3 COMPLETED ********	

	print("Steps 3 and 4 completed. Processing continuing . . .")

	#******STEP 4 COMPLETED AT BIGINNING********	

	#CREATE AGGREGATED DATA FRAME AND OUTPUT
	data_output <- aggregate(data_merged[2:87], list(subject = data_merged$subjectcode,
		activity = data_merged$activitydesc),mean)					#CREATE FINAL DATA FRAME
	write.table(data_output, file="junker_project.txt", row.name=FALSE)		#OUTPUT TEXT FILE
	#******STEP 5 COMPLETED ********			
	
	print("Processing Complete! File junker_project.txt exported to your working directory.")
	print("To import, enter: x <- read.table('junker_project.txt')")

}

