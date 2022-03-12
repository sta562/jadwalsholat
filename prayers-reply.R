message("Load the libraries")
library(RPostgreSQL)
library(rtweet)

token <- create_token(
  app = "sholatBot",
  consumer_key =    Sys.getenv("TWITTER_CONSUMER_API_KEY"),
  consumer_secret = Sys.getenv("TWITTER_CONSUMER_API_SECRET"),
  access_token =    Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret =   Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
)

mention_list <- get_mentions("alfabot562")
mention_who <- mention_list$status_id
mention_info <- lookup_statuses(mention_who)

## not finished yet
status_details <- paste0(
  "🕌 Pukul ", all_time[names(hourdiff)], ", waktunya ",  names(hourdiff), " untuk ", tweetprayer$city, " dan sekitarnya\n",
  "\n\n",
  paste0("#", samp_word, collapse = " "))

message("Post the status to twitter")
## Post the image to Twitter
post_tweet(
  status = status_details,
  token = token
)