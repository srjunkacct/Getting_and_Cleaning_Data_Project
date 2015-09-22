
# We read in the text labels describing the activities and the features of the data

activity_vector=as.vector(read.delim("UCI HAR Dataset/activity_labels.txt",sep=" ",header=F)$V2)
feature_vector=as.vector(read.delim("UCI HAR Dataset/features.txt",sep=" ",header=F)$V2)

# Pick out which of the features represent means and standard deviations

meanandstd_feature_columns=grep("mean\\(\\)|std\\(\\)",feature_vector)

# There's leading whitespace in each line of X_train and X_test,
# and two spaces in front of an entry that doesn't have a
# minus sign.  I couldn't figure out how to read it as a data table
# using read.* function, so we will read those in as vectors, then
# coercing it into matrices of the proper size.

NUMBER_OF_FEATURES<-length(feature_vector)
NUMBER_OF_MEANSTD<-length(meanandstd_feature_columns)

# Read in the training data
training_features<-scan(file="UCI HAR Dataset/train/X_train.txt")

# Append the test data
combined_features<-c(training_features,scan(file="UCI HAR Dataset/test/X_test.txt"))

# Coerce into a data frame, one column per feature
combined_features<-as.data.frame(matrix(combined_features,byrow=T,nrow=length(combined_features)/NUMBER_OF_FEATURES,ncol=NUMBER_OF_FEATURES))

# Add the labels to the columns
names(combined_features)<-feature_vector

# Get the subject numbers for the training and test data and shove them into a new column
combined_features$Subject_number<-c(scan(file="UCI HAR Dataset/train/subject_train.txt"), scan(file="UCI HAR Dataset/test/subject_test.txt"))

# Get the activity names for the training and test data and shove them into a new column
combined_features$Activity_name<-activity_vector[c(scan(file="UCI HAR Dataset/train/y_train.txt"),scan(file="UCI HAR Dataset/test/y_test.txt"))]

# Create the table containing the subject numbers, activity names, and data for each (subject,activity) pair
all_columns<-c(NUMBER_OF_FEATURES+1,NUMBER_OF_FEATURES+2,meanandstd_feature_columns)
combined_subtable<-combined_features[,all_columns]

# Compute means of each feature, separated by each (subject, activity) value
subject_numbers<-unique(combined_subtable$Subject_number)
mainframe<-data.frame(Subject_number=c(),Activity_name=c(),Statistic=c(),Mean=c())
for (subject in subject_numbers) {
  for (activity in activity_vector) {
    # Pull out the subtable corresponding by the current subject and activity
    subtable<-combined_subtable[(combined_subtable$Subject_number == subject & combined_subtable$Activity_name == activity),-1:-2]
    meanvector<-apply(subtable,2,mean)
    # We will organize our data in wide form, so there will be one separate row for each statistic
    subframe<-data.frame(row.names=NULL,Subject_number=rep(subject,NUMBER_OF_MEANSTD),Activity_name=rep(activity,NUMBER_OF_MEANSTD),Statistic=names(combined_subtable)[-1:-2],Mean=meanvector)
    mainframe<-rbind(mainframe,subframe)
  }
}

# Print out our results
write.table(mainframe,file="run_analysis.txt",row.names=F)