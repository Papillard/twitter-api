# Get json from http request to twitter API
# Need to run gem install oauth first
# => twitter = Twitter.new
# => response = twitter.get_json_from("/1.1/account/verify_credentials.json")
# => puts response.code
# => post = twitter.post_json_from("/1.1/statuses/user_timeline.json", "my first tweet through the API")

class Twitter
  require 'rubygems'
  require 'oauth'
  
  
  CONSUMER_KEY = OAuth::Consumer.new(
    ENV["TWITTER_CONSUMMER"],
    ENV["TWITTER_CONSUMMER_SECRET"]) # The consumer = application
    
  ACCESS_TOKEN = OAuth::Token.new(
    ENV["TWITTER_ACCESS_TOKEN"],
    ENV["TWITTER_ACCESS_TOKEN_SECRET"]) # The access token = user

  # All requests will be sent to this server.
  BASE_URL = "https://api.twitter.com"
  
  def set_http( address )
    # Set up HTTP.
    http             = Net::HTTP.new address.host, address.port
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    http
  end
  

  def get_json_from( path )    
    # Set up url & request
    address = URI("#{BASE_URL}#{path}")  
    request = Net::HTTP::Get.new address.request_uri
    
    # Set up Net::HTTP to use SSL, which is required by Twitter.
    http = set_http( address )

    # Issue the request and return the response.
    request.oauth! http, CONSUMER_KEY, ACCESS_TOKEN
    http.start
    response = http.request( request )
  end
  
  
  def post_json_from( path , text = "" )
    # Set up url & request
    # POST request / params in the body (not in the URL)
    address = URI("#{BASE_URL}#{path}")
    request = Net::HTTP::Post.new address.request_uri 
    request.set_form_data(
      "status" => text,
    )

    # Set up http
    set_http( address )

    # Issue the request.
    request.oauth! http, CONSUMER_KEY, ACCESS_TOKEN
    http.start
    response = http.request request
  end
  
end