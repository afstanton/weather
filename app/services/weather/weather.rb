module Weather
  class Weather
    attr_accessor :api_key

    def initialize(api_key)
      @api_key = api_key
    end

    def geocode(zip, country)
      location = "#{zip}, #{country}"
      results = Geocoder.search(location)

      results.first.coordinates
    end

    def by_zip(zip, country)
      lat, long = geocode(zip, country)
      by_geo(lat, long)
    end

    def by_geo(lat, long)
      url = "https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{long}&appId=#{@api_key}&units=imperial"

      response = Faraday.get(url)

      MultiJson.load(response.body, symbolize_keys: true)
    end
  end
end
