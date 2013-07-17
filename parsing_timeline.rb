require 'json'

def print_timeline(tweets)
  tweets.each do |tweet|
    puts tweet['text']
  end
end

def parse_tweet_response(response)
  tweets = nil
  if response.code == '200' then
    tweets = JSON.parse(response.body)
    print_timeline(tweets)
  end
end

# Now you will fetch /1.1/statuses/user_timeline.json,
# returns a list of public Tweets from the specified
# account.

base_url    = "/1.1/statuses/user_timeline.json"
query   = URI.encode_www_form(
    "screen_name" => "Lewagonparis",
    "count" => 5,
)
path = "#{path}?#{query}"

puts "URL pour taper l'api == #{path}"
twitter = Twitter.new
response = twitter.get_json_from( path )
parse_tweet_response( response )


