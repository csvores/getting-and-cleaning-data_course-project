install.packages("dplyr")
library(dplyr)  
activityLabels <- read.table("activity_labels.txt", header = FALSE)
featureNames <- read.table("features.txt", header = FALSE)
subjectTest <- read.table("subject_test.txt", header = FALSE)
X_test <- read.table("X_test.txt", header = FALSE)
y_test <- read.table("y_test.txt", header = FALSE)
subjectTrain <- read.table("subject_train.txt", header = FALSE)
X_train <- read.table("X_train.txt", header = FALSE)
y_train <- read.table("y_train.txt", header = FALSE)
str(activityLabels)
str(featureNames)
str(subjectTest)
str(subjectTrain)
str(X_test)
str(X_train)
str(y_test)
str(y_train)
dataSubject <- rbind(subjectTrain, subjectTest)
dataY<- rbind(y_train, y_test)
dataX<- rbind(X_train, X_test)
names(dataSubject)<-c("subject")
names(dataY)<- c("activity")
dataXNames <- featureNames
names(dataX)<- dataXNames$V2
dataCombine <- cbind(dataSubject, dataY)
Data <- cbind(dataX, dataCombine)
sapply(dataSubject, mean, na.rm=TRUE)  
sapply(dataSubject, sd, na.rm=TRUE) 
sapply(dataX, mean, na.rm=TRUE)  
sapply(dataX, sd, na.rm=TRUE)  
sapply(dataY, mean, na.rm=TRUE)  
sapply(dataY, sd, na.rm=TRUE) 
Data$activity[Data$activity==1] <- "WALKING"
Data$activity[Data$activity==2] <- "WALKING_UPSTAIRS"
Data$activity[Data$activity==3] <- "WALKING_DOWNSTAIRS"
Data$activity[Data$activity==4] <- "SITTING"
Data$activity[Data$activity==5] <- "STANDING"
Data$activity[Data$activity==6] <- "LAYING"
head(Data$activity,30)
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
library(plyr)
tidyData<-aggregate(. ~subject + activity, Data, mean)
tidyData<-tidyData[order(tidyData$subject,tidyData$activity),]
write.table(tidyData, file = "tidydata.txt",row.name=FALSE)
tidyData
