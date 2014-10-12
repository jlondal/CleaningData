setwd("/Users/jameslondall/Dropbox/DS Course/Cleaning Data")



fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
fin<-download.file(fileUrl,destfile="data/acs_q1.csv",method="curl")


library(data.table)
acs_DF <- read.csv('data/acs_q1.csv')
acs_DT <- data.table(acs_DF)
head(acs_DT,3)
dateDownloaded <- date()
print(dateDownloaded)

library(xlsx)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
fin<-download.file(fileUrl,destfile="data/nga_q1.xlsx",method="curl")

dat<-read.xlsx("data/nga_q1.xlsx",sheetIndex=1,colIndex=7:15,rowIndex=18:23)
sum(dat$Zip*dat$Ext,na.rm=T) 

library(XML)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
fin<-download.file(fileUrl,destfile="data/bal_rest.xml",method="curl")
doc<-xmlTreeParse("data/bal_rest.xml",useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)

rootNode[[1]][[1]]

zipcodes<-data.frame(zips=xpathSApply(rootNode,"//zipcode",xmlValue))
length(zipcodes[zipcodes$zips==21231,])

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
fin<-download.file(fileUrl,destfile="data/acs_2.csv",method="curl")
DT<-fread("data/acs_2.csv")
DT[,mean(pwgtp15),by=SEX]

