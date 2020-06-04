About Data Source:

Obtained directly from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, unzipped
and downloaded directly into working directory.

About Analysis:

Followed the steps taken to create an independent data set:
1. Read in the train and test data, as well as features data as var_names.
 - X_test,X_train,y_test,y_train,sub_test,sub_train,var_names(features.txt),act_names(activity_labels.txt)
 
2. Merged the train and test data, after assigning the column names with the relevant var_names.
- alltrain: all the trained data, alltest: all the test data, alldata: combination of both

3. Extracted the mean and std dataset.
- alltest_mean_std: extracting mean and std into one dataset

4. Merged the data to include the activity type.
- final_data: alltest_mean_std including the activity type

5. Created a tidy data set to export as a text file.
- tidyset: final dataset to be exported
