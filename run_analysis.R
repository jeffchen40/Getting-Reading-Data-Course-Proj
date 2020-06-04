#Read test data
X_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
y_test <- read.table('./UCI HAR Dataset/test/y_test.txt')
sub_test <- read.table('./UCI HAR Dataset/test/subject_test.txt')

#Read train data
X_train <- read.table('./UCI HAR Dataset/train/X_train.txt')
y_train <- read.table('./UCI HAR Dataset/train/y_train.txt')
sub_train <- read.table('./UCI HAR Dataset/train/subject_train.txt')

#Read data description
var_names <- read.table('./UCI HAR Dataset/features.txt')
#Read activity labels
act_names <- read.table('./UCI HAR Dataset/activity_labels.txt')

#Merges data to one dataframe

colnames(X_train) <- var_names[,2]
colnames(y_train) <- 'activity_id'
colnames(sub_train) <- 'subject_id'

colnames(X_test) <- var_names[,2]
colnames(y_test) <- 'activity_id'
colnames(sub_test) <- 'subject_id'
colnames(act_names) <- c('activity_id','activity_type')

alltrain <- cbind(y_train,sub_train,X_train)
alltest <- cbind(y_test,sub_test,X_test)
alldata <- rbind(alltrain,alltest)

#Extracts mean and sd
library(dplyr)
colNames <- colnames(alldata)
alltest_mean_std <- (grepl('activity_id',colNames) | grepl('subject_id',colNames) | grepl('mean..',
                     colNames) | grepl('std...',colNames))
alltest_mean_std <- alldata[, alltest_mean_std  == TRUE]
 
#Using descriptive activity names to name activities
final_data <- merge(act_names,alltest_mean_std, 'activity_id')

#Creating independent tidy set
tidyset <- aggregate(final_data[,names(final_data) != c('activity_id','subject_id')], 
                     by = list(activity_id = final_data$activity_id, subject_id = final_data$subject_id),
                     mean)
tidyset <- tidyset[,names(tidyset) != 'activity_type']
tidyset <- tidyset[,names(tidyset) != 'subject_id.1']

tidyset <- tidyset[order(tidyset$subject_id, tidyset$activity_id), ]

#Export tidy data set
write.table(tidyset, './FinalTidyDataset.txt', row.names = FALSE, sep = '\t')
