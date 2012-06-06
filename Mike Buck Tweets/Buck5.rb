require 'rubygems'
require 'crack'

tweet_basename = "BicBuck-tweets-page-"
first_page = 1
last_page = 5

total_tweet_count = 0
total_chars_in_tweets = 0
word_list = {}

(first_page..last_page).each do |pg_num|
   tweet_filename = tweet_basename + pg_num.to_s + ".xml"
  tweets_file = File.open(tweet_filename)
  parsed_xml = Crack::XML.parse( tweets_file.read )
  tweets = parsed_xml["statuses"]
  puts "On page: " + pg_num.to_s

  # A running total of tweets
  total_tweet_count += tweets.length 
  
  tweets.each do |tweet|
    # The tweet text, in lowercase letters
    txt = tweet['text'].downcase
    
    # A running total of total tweet length in characters
    total_chars_in_tweets += txt.length
    
    # Regular expression to select any string of consecutive
    # alphabetical letters (with optional apostrophes and hypens)
    # that are surrounded by whitespace or end with a punctuation mark 
    words = txt.scan(/(?:^|\s)([a-z'\-]+)(?:$|\s|[.!,?:])/).flatten.select{|w| w.length > 1}

    # Use of the word_list Hash to keep list of different words
    words.each do |word|
      word_list[word] ||= 0
      word_list[word] += 1
    end

  end
end

puts "\nTotal tweets:"
puts total_tweet_count

puts "\nTotal characters used:"
puts total_chars_in_tweets

puts "\nAverage tweet length in chars:"  
puts(total_chars_in_tweets/total_tweet_count)

puts "\nNumber of different words:"
puts word_list.length

puts "\nNumber of total words used:"
puts word_list.inject(0){|sum, w| sum += w[1]}

# sort word_list by frequency of word, descending order
word_list = word_list.sort_by{|w| w[1]}.reverse

puts "\nTop 20 most frequent words"
word_list[0..19].each do |w|
  puts "#{w[0]}:\t#{w[1]}"
end

puts "\nTop 20 most frequent words more than 4 characters long"
word_list.select{|w| w[0].length > 4}[0..19].each do |w|
  puts "#{w[0]}:\t#{w[1]}"
end


puts "\nLongest word:"
puts word_list.max_by{|w| w[0].length}[0]