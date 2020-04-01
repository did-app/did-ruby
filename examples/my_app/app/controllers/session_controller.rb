require 'faraday'
require 'json'

class SessionController < ApplicationController
  def callback
    response = Faraday.post(
      "https://auth.did.app/oidc/token",
      client_id: ENV["CLIENT_ID"],
      client_secret: ENV["CLIENT_SECRET"],
      code: params["code"]
    )
    data = JSON.parse(response.body)

    session[:current_user_id] = data["userinfo"]["sub"]
    redirect_to root_path
  end

  def terminate
    reset_session
    redirect_to root_path
  end
end
