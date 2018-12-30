# The date R 3.0.0 was released
x <- "2013-04-03"

# Examine structure of x
str(x)

# Use as.Date() to interpret x as a date
x_date <- as.Date(x)

# Examine structure of x_date
str(x_date)

# Store April 10 2014 as a Date
april_10_2014 <- as.Date("2014-04-10")

#Anytime() function in the anytime package whose sole goal is to automatically parse 
#strings as dates regardless of the format.

# Load the readr package
library(readr)

# Use read_csv() to import rversions.csv
releases <- read_csv("D:\\Study  Materials\\R Language\\DataSet\\rversions.csv")

# Examine the structure of the date column
str(releases$date)

# Load the anytime package
library(anytime)

# Various ways of writing Sep 10 2009
sep_10_2009 <- c("September 10 2009", "2009-09-10", "10 Sep 2009", "09-10-2009")

# Use anytime() to parse sep_10_2009
anytime(sep_10_2009)

install.packages("ggplot2")
library(ggplot2)

# Set the x axis to the date column
ggplot(releases, aes(x = date, y = type)) +
  geom_line(aes(group = 1, color = factor(major)))

# Limit the axis to between 2010-01-01 and 2014-01-01
ggplot(releases, aes(x = date, y = type)) +
  geom_line(aes(group = 1, color = factor(major))) +
  xlim(as.Date("2010-01-01"), as.Date("2014-01-01"))

# Specify breaks every ten years and labels with "%Y"
ggplot(releases, aes(x = date, y = type)) +
  geom_line(aes(group = 1, color = factor(major)))  +
  scale_x_date(date_breaks = "10 years", date_labels = "%Y")

# Find the largest date
last_release_date <- max(releases$date)

# Filter row for last release
last_release <- filter(releases,date == last_release_date )

# Print last_release
last_release

# How long since last release?
Sys.Date() - last_release_date

#Date objects are internally represented as the number of days since 1970-01-01 you can
#do basic math and comparisons with dates. You can compare dates with the usual logical
#operators (<, ==, > etc.), find extremes with min() and max(), and even subtract two
#dates to find out the time between them

# Use as.POSIXct to enter the datetime 
as.POSIXct("2010-10-01 12:12:00")

# Use as.POSIXct again but set the timezone to `"America/Los_Angeles"`
as.POSIXct("2010-10-01 12:12:00", tz = "America/Los_Angeles")

# Use read_csv to import rversions.csv
releases <- read_csv("rversions.csv")

# Examine structure of datetime column
str(releases$datetime)

#check your timezone with 
Sys.timezone()

# Import "cran-logs_2015-04-17.csv" with read_csv()
logs=read_csv("D:\\Study  Materials\\R Language\\R Files\\cran-logs_2015-04-17.csv",header = TRUE)

# Print logs
logs

# Store the release time as a POSIXct object
release_time <- as.POSIXct("2015-04-16 07:13:33", tz = "UTC")

# When is the first download of 3.2.0?
logs %>% 
  filter(datetime > release_time,
         r_version == "3.2.0")

# Examine histograms of downloads by version
ggplot(logs, aes(x = datetime)) +
  geom_histogram() +
  geom_vline(aes(xintercept = as.numeric(release_time)))+
  facet_wrap(~ r_version, ncol = 1)

#Lubridate Package
#lubridate provides a set of functions for parsing dates of a known order.
#For example, ymd() will parse dates with year first, followed by month and then day.
#The parsing is flexible, for example, it will parse the m whether it is numeric (e.g.
#9 or 09), a full month name (e.g. September), or an abbreviated month name (e.g. Sep).


install.packages("lubridate")
library(lubridate)

# Parse x 
x <- "2010 September 20th" # 2010-09-20
ymd(x)

# Parse y 
y <- "02.01.2010"  # 2010-01-02
dmy(y)

# Parse z 
z <- "Sep, 12th 2010 14:00"  # 2010-09-12T14:00
mdy_hm(z)

