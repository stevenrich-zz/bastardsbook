require "rubygems"
require "crack"

tweet_basename = "USATODAY-tweets-page-"
first_page = 1
last_page = 10

total_tweet_count = 0
earliest_tweet = 0
most_recent_tweet = 0

(first_page..last_page).each do |pg_num|
   tweet_filename = tweet_basename + pg_num.to_s + ".xml"
  tweets_file = File.open(tweet_filename)
  parsed_xml = Crack::XML.parse( tweets_file.read )
  tweets = parsed_xml["statuses"]
  total_tweet_count = total_tweet_count + tweets.length

  if pg_num == first_page
    most_recent_tweet = tweets.first
  end

  if pg_num == last_page
    earliest_tweet = tweets.last
  end

end

puts "Total tweets collected: " + total_tweet_count.to_s

most_recent_time = Time.parse(most_recent_tweet['created_at'])
earliest_time  = Time.parse(earliest_tweet['created_at'])

puts "most recent time: " + most_recent_time.to_s
puts "earliest time: " + earliest_time.to_s

tweets_per_second = total_tweet_count / (most_recent_time - earliest_time) 
tweets_per_day = tweets_per_second * 60 * 60 * 24
puts "Tweets per day: " + tweets_per_day.to_s