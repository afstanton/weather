require 'rails_helper'

RSpec.describe Weather::Weather do
  let(:zip) { '46254' }
  let(:country) { 'US' }
  let(:lat) { 39.844490941565624 }
  let(:long) { -86.26006614041904 }
  let(:weather) do
{ coord: { lon: -86.2601, lat: 39.8445 },
 weather:
  [ { id: 803,
    main: "Clouds",
    description: "broken clouds",
    icon: "04n" } ],
 base: "stations",
 main:
  { temp: 59.88,
   feels_like: 59.47,
   temp_min: 57.09,
   temp_max: 62.98,
   pressure: 997,
   humidity: 83,
   sea_level: 997,
   grnd_level: 967 },
 visibility: 10000,
 wind: { speed: 14.97, deg: 180, gust: 24.16 },
 clouds: { all: 75 },
 dt: 1742432189,
 sys:
  { type: 2,
   id: 2002558,
   country: "US",
   sunrise: 1742384981,
   sunset: 1742428544 },
 timezone: -14400,
 id: 4265146,
 name: "Speedway",
 cod: 200 }
  end
  describe '#geocode' do
    it 'correctly geocodes Indianapolis' do
      VCR.use_cassette('geocode') do
        w = described_class.new('XXXXXX')

        location = w.geocode(zip, country)
        expect(location).to eq([ lat, long ])
      end
    end
  end

  describe '#by_zip' do
    it 'gets the weather for Indianapolis' do
      VCR.use_cassette('weather') do
        w = described_class.new('XXXXXX')

        result = w.by_zip(zip, country)
        expect(result).to match(weather)
      end
    end
  end

  describe '#by_geo' do
    it 'gets the weather for Indianapolis' do
      VCR.use_cassette('weather') do
        w = described_class.new('XXXXXX')

        result = w.by_geo(lat, long)
        expect(result).to match(weather)
      end
    end
  end
end
