
We were given two data files X_test.txt and X_training.txt containing
observations of various physical quantities (linear and angular accelerations
and jerk, and so forth) for subjects who were performing various types of
physical activity.  The two data files are labeled "test" and "training";
apparently they were being used to fit a statistical model.  For the data in
X_test, the corresponding subjects and activities are in the files
subject_test.txt and y_test.txt; similar files can be found for the training
data.  The activity labels corresponding to the numbers in y_test.txt and
y_training.text (walking, etc.) are in activity_labels.txt.

For our purposes, we will simply merge the two data sets.

Each row of the data files X_test.txt and X_training.txt corresponds to
statistics for one set of observations for a particular subject engaged in a
particular kind of physical activity.  The labels for this data are found in
features.txt, and their physical interpretations are in features_info.txt.

Some of these statistics have either "mean()" or "std()" in their names; these
statistics appear to represent means and standard deviations for expanded sets
of observations.  For each (subject, activity) pair we have pulled out all of
the statistics with either "mean()" or "std()" in their names and taken their
means.  The original values we are dealing with have been normalized to sit in
the interval [-1,1], so the precise physical meaning of the means we are
computing is not clear.

Running the script run_analysis.R on the data will produce output data written
to the file run_analysis.txt.  It has the following columns:

Subject_number:  The number of the subject for the given row
Activity_name:   The name of the activity for the given row
Statistic:       The particular statistic that was observed for the given
                 subject and activity
Mean:            The mean of all the observations of the given statistic
                 for the given subject and activity

The first few rows are as follows:

"Subject_number" "Activity_name" "Statistic" "Mean"
1 "WALKING" "tBodyAcc-mean()-X" 0.277330758736842
1 "WALKING" "tBodyAcc-mean()-Y" -0.0173838185273684
1 "WALKING" "tBodyAcc-mean()-Z" -0.111148103547368
1 "WALKING" "tBodyAcc-std()-X" -0.283740258842105
1 "WALKING" "tBodyAcc-std()-Y" 0.114461336747368
1 "WALKING" "tBodyAcc-std()-Z" -0.260027902210526

Looking at the fourth row here, we see that subject 1 engaged in some sort
of walking activity a number of times.  Some quantity 'tBody-Acc-X' was
measured a number of times, and the standard deviation of this quantity was
written down in the original data set.  We have extracted all measurements
of the quantity 'tBodyAcc-std()-X' for subject 1 engaged in walking activity
and have computed the mean of all these quantities to be -0.28374.