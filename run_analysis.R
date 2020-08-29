## Loading test datasets
dr<-getwd()
setwd("./UCI HAR Dataset")
xtest<-read.table("./test/X_test.txt")
subtest<-read.table("./test/subject_test.txt")
ytest<-read.table("./test/y_test.txt")

## Loading train datasets
xtrain<-read.table("./train/X_train.txt")
subtrain<-read.table("./train/subject_train.txt")
ytrain<-read.table("./train/y_train.txt")

## Extracting activity and features
activity<-read.table("./activity_labels.txt")
features<-read.table("./features.txt")
setwd(dr)

## Merging datasets
library(dplyr)
merge_x<-rbind(xtrain,xtest)
merge_y<-rbind(ytrain,ytest)
merge_sub<-rbind(subtrain,subtest)

## Processing merge_y and merge_sub
merge_y<-factor(merge_y$V1,levels=activity$V1,labels=activity$V2)
merge_sub<-factor(merge_sub$V1)

## Extracting only mean and std
l1<-grep("mean()",features$V2,fixed=TRUE)
l2<-grep("std()",features$V2,fixed=TRUE)
l<-sort(c(l1,l2))
merge_x<-select(merge_x,l)
names(merge_x)<-features[l,2]
names(merge_x)<-gsub("-mean()"," Mean",names(merge_x),fixed=TRUE)
names(merge_x)<-gsub("-std()"," Std",names(merge_x),fixed=TRUE)

## Merging all tables
data<-cbind(merge_sub,merge_y,merge_x)
names(data)[c(1,2)]<-c("Subjects","Activity")

## Creating tidy data
tidy<-matrix(nrow=182,ncol=68,dimnames=list(c(1:182),names(data)))
x<-0
for(sub in sort(unique(merge_sub)))
{
  for(act in activity$V2)
  {
    x<-x+1
    tidy[x,1]<-sub;tidy[x,2]<-act
    tidy[x,3:68]<-colMeans(filter(data,Subjects==sub&Activity==act)[,3:68])
    
  }
}
write.table(tidy,file="Tidy_Data.txt",row.name=FALSE)