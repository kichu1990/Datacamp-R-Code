# Load the DBI package
library(DBI)

# Edit dbConnect() call
con <- dbConnect(RMySQL::MySQL(), 
                 dbname = "tweater", 
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                 port = 3306,
                 user = "student",
                 password = "datacamp")
#con is an MySQLConnection object.

# Build a vector of table names: tables
tables <- dbListTables(con)

# Display structure of tables
str(tables)

# Import the users table from tweater: users
users <- dbReadTable(con,"users")

# Print users
print(users)

# Get table names
table_names <- dbListTables(con)

# Import all tables
tables <- lapply(table_names, dbReadTable, conn = con)

# Print out tables
tables

# Import tweat_id column of comments where user_id is 1: elisabeth
elisabeth=dbGetQuery(con,"select tweat_id from comments where user_id =1") 

# Print elisabeth
elisabeth

# Import post column of tweats where date is higher than '2015-09-21': latest
latest=dbGetQuery(con,"select post from tweats where date > '2015-09-21' ") 

# Print latest
latest

# Create data frame specific
specific=dbGetQuery(con,"select message from comments where tweat_id=77 and user_id>4")

# Print specific
specific

# Create data frame short
short=dbGetQuery(con,"select id,name from users where CHAR_LENGTH(name) < 5")

# Print short
short

