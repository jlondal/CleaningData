setwd("/Users/jameslondall/Dropbox/DS Course/Cleaning Data")

# Question 1

library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications;
#    Use any URL you would like for the homepage URL (http://github.com is fine)
#    and http://localhost:1410 as the callback url
#
#    Insert your client ID and secret below - if secret is omitted, it will
#    look it up in the GITHUB_CONSUMER_SECRET environmental variable.
myapp <- oauth_app("github", "0212a2d5e79096469d32","46e842ec50119d43ed014dd2f09344653632b2b8")

# 3. Get OAuth credentials

# 4. Use API
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/rate_limit", gtoken)
stop_for_status(req)
content(req)

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos/datasharing", gtoken)
stop_for_status(req)
content(req)

# Question 2
library(data.table)
library(sqldf)

acs <- read.csv('data/acs.csv')

sqldf("select pwgtp1 from acs where AGEP < 50")


# Question 4

con = url("http://biostat.jhsph.edu/~jleek/contact.html ")
htmlCode = readLines(con,n=100)
close(con)

nchar(htmlCode)

# Question 5

df<-read.fwf("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for",
             c())



