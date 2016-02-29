library(plyr)

data_path = "UCI HAR Dataset"
test_path = paste(data_path,"test",sep="/")
train_path = paste(data_path,"train",sep="/")

# Pick which columns to extract
grep_string <- "(std\\(|mean\\()"
features <- read.table(paste(data_path,"features.txt",sep="/"))
col_names <- features[grep(grep_string, features$V2),2]
col_tf <- seq(along=(features[,2])) %in% grep(grep_string, features[,2])

#READ IN ACTIVITY LABELS
activity_labels <- read.table(paste(data_path,"activity_labels.txt",sep="/"))
# READ IN TEST DATA
subject_test <- read.table(paste(test_path,"subject_test.txt",sep="/"))
Y_test <- read.table(paste(test_path,"Y_test.txt",sep="/"))
# Read in, then create a vector of 561-feature vectors with time and frequency domain variables.
X_test <- read.table(paste(test_path,"X_test.txt",sep="/"))
# Set Test Column Names
colnames(subject_test)[1] <- "SubjectNumber"
colnames(Y_test)[1] <- "Activity"
# Combine test data
test_data <- cbind(subject_test, Y_test)
temp <- X_test[,col_tf]
colnames(temp) <- col_names
test_data <- cbind(test_data, temp)

# READ IN TRAIN DATA
subject_train <- read.table(paste(train_path,"subject_train.txt",sep="/"))
Y_train <- read.table(paste(train_path,"Y_train.txt",sep="/"))
# Read in, then create a vector of 561-feature vectors with time and frequency domain variables.
X_train <- read.table(paste(train_path,"X_train.txt",sep="/"))
# Set Train Column Names
colnames(subject_train)[1] <- "SubjectNumber"
colnames(Y_train)[1] <- "Activity"
# Combine train data
train_data <- cbind(subject_train, Y_train)
temp <- X_train[,col_tf]
colnames(temp) <- col_names
train_data <- cbind(train_data, temp)

# Combine data 
final_data <- rbind(test_data, train_data)

# Create second tidy data set with the mean of each variable for each activity and each subject
# Create subject mean data
len <- dim(final_data)[2]
subject_mean_data <- data.frame("SubjectNumber"=1:30)
for (i in 2:len) {
    name <- colnames(final_data)[i]
    subject_mean_data[,name] <- 0
    for (i in 1:30)
        subject_mean_data[i,name] <- mean(final_data[final_data$SubjectNumber==i,name])
}
# Create Activity mean data
activity_mean_data <- data.frame("Activity"=1:6)
for (i in 2:len) {
    name <- colnames(final_data)[i]
    activity_mean_data[,name] <- 0
    for (i in 1:6)
        activity_mean_data[i,name] <- mean(final_data[final_data$Activity==i,name])
}

# set activity labels
for (i in 1:6)
    activity_mean_data$Activity[activity_mean_data$Activity==i] = as.character(activity_labels[i,2])

# Combine subject and activity data
second_data_set <- rbind.fill(activity_mean_data, subject_mean_data)
write.table(second_data_set, file="tidy_data_set_2.txt", row.name=FALSE)