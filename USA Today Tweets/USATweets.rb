require "open-uri"

remote_base_url = "http://api.twitter.com/1/statuses/user_timeline.xml?count=100&screen_name="
twitter_user = "USATODAY"
remote_full_url = remote_base_url + twitter_user

tweets = open(remote_full_url).read

my_local_filename = twitter_user + "-tweets.xml"
my_local_file = open(my_local_filename, "w")
    my_local_file.write(tweets)    
my_local_file.close