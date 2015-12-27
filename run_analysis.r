
list.dirs()

##Read Features####
names_x <- read.table("features.txt")
dim(names_x)
head(names_x)

##Test Files Initialization####
test_x <- read.table("./test/X_test.txt")
dim(test_x)
colnames(test_x) <- names_x$V2
head(test_x)
test_x$DataSet <- "Test"
head(test_x)

test_y <- read.table("./test/y_test.txt")
dim(test_y)
colnames(test_y) <- "Labels"


test_subject <- read.table("./test/subject_test.txt")
dim(test_subject)
colnames(test_subject) <- "Subject"
head(test_subject)
table(test_subject)

##Train Files Initialization###
train_x <- read.table("./train/X_train.txt")
dim(train_x)
colnames(train_x) <- names_x$V2
head(train_x)
train_x$DataSet <- "Train"
head(train_x)

train_y <- read.table("./train/y_train.txt")
head(train_y)
colnames(train_y) <- "Labels"


train_subject <- read.table("./train/subject_train.txt")
colnames(train_subject) <- "Subject"
dim(train_subject)
head(train_subject)




##Bind Columns for Test and Train individually ###

test_x_allcols <- cbind(test_x,test_y,test_subject)
dim(test_x_allcols)

train_x_allcols <- cbind(train_x,train_y,train_subject)
dim(train_x_allcols)

##Bind both Test and Train Results####
full_set <- rbind(test_x_allcols,train_x_allcols)
dim(full_set)

full_set <- full_set[, !duplicated(colnames(full_set))]

###1st step complete###

##2nd Step Start###
##Extracts only the measurements on the mean and standard deviation for each measurement. 
meanstd_set <- select(full_set,DataSet, Subject, Labels,contains ("mean"),contains("std") )
dim(meanstd_set)

labels<-read.table("activity_labels.txt", header=FALSE) 

labels

##3rdStep###
## 3.Uses descriptive activity names to name the activities in the data set
meanstd_set$Labels<-factor(meanstd_set$Labels, levels=c(1, 2, 3, 4, 5, 6), 
                  labels=c("WALKING", "WALKING_UPSTAIRS", 
                           "WALKING_DOWNSTAIRS", "SITTING", "STANDING","LAYING"))
table(meanstd_set$Labels)



## 4.Appropriately labels the data set with descriptive variable names.

##tBody     time-Body
##tGravity	time-Gravity
##Mag	      Magnitude
##Gyro	    Gyroscope
##Acc	      Accelerometer
##fBody	    fastFourierTransform_Body
##Freq	    Frequency
##BodyBody	Body

nmeanstd_set<-gsub ("tBody", "time-Body", names(meanstd_set), ignore.case=FALSE)
nmeanstd_set<-gsub ("tGravity", "time-Gravity", nmeanstd_set, ignore.case=FALSE)
nmeanstd_set<-gsub ("Mag", "Magnitude", nmeanstd_set, ignore.case=FALSE)
nmeanstd_set<-gsub ("Gyro", "Gyroscope", meanstd_set, ignore.case=FALSE)
nmeanstd_set<-gsub ("Acc", "Accelerometer", nmeanstd_set, ignore.case=FALSE)
nmeanstd_set<-gsub ("fBody", "fastFourierTransform-Body", nmeanstd_set, ignore.case=FALSE)
nmeanstd_set<-gsub ("Freq", "Frequency", nmeanstd_set, ignore.case=FALSE)
nmeanstd_set<-gsub ("BodyBody", "Body", nmeanstd_set, ignore.case=FALSE)

colnames(meanstd_set)<-nmeanstd_set


###5 From the data set in step 4, creates a second, independent 
##tidy data set with the average of each variable for each activity and each subject.

avedata<-meanstd_set %>%
  select(-DataSet) %>%
  group_by(Subject, Labels) %>%
  summarise_each(funs(mean))

write.table(avedata, file="avedata.txt", row.names=FALSE, col.names=TRUE)


