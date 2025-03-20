module Weather
  ##
  # Weather service to get weather data from OpenWeatherMap API
  class Weather
    attr_accessor :api_key

    ##
    # Initialize the Weather service with
    # the OpenWeatherMap API key
    #
    # @param api_key [String] OpenWeatherMap API key
    # @return Weather service instance
    def initialize(api_key)
      @api_key = api_key
    end

    ##
    # Geocode the address using Geocoder gem
    #
    # @param address [String] Address to geocode
    # @return [Array] Array of latitude, longitude, and zip code
    def geocode(address)
      results = Geocoder.search(address)

      location = results.first.coordinates
      location << results.first.data["address"]["postcode"]
    end

    ##
    # Get weather data by address
    #
    # @param address [String] Address to get weather for
    # @return [Hash] Weather data
    def by_address(address)
      lat, long, zip = geocode(address)
      by_geo(lat, long, zip)
    end

    ##
    # Get weather data by latitude and longitude, uses zip code as cache key
    #
    # @param lat [Float] Latitude
    # @param long [Float] Longitude
    # @param zip [String] Zip code
    # @return [Hash] Weather data plus cache status
    def by_geo(lat, long, zip)
      url = "https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{long}&appId=#{@api_key}&units=imperial"

      response = Rails.cache.read(zip)
      if response.present?
        cached = true
      else
        cached = false
        response = Faraday.get(url)
        Rails.cache.write(zip, response, expires_in: 30.minutes)
      end

      data = MultiJson.load(response.body, symbolize_keys: true)
      { cached: cached, data: data }
    end
  end
end
