require "openid_connect"
require "sinatra"

config = OpenIDConnect::Discovery::Provider::Config.discover! "https://did.app"

client = OpenIDConnect::Client.new({
  identifier: ENV["CLIENT_ID"],
  secret: ENV["CLIENT_SECRET"],
  redirect_uri: "http://localhost:3000/callback",
  issuer: config.issuer,
  authorization_endpoint: config.authorization_endpoint,
  jwks_uri: config.jwks_uri,
  token_endpoint: config.token_endpoint,
})

get "/" do
  <<-PAGE
  <a href="/authenticate">sign in</a>
  PAGE
end

get "/authenticate" do
  redirect client.authorization_uri()
end

get "/callback" do
  code = params["code"]
  client.authorization_code = code
  tokens = client.access_token!

  id_token = OpenIDConnect::ResponseObject::IdToken.decode tokens.id_token, config.jwks
  id_token.verify!(issuer: config.issuer, client_id: client.identifier)
  id_token.subject
end
