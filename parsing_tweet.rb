require 'json'
require 'yaml'

def print_tweet(tweet)
  #puts tweet.to_yaml
  #puts JSON.pretty_generate(tweet)
  "TEXT = #{tweet['text']} / AUTHOR = #{tweet['user']['name']}"
end

def parse_tweet_response(response)
  tweet = nil
  if response.code == '200' then
    tweet = JSON.parse(response.body)
    print_tweet( tweet )
  end
end

# Now you will fetch /1.1/statuses/show.json, which
# takes an 'id' parameter and returns the
# representation of a single Tweet.

base_url    = "/1.1/statuses/show.json"
query   = URI.encode_www_form("id" => "266270116780576768")
path = "#{base_url}?#{query}"
puts "URL pour taper l'api == #{path}"

twitter = Twitter.new
response = twitter.get_json_from( path )
parse_tweet_response( response )



