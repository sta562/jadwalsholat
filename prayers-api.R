# Set library ----
library(jsonlite)
library(RPostgreSQL)

# List of shalat sites
# https://www.islamicfinder.org/world/indonesia/
# https://aladhan.com/prayer-times-api

city <- URLencode("Aceh")
country <- URLencode("Indonesia")
method <- 8

url <- paste0("http://api.aladhan.com/v1/timingsByCity?city=", city, "&country=", country, "&method=", method)
get_timings <- fromJSON(url)

# connect to database
con <- dbConnect(
  dbDriver("PostgreSQL"),
  dbname = Sys.getenv("ELEPHANT_SQL_DBNAME"),
  host = Sys.getenv("ELEPHANT_SQL_HOST"),
  port = 5432,
  user = Sys.getenv("ELEPHANT_SQL_USER"),
  password = Sys.getenv("ELEPHANT_SQL_PASSWORD")
)

# check table if exists
if(!dbExistsTable(con, "prayer")) {
  prayer <- data.frame(no=integer(), date=character(), city=character(), lat=character(), lng=character(),
                       fajr=character(), dhuhr=character(), asr=character(), maghrib= character(), isha=character())
  dbCreateTable(con, "prayer", prayer)
} 

# read table
prayer <- dbReadTable(con, "prayer")
rows <- nrow(prayer)

# new input
date <- get_timings$data$date$gregorian$date
lat <- get_timings$data$meta$latitude
lng <- get_timings$data$meta$longitude
fajr <- get_timings$data$timings$Fajr
dhuhr <- get_timings$data$timings$Dhuhr
asr <- get_timings$data$timings$Asr
maghrib <- get_timings$data$timings$Maghrib
isha <- get_timings$data$timings$Isha
newprayer <- data.frame(no = rows + 1, date=date, city=city, lat=lat, long=lng,
                        fajr=fajr, dhuhr=dhuhr, asr=asr, maghrib=maghrib, isha=isha)
dbWriteTable(con = con, name = "prayer", value = newprayer, append = TRUE, row.names = FALSE, overwrite=FALSE)

on.exit(dbDisconnect(con)) 


