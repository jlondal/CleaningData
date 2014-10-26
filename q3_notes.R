setwd("/Users/jameslondall/Dropbox/DS Course/Cleaning Data")


set.seed(13435)

X<-data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X<-X[sample(1:5),]
X$var2[c(1,3)]= NA

#select just the first column
X[rows,columns]

X[,1]
X[,"var2"]

#select rows and column
X[1:2,"var2"]
X[(X$var1 <= 3 & X$var3>11),]

#will handle NA's
X[which(X$var2 > 2) ,]


#sorts
sort(X$var2,decreasing=TRUE,na.last=TRUE)

#sort all columns

X[order(X$var1),]
X[order(X$var1,X$var2),]

library(plyr)

arrange(X,var1)
arrange(X,desc(var1))

#adding to a dataframe
X$var4 <- rnorm(5)
X<- cbind(X,rnorm(5))

#describing data
summary(X)
str(X)

quantile(X$var1,na.rm=TRUE,probs=c(0.5,0.75))

#pivote tables
table(X$var1,useNA="ifany")
table(X$var2,X$var3,useNA="ifany")

#checking for NA

sum(is.na(X$var1))
sum(is.na(X$var2))
any(is.na(X$var2))

colSums(is.na(X))

table(X$var1 %in% c(2,4))

Y<-X[X$var1 %in% c(2,4),]

#xross tab

xt <- xtabs[var2 ~ var3, data = X]

#sequences
s1 <- seq(1,10,by=2)
s1 <- seq(1,10,length=3)



if(!file.exists("data")) {dir.create("data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="data/resturants.csv",method="curl")
restData<-read.csv("data/resturants.csv")

restData$nearMe = restData$neighborhood %in% c("Roland Park","Homeland")
table(restData$nearMe)

restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong)

restData$zipGroups = cut(restData$zipCode,breaks=quantile(restData$zipCode))

table(restData$zipGroups,restData$zipCode)

library(Hmisc)

restData$zipGroups = cut2(restData$zipCode,g=4)
restData$zcf <- factor(restData$zipCode)

restData$zcf[1:10]


#transpose
library(reshape2)

restData_T <- melt(restData,id=c("neighborhood"),measure.vars=c("councilDistrict"))

restData_t1 <- dcast(restData_T,neighborhood ~ variable,count)
