# Twitter user's info JSON parser method
# to use with a response given by TwitterGetter object
# => twitter = TwitterGetter.new
# => response = twitter.get_json_from("/1.1/account/verify_credentials.json")
# => puts parse_user_response( response )

require 'json'

def parse_user_response(response)
  user = nil

  # Check for a successful request
  if response.code == '200'
    # Parse the response body, which is in JSON format.
    # ADD CODE TO PARSE THE RESPONSE BODY HERE
    user = JSON.parse( response.body )

    # Pretty-print the user object to see what data is available.
    puts "Hello, #{user["screen_name"]}!"
  else
    # There was an error issuing the request.
    puts "Expected a response of 200 but got #{response.code} instead"
  end
  user
end


