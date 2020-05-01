#### the following script is my response (KASMI Anass) to the assignment of the fourth week in the course
#### of getting and cleaning data from coursera. it is a data analysis. you can find more
#### details in the readme file or in the codebook description.

# loading the dplyr library to use the functions needed
library(dplyr) 

# reading the data contained in the file downloaded from coursera for the assignment and 
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
sub_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
sub_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Merging the training and the test sets to create one data set (answer of question 1).
X <- rbind(X_train, X_test)
Y <- rbind(Y_train, Y_test)
sub_all <- rbind(sub_train, sub_test)

# Extracting the measurements on the mean and standard deviation for each measurement (answer of question 2)
selected_features <- features[grep("mean|std",features[,2]),]
X <- X[,selected_features[,1]]

# Using descriptive activity names to name the activities in the data set
colnames(Y) <- "label"
Y$activity <- factor(Y$label, labels = as.character(activity_labels[,2]))
activity <- Y$activity

# Appropriately label the data set with descriptive variable names
colnames(X) <- features[selected_features[,1],2]

# The demanded work in the fifth question is to create a new tidy data set 
# with the average of each variable for each activity and each subject.
colnames(sub_all) <- "subject"
# subject=sub_all$subject
combine <- cbind(X, activity, sub_all)
temp <- group_by(combine,activity, subject)
final <- summarize_all(temp,funs(mean))

write.table(final, file = "./tidy_data.txt", row.names = FALSE, col.names = TRUE)