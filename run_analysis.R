# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Check if the file exists else download

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

##Combine the raw data sets X files
trainx <- read.table("X_train.txt")
testx <- read.table("X_test.txt")

combinedx <- rbind2(testx,trainx)

# get the column names updated
#Extract the col names, clean features cf
##cf <- read.fwf("features.txt",widths = c(-4,36))
tr <- read.table("features.txt")
str(tr)
cf <- as.character(tr$V2)
colnames(combinedx) <- cf

str(combinedx)

head(combinedx,n= 2)

##'data.frame':        10299 obs. of  561 variables:
##In features.txt file, 303th to 344th variables have duplicated variable names (except numbers). 
Please try followed code to remove columns with duplicated variable names. 

combinedxndup <- combinedx[, !duplicated(colnames(combinedx))]
str(combinedxndup)

# I spent about two hours on this same issue. What I found on google is that dplyr has a difficult time selecting columns based on strings. 
# 
# http://stackoverflow.com/questions/25923392/r-dplyr-select-columns-based-on-string
# This website provides an example of a good work around.

## extract only the columns that you need 

# REgex to find the mean and Std Value = TRUE option is needed to get the actual value.
r <- grep("mean()|std()",cf,perl = TRUE,value = TRUE)
fdata <- select(combinedxndup,one_of(r))

## combine the activity TEST and TRAIN data sets.
trainy <- read.table("y_train.txt")
class(testy)

combinedy <- rbind2(testy,trainy)

## add a new variable called activity with meaningful names to the activity dataset
values <- c("walk","walk_up","walk_down","sit","stand","lay")
combinedy$activity <- values[combinedy$V1]
str(combinedy)
combinedy <- combinedy[,2]

## combine the subject TEST and TRAIN data sets
trains <- read.table("subject_train.txt")
tests <- read.table("subject_test.txt")

combineds <- rbind2(tests,trains)
colnames(combineds) <- "subjects"
head(combineds,n= 10)

## combine subjects and activity
combinedas <- cbind(combineds,combinedy)
head(combinedas,n=32)
str(combinedas)

## combine both the sub/activity and X datasets
combinedasx <- cbind(combinedas,fdata)
head(combinedasx,n=2)
combinedasx <- combinedasx[,-2]

## change the following columns as factors
combinedasx$activity <- as.factor(combinedasx$activity)
combinedasx$subjects <- as.factor(combinedasx$subjects)
str(combinedasx)

## calculate the mean - to do that you need to melt and cast
install.packages("reshape")
library("reshape")
md <- melt(combinedasx,id=(c("subjects","activity")))
ct <- cast(md,subjects+activity~variable,mean)

# label the variables with meaningful names
mnames <- c("subjects","activity","AvgBodyAccelerationXaxis          ",
            "AvgBodyAccelerationYaxis          ",
            "AvgBodyAccelerationZaxis          ",
            "AvgStdDevBodyAccelerationXaxis    ",
            "AvgStdDevBodyAccelerationYaxis    ",
            "AvgStdDevBodyAccelerationZaxis    ",
            "AvgGravityAccelerationXaxis       ",
            "AvgGravityAccelerationYaxis       ",
            "AvgGravityAccelerationZaxis       ",
            "AvgStdDevGravityAccelerationXaxis ",
            "AvgStdDevGravityAccelerationYaxis ",
            "AvgStdDevGravityAccelerationZaxis ",
            "AvgBodyAccelerationJerkXaxis      ",
            "AvgBodyAccelerationJerkYaxis      ",
            "AvgBodyAccelerationJerkZaxis      ",
            "AvgStdDevBodyAccelerationJerkXaxi ",
            "AvgStdDevBodyAccelerationJerkYaxi ",
            "AvgStdDevBodyAccelerationJerkZaxi ",
            "AvgBodyGyroXaxis                  ",
            "AvgBodyGyroYaxis                  ",
            "AvgBodyGyroZaxis                  ",
            "AvgofStdDevBodyGyroXaxis          ",
            "AvgofStdDevBodyGyroYaxis          ",
            "AvgofStdDevBodyGyroZaxis          ",
            "AvgBodyGyroJerkXaxis              ",
            "AvgBodyGyroJerkYaxis              ",
            "AvgBodyGyroJerkZaxis              ",
            "AvgofStdDevBodyGyroJerkXaxis      ",
            "AvgofStdDevBodyGyroJerkYaxis      ",
            "AvgofStdDevBodyGyroJerkZaxis      ",
            "AvgBodyAcclerationMagnitude       ",
            "AvgStdDevBodyAcclerationMagnitude ",
            "AvgBodyAcclerationMagnitude       ",
            "AvgStdDevGravityAcclerationMagnit ",
            "AvgGravityAcclerationMagnitude    ",
            "AvgStdDevGravityAcclerationMagnit ",
            "AvgGravityGyronMagnitude          ",
            "AvgStdDevGravityGyroMagnitude     ",
            "AvgBodyGyroJerkMag                ",
            "AvgStdDevBodyGyroJerkMag          ",
            "AvgBodyAcclerationXAxis           ",
            "AvgBodyAcclerationYAxis           ",
            "AvgBodyAcclerationZAxis           ",
            "AvgStdDevBodyAcclerationXAxis     ",
            "AvgStdDevBodyAcclerationYAxis     ",
            "AvgStdDevBodyAcclerationZAxis     ",
            "AvgFreqBodyAcclerationXAxis       ",
            "AvgFreqBodyAcclerationYAxis       ",
            "AvgFreqBodyAcclerationZAxis       ",
            "AvgBodyAcclerationJerkXAxis       ",
            "AvgBodyAcclerationJerkYAxis       ",
            "AvgBodyAcclerationJerkZAxis       ",
            "AvgStdDevBodyAcclerationJerkXAxis ",
            "AvgStdDevBodyAcclerationJerkYAxis ",
            "AvgStdDevBodyAcclerationJerkZAxis ",
            "AvgFreqBodyAcclerationJerkXAxis   ",
            "AvgFreqBodyAcclerationJerkYAxis   ",
            "AvgFreqBodyAcclerationJerkZAxis   ",
            "AvgfBodyGyroXaxis                 ",
            "AvgfBodyGyroYaxis                 ",
            "AvgfBodyGyroZaxis                 ",
            "AvgfStdDevBodyGyroXaxis           ",
            "AvgfStdDevBodyGyroYaxis           ",
            "AvgfStdDevBodyGyroZaxis           ",
            "AvgfFreqBodyGyroXAxis             ",
            "AvgfFreqBodyGyroYAxis             ",
            "AvgfFreqBodyGyroZAxis             ",
            "AvgfBodyAcclerationMagnitude      ",
            "AvgfStdDevBodyAcclerationMagnitude",
            "AvgfFreqBodyAccMagnitude          ",
            "AvgfBodyBodyAccJerkMag            ",
            "AvgStdDevfBodyBodyAccJerkMag      ",
            "AvgfFreqBodyBodyAccJerkMag        ",
            "AvgfBodyBodyGyroMag               ",
            "AvgfBodyBodyGyroMag               ",
            "AvgfFreqBodyBodyGyroMag           ",
            "AvgfBodyBodyGyroJerkMag           ",
            "AvgfBodyBodyGyroJerkMag           ",
            "AvgfFreqBodyBodyGyroJerkMag       ")

colnames(ct) <- mnames
View(ct)
## write table
write.table(ct,file ="tidy.txt",row.names = FALSE)

