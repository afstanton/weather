require 'rails_helper'

RSpec.describe Weather::Weather do
  let(:address) { '1 Monument Circle, Indianapolis, IN 46204' }
  let(:lat) { 39.768505950000005 }
  let(:long) { -86.1580444334403 }
  let(:zip) { '46204' }
  let(:weather) do
{ coord: { lon: -86.158, lat: 39.7685 },
 weather:
  [ { id: 803,
    main: "Clouds",
    description: "broken clouds",
    icon: "04n" } ],
 base: "stations",
 main:
  { temp: 59.77,
   feels_like: 59.07,
   temp_min: 57.22,
   temp_max: 62.29,
   pressure: 997,
   humidity: 77,
   sea_level: 997,
   grnd_level: 970 },
 visibility: 10000,
 wind: { speed: 14.97, deg: 210, gust: 26.46 },
 clouds: { all: 75 },
 dt: 1742435343,
 sys:
  { type: 2,
   id: 2002558,
   country: "US",
   sunrise: 1742384957,
   sunset: 1742428520 },
 timezone: -14400,
 id: 4259418,
 name: "Indianapolis",
 cod: 200 }
  end
  let(:expected) do
  {
    cached: false,
    data: weather
  }
  end
  describe '#geocode' do
    it 'correctly geocodes Indianapolis' do
      VCR.use_cassette('geocode') do
        w = described_class.new('XXXXXX')

        location = w.geocode(address)
        expect(location).to eq([ lat, long, zip ])
      end
    end
  end

  describe '#by_address' do
    it 'gets the weather for Indianapolis' do
      VCR.use_cassette('weather') do
        w = described_class.new('XXXXXX')

        result = w.by_address(address)
        expect(result).to match(expected)
      end
    end
  end

  describe '#by_geo' do
    it 'gets the weather for Indianapolis' do
      VCR.use_cassette('weather') do
        w = described_class.new('XXXXXX')

        result = w.by_geo(lat, long, zip)
        expect(result).to match(expected)
      end
    end
  end
end