#What about if you have something in a really weird order like dym_msh? There's no 
#named function just for that order, but that is where parse_date_time() comes in. 
#parse_date_time() takes an additional argument orders where you can specify the order
#of the components in the date.

?parse_date_time

# Specify an order string to parse x
x <- "Monday Jun 1st 2010 at 4pm"
parse_date_time(x, orders = "AmdyIp")

# Specify order to include both "mdy" and "dmy"
two_orders <- c("October 7, 2001", "October 13, 2002", "April 13, 2003", 
                "17 April 2005", "23 April 2017")
parse_date_time(two_orders, orders =c("mdy","dmy"))
                
# Specify order to include "dOmY", "OmY" and "Y"
short_dates <- c("11 December 1282", "Dec 1372", "1253")
parse_date_time(short_dates, orders =c("dmy","my","Y"))

akl_weather_daily <- read_csv("D:\\Study  Materials\\R Language\\DataSet\\akl_weather_daily.csv")
akl_weather_hourly_2016 <- read_csv("D:\\Study  Materials\\R Language\\DataSet\\akl_weather_hourly_2016.csv")

print(akl_weather_daily)

library(lubridate)
library(readr)
library(dplyr)
library(ggplot2)


# Parse date 
akl_daily <- akl_weather_daily %>%
  mutate(date = parse_date_time(date,orders = "ymd"))

# Print akl_daily
print(akl_daily)

# Plot to check work
ggplot(akl_daily, aes(x = date, y = max_temp )) +
  geom_line() 

# Use make_date() to combine year, month and mday 
akl_hourly  <- akl_weather_hourly_2016  %>% 
  mutate(date = make_date(year = year, month = month, day = mday))

# Parse datetime_string 
akl_hourly <- akl_hourly  %>% 
  mutate(
    datetime_string = paste(date, time, sep = "T"),
    datetime = ymd_hms(datetime_string)
  )

# Print date, time and datetime columns of akl_hourly
akl_hourly %>% select(date, time, datetime)

head(akl_hourly)

# Plot to check work
ggplot(akl_hourly, aes(x = datetime, y = temperature)) +
  geom_line()

#Extracting part of Date and Time

# Use read_csv() to import rversions.csv
releases <- read_csv("D:\\Study  Materials\\R Language\\DataSet\\rversions.csv")

# Examine the structure of the date column
str(releases$date)

# Examine the head() of release_time
head(releases)

# Examine the head() of the months of release_time
head(month(releases$date))
head(year(releases$date))
head(day(releases$date))

# Extract the month of releases 
month(releases$date) %>% table()

# Extract the year of releases
year(releases$date) %>% table()

# How often is the hour before 12 (noon)?
mean(hour(releases$time) < 12)

# How often is the release in am?
mean(am(releases$time))

head(releases)
# Use wday() to tabulate release by day of the week
wday(releases$datetime) %>% table()

# Add label = TRUE to make table more readable
wday(releases$datetime, label=TRUE) %>% table()

# Create column wday to hold labelled week days
releases$wday <- wday(releases$datetime, label=TRUE)


# Plot barchart of weekday by type of release
ggplot(releases, aes(wday)) +
  geom_bar() +
  facet_wrap(~ type, ncol = 1, scale = "free_y")


# Add columns for year, yday and month
akl_daily <- akl_daily %>%
  mutate(
    year = year(date),
    yday = yday(date),
    month = month(date, label = TRUE))


# Plot max_temp by yday for all years
ggplot(akl_daily, aes(x = yday, y = max_temp)) +
  geom_line(aes(group = year), alpha = 0.5)

install.packages("ggridges")
library(ggridges)

# Examine distribtion of max_temp by month
ggplot(akl_daily, aes(x = max_temp, y = month, height = ..density..)) +
  geom_density_ridges(stat = "density")

# Create new columns hour, month and rainy
akl_hourly <- akl_hourly %>%
  mutate(
    hour = hour(datetime),
    month = month(datetime, label=TRUE),
    rainy = weather == "Precipitation"
  )

