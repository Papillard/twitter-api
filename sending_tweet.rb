# You will need to set your application type to
# read/write on dev.twitter.com and regenerate your access
# token in TwitterGetter class
require 'json'

def parse_tweet_response( response )
  # Parse and print the Tweet if the response code was 200
  tweet = nil
  if response.code == '200' then
    tweet = JSON.parse(response.body)
    puts "Successfully sent #{tweet["text"]}"
  else
    puts "Could not send the Tweet! " + "Code:#{response.code} Body:#{response.body}"
  end
end

path = "/1.1/statuses/update.json"
text = ""
puts "URL pour taper l'api == #{path} | Tweet à poster == #{text}"

twitter = Twitter.new
response = twitter.post_json_from( path , text )
parse_tweet_response( response )

