# Human Activity Recognition Using Smartphones Dataset
# 2016.01.31 - Lech Szczepaniak
# -----------------------------
library(sqldf)
#setwd('~/Lech/R/Script/Coursera/Getting_and_Cleaning_Data/data/UCI HAR Dataset/')

# Function add_train_to_test 
add_train_to_test <- function(train_file, test_file){
  train <- read.table(paste('train/', train_file, sep=''))
  test <- read.table(paste('test/', test_file, sep=''))
  rbind(train, test)
}

# 1. Merges the training and the test sets to create one data set
subjects <- add_train_to_test('subject_train.txt', 'subject_test.txt')
labels_id <- add_train_to_test('y_train.txt', 'y_test.txt')
features <- add_train_to_test('X_train.txt', 'X_test.txt')

# 2. Extracts only the measurements on the mean and standard deviation for each measurement
df_feature_names <- read.table('features.txt', col.names = c('id', 'feature'))
names(features) <- df_feature_names[, 'feature']
extracted_columns <- grep('std|mean', names(features))
features <- features[extracted_columns]

# 3. Uses descriptive activity names to name the activities in the data set
label_names <- read.table('activity_labels.txt', col.names = c('id', 'activity'))
names(labels_id) <- 'id'
labels = sqldf('SELECT activity FROM labels_id d1, label_names d2 WHERE d1.id = d2.id')

# 4. Appropriately labels the data set with descriptive variable names
names(subjects) = 'subject'
names(features) <- gsub("BodyBody", "Body", x = names(features))
names(features) <- gsub("^t", "time", x = names(features))
names(features) <- gsub("^f", "freq", x = names(features))
names(features) <- gsub("\\()", "", x = names(features))

merged_data <- cbind(subjects, labels, features)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_data <- aggregate(. ~ subject + activity, data = merged_data, FUN = 'mean')
write.table(tidy_data, file = 'tidy_data.txt', row.name = FALSE)
