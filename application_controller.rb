require 'rubygems'
require 'sinatra'
require_relative 'models/tweet.rb'

class App < Sinatra::Base

  get '/tweets' do
    @tweets = Tweet.all
    erb :tweets
  end

  post '/tweets' do
    params.inspect
    # Tweet.new(params[:username],params[:status])
    # redirect '/tweets'
  end

end