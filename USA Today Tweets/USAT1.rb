require "rubygems"
require "crack"

tweet_filename = "BicBuck-tweets.xml"
tweets_file = File.open(tweet_filename)
parsed_xml = Crack::XML.parse( tweets_file.read )
tweets_file.close


tweets = parsed_xml["statuses"]

first_tweet = tweets[0]
user = first_tweet["user"]

puts user["screen_name"]
puts user["name"]
puts user["created_at"]
puts user["statuses_count"]

puts first_tweet["created_at"]
puts first_tweet["text"]