require 'rubygems'
require 'sinatra'
require_relative 'models/tweet.rb'

get '/tweets' do
  @tweets = Tweet.all
  erb :tweets
end

post '/tweets' do
  redirect '/tweets'
end