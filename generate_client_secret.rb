# Source: https://developer.okta.com/blog/2019/06/04/what-the-heck-is-sign-in-with-apple
require 'jwt'
# Update these values with your app's information
team_id = '96C79E7E69'
client_id = 'org.wedinvyte.ishqServiceId'
key_id = 'V3Y5AC8WL3'
key_file = 'AuthKey_V3Y5AC8WL3.p8'
# Define the JWT's headers and claims
headers = {
  # The token must be signed with your key
  'kid' => key_id
}
claims = {
  # The token is issued by your Apple team
  'iss' => team_id,
  # The token applies to Apple ID authentication
  'aud' => 'https://appleid.apple.com',
  # The token is scoped to your application
  'sub' => client_id,
  # The token is valid immediately
  'iat' => Time.now.to_i,
  # The token expires in 6 months (maximum allowed)
  'exp' => Time.now.to_i + 86400*180,
}
# Read in the key and generate the JWT
ecdsa_key = OpenSSL::PKey::EC.new IO.read key_file
token = JWT.encode claims, ecdsa_key, 'ES256', headers
# Print the JWT to stdout
puts token
