require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'faraday'
require "base64"
require './kno.rb'


set :session_secret, "afjnadlc72364523"
enable :sessions

use Kno::Session,
  sign_in_redirect: "/"

get '/' do
  erb :index
end
