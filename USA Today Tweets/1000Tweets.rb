require "open-uri"

remote_base_url = "http://api.twitter.com/1/statuses/user_timeline.xml?count=100&screen_name="
twitter_user = "USATODAY"
remote_full_url = remote_base_url + twitter_user
first_page = 1
last_page = 10


(first_page..last_page).each do |page_num|
    
   puts "Downloading page: " + page_num.to_s
   tweets = open(remote_base_url + twitter_user + "&page=" + page_num.to_s).read

   my_local_filename = twitter_user + "-tweets-page-" + page_num.to_s + ".xml"
   my_local_file = open(my_local_filename, "w")
       my_local_file.write(tweets)    
   my_local_file.close
   
   sleep 5

end