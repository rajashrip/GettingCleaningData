Getting and Cleaning Data Project
The run_analysis.R function does the following actions-
Checks if the file exists else download the Zip file.
Reads and combines the raw data sets called X_train and X_test text files into a dataset called "combinedx"
Extracts the names from the file features.txt to be used as variable names and assigns the names to columns in "combinedx"
Remove the columns in combinedx dataset with duplicate variable names
Extract only the columns you need using regular expressions.
Read and combine the Activity test and train files TEST(y_test.txt) and TRAIN(y_train.txt) 
Add a new variable called activity with meaningful names to the activity dataset based on the numeric values that already exist in the file.
Read and combine the subject TEST and TRAIN data sets. Add a column name called subjects.
Combine the subject and activity dataset to create "combinedas"
Combine both the sub/activity(combinedas) and X(combinedx) datasets to create combinedasx
Change the following columns as factors
combinedasx$activity <- as.factor(combinedasx$activity)
combinedasx$subjects <- as.factor(combinedasx$subjects)
Calculate the mean using the reshape package.
Melt and cast the above package to have-
md <- melt(combinedasx,id=(c("subjects","activity")))
ct <- cast(md,subjects+activity~variable,mean)
Label the variables with meaningful names
colnames(ct) <- mnames
Write the tidy dataset to a table
write.table(ct,file ="tidy.txt",row.names = FALSE)

