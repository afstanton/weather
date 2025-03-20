##
# WeatherController
# This controller handles the weather information retrieval
# and display for the application.
class WeatherController < ApplicationController
  #
  # GET /
  def show
  end

  #
  # POST /
  def new
    w = Weather::Weather.new(ENV["OPEN_WEATHER_API_KEY"])
    begin
      @weather = w.by_address(params["address"])
    rescue StandardError => e
      @errors = e
    end
  end
end
