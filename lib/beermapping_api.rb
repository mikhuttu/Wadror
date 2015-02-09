class BeermappingApi
  
  def self.places_in(city)
    return [] if city.empty?

    city = city.downcase
    Rails.cache.fetch(city, expires_in: 24.hours) { fetch_places_in(city) } 
  end


  def self.fetch_places_in(city)
    # project api_key: 1bdb0043c23b41e3c90c6173ca61fe31
    url = "http://stark-oasis-9187.herokuapp.com/api/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"

    places = response.parsed_response["bmp_locations"]["location"]
    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end

  end
end
