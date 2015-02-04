require 'httparty'

class Neighborhood
  attr_accessor :location, :recommended_venues, :venue_ids, :venues_for_search, :venues_by_group, :api_response
  
  ##!!!NEEDS TO BE FILLED OUT WITH CLIENT ID AND SECRET PROVIDED BY FOURSQUARE
  # CLIENT_ID = ""
  # CLIENT_SECRET = ""
  CLIENT_ID = "JUUFHYCI1ZWKTMHF5GEG1ZODCTREEO0TJRCC02UPOYCYJIGB"
  CLIENT_SECRET = "GYUAW432FZ1UJ4PX4TM3IGSYNO2QAHMNAV4OR2DUKCHMJULJ"

  def initialize(location)
    @location = location
    @recommended_venues = []
    @venue_ids = []
    @venues_for_search = []
    @venues_by_group = []
  end

  # This user the Foursquare explore endpoint to pull recommended food venues for a location
  def get_recommended_venues
    uri = "https://api.foursquare.com/v2/venues/explore?near=#{@location}&client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&v=#{Time.now.strftime("%Y%m%d")}&categoryId=4d4b7105d754a06374d81259"
    encoded = URI.parse(URI.encode(uri)) # to handle spaces in the location
    @api_response = HTTParty.get(encoded)
    @api_response['response']['groups'][0]["items"].each do |item|
      @recommended_venues << item["venue"]["name"]
    end
    # puts encoded # uncomment this to see the uri that is being used in the HTTP get request
    @recommended_venues
  end

  # Example groups to search by include ["outdoor seating","credit cards","price","reservations","dining options","street parking","wheelchair accessible" ]
  def filter_by_group(group)
    self.get_venues_for_search
    @venues_for_search.each do |venue|
      venue['attributes']['groups'].each do |groups|
        if groups["name"].downcase == group.downcase
          groups["items"].each do |item|
            if item["displayValue"].split(" ").first != "No"
              @venues_by_group << venue["name"]
            end
          end
        end
      end  
    end
    @venues_by_group
  end

  # Recommended venue list doesn't have necessary info to search by group - we need to get venue ids and make an API call for each venue. 
  def get_venue_ids
    @recommended_venues.each do |venue| 
      @venue_ids << venue["id"] 
    end
    @venue_ids
  end

  def get_venues_for_search
    self.get_venue_ids
    @venue_ids.each do |id|
      uri = "https://api.foursquare.com/v2/venues/#{id}?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&v=#{Time.now.strftime("%Y%m%d")}&m=foursquare"
      api_response = HTTParty.get(uri)
      puts uri # So we can see the uri that is being used in the HTTP GET request
      @venues_for_search << api_response['response']['venue']
    end
    @venues_for_search
  end

end