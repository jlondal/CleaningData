# MySQL 
library(RMySQL)

hg19 <- dbConnect(MySQL(),user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
dbDisconnect(ucscDb)

df<-dbGetQuery(hg19,"select * form ...")

df<-dbReadTable(hg19,'some table')

query<-dbSendQuery(hg19,"select * from ... where...")
affMis<- fetch(query,n=100)
dbClearResult(query)
quantile(affyMiss$some_field)

# HDF5

library(rhdf5)
create = h5createFile("example.h5")

created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","bar")

h5write(A,"example.h5","foo/A")
h5write(df,"example.h5","df")

h5write(c(12,13,14),"example.h5","foo/A",index=list(1:3,1))

h5read("example.h5","foo/A")

h5ls("example.h5")

# Web

con = url("....")
htmlCode = readLines(con)
close(con)


library(XML)
html<-htmlTreeParse(url, useInternalNodes=1)

xpathSApply(html,"//title",xmlValue)
xpathSApply(html,"//td[@id='col-citedby']",xmlValue)

library(httr)
html <- GET(url,authenticate("user","passwd"))
content<-content(html,as="text")
parsedHtml <- htmlParse(content,asText=TRUE)
xpathSApply(parsedHtml,'//title',xmlValue)

google <- handle("http://google.com")
html <- GET(google,path="/")

# API













