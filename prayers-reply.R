message("Load the libraries")
library(RPostgreSQL)
library(rtweet)

message("Set timezone")
Sys.setenv(TZ = "Asia/Bangkok")

message("Connect to ElephantSQL database server")
con <- dbConnect(
  dbDriver("PostgreSQL"),
  dbname = Sys.getenv("ELEPHANT_SQL_DBNAME"),
  host = Sys.getenv("ELEPHANT_SQL_HOST"),
  port = 5432,
  user = Sys.getenv("ELEPHANT_SQL_USER"),
  password = Sys.getenv("ELEPHANT_SQL_PASSWORD")
)

message("Retrieve the information from table `public`.`prayer`")
prayer <- dbReadTable(con, "prayer")

today <- format(Sys.time(), "%d-%m-%Y")
tweetprayer <- prayer[which(today==prayer$date),]

token <- create_token(
  app = "Sholat-Bot",
  consumer_key =    Sys.getenv("TWITTER_CONSUMER_API_KEY"),
  consumer_secret = Sys.getenv("TWITTER_CONSUMER_API_SECRET"),
  access_token =    Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret =   Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
)

mention_list <- get_mentions("SholatBot")
mention_who <- mention_list$status_id
mention_info <- lookup_statuses(mention_who)

## not finished yet
status_details <- paste0("@", mention_info$screen_name, "\n",
  "🕌 Waktu sholat untuk ", tweetprayer$city, " dan sekitarnya\n",
  "Imsak", " ", tweetprayer['imsak'], "\n",
  "Subuh", " ", tweetprayer['fajr'], "\n",
  "Dhuhr", " ", tweetprayer['dhuhr'], "\n",
  "Asr", " ", tweetprayer['asr'], "\n",
  "Maghrib", " ", tweetprayer['maghrib'], "\n",
  "Isha", " ", tweetprayer['isha'], "\n",
  "\n")

message("Post the status to twitter")
## Post the image to Twitter
post_tweet(
  status = status_details,
  token = token
)

