# README

This is a demo Rails app for displaying weather data for a given address. It geocodes the address using the Geocoder gem, backed by Nominatim. It pulls latitude, longitude, and postcode from that data. It uses the postcode as a cache key, and calls out to OpenWeather to get the data, using latitude and longitude. (Postcode is deprecated by OpenWeather.)

For this to work, it relies on two environment variables - EMAIL_ADDRESS, for calling out to Nominatim, and OPEN_WEATHER_API_KEY for calling out to OpenWeather.

https://openweathermap.org/ has free accounts, it is generally bad practice to put API keys into repos. I didn't redact my email from the cassettes because I'm easy enough to find on the web. This is my repo, after all.

Specs are primarily around the service class.