# Filter for hours between 8am and 10pm (inclusive)
akl_day <- akl_hourly %>% 
  filter(hour>=8, hour<=22)

# Summarise for each date if there is any rain
rainy_days <- akl_day %>% 
  group_by(month,date) %>%
  summarise(
    any_rain = any(rainy)
  )

# Summarise for each month, the number of days with rain
rainy_days %>% 
  summarise(
    days_rainy = sum(any_rain)
  )

r_3_4_1 <- ymd_hms("2016-05-03 07:13:28 UTC")

# Round down to day
floor_date(r_3_4_1, unit = "day")

# Round to nearest 5 minutes
round_date(r_3_4_1, unit = "10 minutes")

# Round up to week
ceiling_date(r_3_4_1, unit = "week")

# Subtract r_3_4_1 rounded down to day
r_3_4_1 - floor_date(r_3_4_1, unit = "day")

# Create day_hour, datetime rounded down to hour
akl_hourly <- akl_hourly %>%
  mutate(
    day_hour = floor_date(datetime, unit = "hour")
  )


# Count observations per hour  
akl_hourly %>% 
  count(day_hour) 

# Find day_hours with n != 2 
akl_hourly %>% 
  count(day_hour) %>%
  filter(n != 2) %>% 
  arrange(desc(n))

#Taking difference of Date and Time

# The date of landing and moment of step
date_landing <- mdy("July 20, 1969")
moment_step <- mdy_hms("July 20, 1969, 02:56:15", tz = "UTC")

# How many days since the first man on the moon?
difftime(today(), date_landing, units = "days")

# How many seconds since the first man on the moon?
difftime(now(), moment_step, units = "secs")

# Three dates
mar_11 <- ymd_hms("2017-03-11 12:00:00", 
                  tz = "America/Los_Angeles")
mar_12 <- ymd_hms("2017-03-12 12:00:00", 
                  tz = "America/Los_Angeles")
mar_13 <- ymd_hms("2017-03-13 12:00:00", 
                  tz = "America/Los_Angeles")

# Difference between mar_13 and mar_12 in seconds
difftime(mar_13, mar_12, units = "secs")

# Difference between mar_12 and mar_11 in seconds
difftime(mar_12, mar_11, units = "secs")

days()
ddays() 
weeks()

#A common use of time spans is to add or subtract them from a moment in time. 
mar_11 + days(1)
mar_11 + ddays(1) 

# Add a period of one week to mon_2pm
mon_2pm <- dmy_hm("27 Aug 2018 14:00")
mon_2pm + weeks(1)

# Add a duration of 81 hours to tue_9am
tue_9am <- dmy_hm("28 Aug 2018 9:00")
tue_9am + hours(81)

# Subtract a period of five years from today()
today() - years(5)

# Subtract a duration of five years from today()
today() - dyears(5)

#Subtracting a duration of five years from today, give a different answer to subtracting
#a period of five years? Periods know about leap years, and since five years ago 
#includes at least one leap year (assuming you aren't taking this course in 2100) the 
#period of five years is longer than the duration of 365*5 days.

# Time of North American Eclipse 2017
eclipse_2017 <- ymd_hms("2017-08-21 18:26:40")

# Duration of 29 days, 12 hours, 44 mins and 3 secs
synodic <-  ddays(29) + dhours(12) + dminutes(44) + dseconds(3)

# 223 synodic months
saros <- synodic * 223

# Add saros to eclipse_2017
eclipse_2017 +  saros

#Generating sequences of datetimes
1:10 * days(1)
today() + 1:10 * days(1)

# Add a period of 8 hours to today
today_8am <- now() + hours(8)

# Add a period of 8 hours to today
today_8am <- today() + hours(8) 

# Sequence of two weeks from 1 to 26
every_two_weeks <- 1:26 * weeks(2)

# Create datetime for every two weeks for a year
today_8am + every_two_weeks

ymd("2018-01-31") + months(1)

