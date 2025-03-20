class WeatherController < ApplicationController
  def show
  end

  def new
    w = Weather::Weather.new(ENV['OPEN_WEATHER_API_KEY'])
    begin
      @weather = w.by_address(params['address'])
    rescue StandardError => e
      @errors = e
    end
  end
end
