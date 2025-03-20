require 'rails_helper'

RSpec.describe Weather::Weather do
  let(:zip) { '46254' }
  let(:country) { 'US' }
  let(:lat) { 39.844490941565624 }
  let(:long) { -86.26006614041904 }
  let(:weather) do
    { coord: { lon: -86.2601, lat: 39.8445 },
 weather:
  [ { id: 500, main: "Rain", description: "light rain", icon: "10n" } ],
 base: "stations",
 main:
  { temp: 290.33,
   feels_like: 289.96,
   temp_min: 289.31,
   temp_max: 291.34,
   pressure: 997,
   humidity: 71,
   sea_level: 997,
   grnd_level: 968 },
 visibility: 10000,
 wind: { speed: 6.69, deg: 180, gust: 10.8 },
 rain: { "1h": 0.41 },
 clouds: { all: 100 },
 dt: 1742429778,
 sys:
  { type: 1, id: 4037, country: "US", sunrise: 1742384981, sunset: 1742428544 },
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
