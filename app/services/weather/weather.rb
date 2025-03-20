module Weather
  class Weather
    attr_accessor :api_key

    def initialize(api_key)
      @api_key = api_key
    end

    def geocode(address)
      results = Geocoder.search(address)

      location = results.first.coordinates
      location << results.first.data["address"]["postcode"]
    end

    def by_address(address)
      lat, long, zip = geocode(address)
      by_geo(lat, long, zip)
    end

    def by_geo(lat, long, zip)
      url = "https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{long}&appId=#{@api_key}&units=imperial"

      response = Faraday.get(url)

      MultiJson.load(response.body, symbolize_keys: true)
    end
  end
end
