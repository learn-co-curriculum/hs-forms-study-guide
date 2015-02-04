require 'rubygems'
require 'sinatra'
require './models/foursquare.rb'

class App < Sinatra::Base

  get '/' do
    erb :index
  end

  post '/results' do
    # params.inspect
    hood = Neighborhood.new(params[:location])
    hood.get_recommended_venues
    @restaurants = hood.recommended_venues
    erb :results
  end

end