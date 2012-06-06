require "rubygems"
require "crack"

tweet_basename = "BicBuck-tweets-page-"
first_page = 1
last_page = 5

tweeters_replied_to = []

(first_page..last_page).each do |pg_num|
   tweet_filename = tweet_basename + pg_num.to_s + ".xml"
  tweets_file = File.open(tweet_filename)
  parsed_xml = Crack::XML.parse( tweets_file.read )
  tweets = parsed_xml["statuses"]
  puts "On page: " + pg_num.to_s

  tweets.each do |tweet|
    nm = tweet['in_reply_to_screen_name']
    if nm.nil?
      # do nothing, the field is empty
    else  
      tweeters_replied_to.push(nm)
    end
  end
end

unique_tweeters_replied_to = tweeters_replied_to.uniq
puts "There were replies to " + tweeters_replied_to.length.to_s + " Tweeters"
puts "The number of unique names is: " + unique_tweeters_replied_to.length.to_s
puts "--"
puts unique_tweeters_replied_to