# A sequence of 1 to 12 periods of 1 month
month_seq <- 1:12 * months(1)

# Add 1 to 12 months to jan_31
jan_31 + month_seq 

# Replace + with %m+%
jan_31 %m+% month_seq

# Replace + with %m-%
jan_31 %m-% month_seq

#Intervals
# Print monarchs
print(monarchs)

# Create an interval for reign
monarchs <- monarchs %>%
  mutate(reign = from %--% to) 

# Find the length of reign, and arrange
monarchs %>%
  mutate(length = int_length(reign)) %>% 
  arrange(desc(length)) %>%
  select(name, length, dominion)

# Print halleys
halleys

# New column for interval from start to end date
halleys <- halleys %>% 
  mutate(visible = start_date %--% end_date)

# The visitation of 1066
halleys_1066 <- halleys[14, ] 

# Monarchs in power on perihelion date
monarchs %>% 
  filter(halleys_1066$perihelion_date %within% reign) %>%
  select(name, from, to, dominion)

# Monarchs whose reign overlaps visible time
monarchs %>% 
  filter(int_overlaps(halleys_1066$visible, reign)) %>%
  select(name, from, to, dominion)

# New columns for duration and period
monarchs <- monarchs %>%
  mutate(
    duration = as.duration(interval(from,to)),
    period = as.period(interval(from,to))
  ) 

?as.period

# Examine results    
monarchs %>%
  select(name,duration,period)

#Timezones
Sys.timezone()

# Game2: CAN vs NZL in Edmonton
game2 <- mdy_hm("June 11 2015 19:00")

# Game3: CHN vs NZL in Winnipeg
game3 <- mdy_hm("June 15 2015 18:30")

# Set the timezone to "America/Edmonton"
game2_local <- force_tz(game2, tzone = "America/Edmonton")
game2_local

# Set the timezone to "America/Winnipeg"
game3_local <- force_tz(game3, tzone = "America/Winnipeg")
game3_local

# How long does the team have to rest?
as.period(interval(game2_local,game3_local))

# What time is game2_local in NZ?
with_tz(game2_local, tzone = "Pacific/Auckland")

# What time is game2_local in Corvallis, Oregon?
with_tz(game2_local, tzone = "America/Los_Angeles")

# What time is game3_local in NZ?
with_tz(game3_local, tzone = "Pacific/Auckland")

# Examine datetime and date_utc columns
head(akl_hourly$datetime)
head(akl_hourly$date_utc)

# Force datetime to Pacific/Auckland
akl_hourly <- akl_hourly %>%
  mutate(
    datetime = force_tz(datetime, tzone = "Pacific/Auckland"))

# Reexamine datetime
head(akl_hourly$datetime)

# Are datetime and date_utc the same moments
table(akl_hourly$datetime - akl_hourly$date_utc)

# Import auckland hourly data 
akl_hourly <- read_csv("akl_weather_hourly_2016.csv")

# Examine structure of time column
str(akl_hourly$time)

# Examine head of time column
head(akl_hourly$time)

# A plot using just time
ggplot(akl_hourly, aes(x = time, y = temperature)) +
  geom_line(aes(group = make_date(year, month, mday)), alpha = 0.2)

# Head of dates
head(dates)

# Parse dates with fast_strptime
fast_strptime(dates, 
              format = "%Y-%m-%dT%H:%M:%SZ") %>% str()

# Comparse speed to ymd_hms() and fasttime
microbenchmark(
  ymd_hms = ymd_hms(dates),
  fasttime = fastPOSIXct(dates),
  fast_strptime = fast_strptime(dates, 
                                format = "%Y-%m-%dT%H:%M:%SZ"),
  times = 20)

# Create a stamp based on "Sep 20 2017"
date_stamp <- stamp("Sep 20 2017")

# Print date_stamp
date_stamp

now()

# Call date_stamp on today
date_stamp(today())

# Create and call a stamp based on "09/20/2017"
stamp("09/20/2017")(today())

# Use string finished for stamp()
stamp(finished)(today())