dbGetQuery(con,"SELECT post, message
  FROM tweats INNER JOIN comments on tweats.id = tweat_id
           WHERE tweat_id = 77")

# Send query to the database
res <- dbSendQuery(con, "SELECT * FROM comments WHERE user_id > 4")

# Use dbFetch() twice
dbFetch(res,n=2)

# Clear res
dbClearResult(res)

# Create the data frame  long_tweats
long_tweats=dbGetQuery(con,"select post,date from tweats where CHAR_LENGTH(post) > 48")

# Print long_tweats
print(long_tweats)

# Disconnect from the database
dbDisconnect(con)

# Load the readr package
library(readr)

# Import the csv file: pools
url_csv <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/swimming_pools.csv"
pools <- read_csv(url_csv)

# Import the txt file: potatoes
url_delim <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/potatoes.txt"
potatoes <- read_tsv(url_delim)

# Print pools and potatoes
pools
potatoes

# https URL to the swimming_pools csv file.
url_csv <- "https://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/swimming_pools.csv"

# Import the file using read.csv(): pools1
pools1=read.csv(url_csv)

# Load the readr package
library(readr)

# Import the file using read_csv(): pools2
pools2=read_csv(url_csv)

# Print the structure of pools1 and pools2
str(pools1)
str(pools2)

# Load the readxl and gdata package
library(readxl)
library(gdata)

# Specification of url: url_xls
url_xls <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/latitude.xls"

# Import the .xls file with gdata: excel_gdata
excel_gdata <- read.xls(url_xls)

# Download file behind URL, name it local_latitude.xls
download.file(url_xls, destfile = "local_latitude.xls")

# Import the local .xls file with readxl: excel_readxl
excel_readxl <- read_excel("local_latitude.xls")

# https URL to the wine RData file.
url_rdata <- "https://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/wine.RData"

# Download the wine file to your working directory
download.file(url_rdata, destfile = "wine_local.RData")

# Load the wine data into your workspace using load()
load("wine_local.RData")

# Print out the summary of the wine data
summary(wine)

#Downloading a file from the Internet means sending a GET request and receiving the 
#file you asked for. Internally, all the previously discussed functions use a GET 
#request to download files.
#httr provides a convenient function, GET() to execute this GET request. The result is
#a response object, that provides easy access to the status code, content-type and, 
#of course, the actual content.
#You can extract the content from the request using the content() function. 
#At the time of writing, there are three ways to retrieve this content: as a raw 
#object, as a character vector, or an R object, such as a list. If you don't tell 
#content() how to retrieve the content through the as argument, it'll try its best to 
#figure out which type is most appropriate based on the content-type.

# Load the library package
library(httr)

# Get the url, save response to resp
url <- "http://www.example.com/"

# Print resp
resp=GET(url)

# Get the raw content of resp: raw_content
raw_content=content(resp,as = "raw")

# Print the head of raw_content
head(raw_content)

# httr is already loaded

# Get the url
url <- "http://www.omdbapi.com/?apikey=ff21610b&t=Annie+Hall&y=&plot=short&r=json"


# Print resp
resp=GET(url)
print(resp)

# Print content of resp as text
content(resp,as="text")

# Print content of resp
content(resp)

# Load the jsonlite package
library(jsonlite)

# wine_json is a JSON
wine_json <- '{"name":"Chateau Migraine", "year":1997, "alcohol_pct":12.4, "color":"red", "awarded":false}'

# Convert wine_json into a list: wine
wine <- fromJSON(wine_json)

# Print structure of wine
str(wine)

# jsonlite is preloaded

# Definition of quandl_url
quandl_url <- "https://www.quandl.com/api/v3/datasets/WIKI/FB/data.json?auth_token=i83asDsiWUUyfoypkgMz"

# Import Quandl data: quandl_data
quandl_data <- fromJSON(quandl_url)

# Print structure of quandl_data
str(quandl_data)

# The package jsonlite is already loaded

# Definition of the URLs
url_sw4 <- "http://www.omdbapi.com/?apikey=ff21610b&i=tt0076759&r=json"
url_sw3 <- "http://www.omdbapi.com/?apikey=ff21610b&i=tt0121766&r=json"

# Import two URLs with fromJSON(): sw4 and sw3
sw4 <- fromJSON(url_sw4)
sw3 <- fromJSON(url_sw3)

# Print out the Title element of both lists
sw4$Title
sw3$Title

# Is the release year of sw4 later than sw3?
sw4$Year > sw3$Year

# jsonlite is already loaded

# Challenge 1
json1 <- '[1, 2, 3, 4, 5, 6]'
fromJSON(json1)

# Challenge 2
json2 <- '{"a": [1, 2, 3], "b": [4, 5, 6]}'
fromJSON(json2)


# Challenge 1
json1 <- '[[1, 2], [3, 4]]'
fromJSON(json1)

# Challenge 2
json2 <- '[{"a": 1, "b": 2}, {"a": 3, "b": 4}, {"a": 5, "b": 6}]'
fromJSON(json2)

# jsonlite is already loaded

# URL pointing to the .csv file
url_csv <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/water.csv"

# Import the .csv file located at url_csv
water <- read.csv(url_csv,stringsAsFactors = FALSE)

# Convert the data file according to the requirements
water_json <- toJSON(water)

# Print out water_json
print(water_json)

#Minify and prettify
#JSONs can come in different formats. Take these two JSONs, that are in fact exactly
#the same: the first one is in a minified format, the second one is in a pretty format 
#with indentation, whitespace and new lines:

# Mini
#{"a":1,"b":2,"c":{"x":5,"y":6}}

# Pretty
#{
#  "a": 1,
#  "b": 2,
#  "c": {
#    "x": 5,
#    "y": 6
#  }
#}

# jsonlite is already loaded

# Convert mtcars to a pretty JSON: pretty_json
pretty_json=toJSON(mtcars,pretty=TRUE)

# Print pretty_json
print(pretty_json)

# Minify pretty_json: mini_json
mini_json=toJSON(mtcars)
minify(mini_json)

# Print mini_json
print(mini_json)

# Load the haven package
library(haven)

# Import sales.sas7bdat: sales
sales <- read_sas("sales.sas7bdat")

# Display the structure of sales
str(sales)

# haven is already loaded

# Import the data from the URL: sugar
sugar<- read_dta("http://assets.datacamp.com/production/course_1478/datasets/trade.dta")

# Structure of sugar
str(sugar)

# Convert values in Date column to dates
sugar$Date <- as.Date(as_factor(sugar$Date))

# Structure of sugar again
str(sugar)

plot(Import,Weight_I)

# haven is already loaded
library(haven)

# Import person.sav: traits
traits <- read_sav("person.sav")

# Summarize traits
summary(traits)

# Print out a subset
subset(traits, Extroversion > 40 & Agreeableness > 40)

# haven is already loaded

# Import SPSS data from the URL: work
work <- read_sav("http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/employee.sav")

# Display summary of work$GENDER
summary(work$GENDER)

# Convert work$GENDER to a factor
work$GENDER <- as.factor(work$GENDER)

# Display summary of work$GENDER again
summary(work$GENDER)

# Load the foreign package
library(foreign)

# Import florida.dta and name the resulting data frame florida
florida=read.dta("florida.dta")

# Check tail() of florida
tail(florida)
