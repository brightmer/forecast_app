require "test_helper"

class OpenWeatherApiTests  < ActiveSupport::TestCase
  test 'do nothing if location is nil' do
    assert_no_difference 'WeatherLocation.count' do
      assert_no_difference 'Forecast.count' do
        OpenWeatherApi.fetch_weather!(nil)
        OpenWeatherApi.fetch_weather!(nil)
      end
    end
  end

  test 'do nothing if location has forecasts already' do
    weather = VCR.use_cassette("geocoded_white_house") do
      WeatherLocation.create(address: '1600 Pennsylvania Avenue NW, Washington, DC 20500')
    end
    Forecast.create(weather_location: weather)

    assert_no_difference 'WeatherLocation.count' do
      assert_no_difference 'Forecast.count' do
        OpenWeatherApi.fetch_weather!(weather)
        OpenWeatherApi.fetch_weather!(weather)
      end
    end
  end

  test 'do nothing if location geocoding failed to set long' do
    weather = VCR.use_cassette("geocoded_white_house") do
      WeatherLocation.create(address: '1600 Pennsylvania Avenue NW, Washington, DC 20500')
    end
    weather.latitude = nil

    assert_no_difference 'WeatherLocation.count' do
      assert_no_difference 'Forecast.count' do
        OpenWeatherApi.fetch_weather!(weather)
        OpenWeatherApi.fetch_weather!(weather)
      end
    end
  end

  test 'do nothing if location geocoding failed to set lat' do
    weather = VCR.use_cassette("geocoded_white_house") do
      WeatherLocation.create(address: '1600 Pennsylvania Avenue NW, Washington, DC 20500')
    end
    weather.latitude = nil

    assert_no_difference 'WeatherLocation.count' do
      assert_no_difference 'Forecast.count' do
        OpenWeatherApi.fetch_weather!(weather)
        OpenWeatherApi.fetch_weather!(weather)
      end
    end
  end

  test 'do nothing if location geocoding failed to set lat and long' do
    weather = VCR.use_cassette("geocoded_white_house") do
      WeatherLocation.create(address: '1600 Pennsylvania Avenue NW, Washington, DC 20500')
    end
    weather.longitude = nil
    weather.latitude = nil

    assert_no_difference 'WeatherLocation.count' do
      assert_no_difference 'Forecast.count' do
        OpenWeatherApi.fetch_weather!(weather)
        OpenWeatherApi.fetch_weather!(weather)
      end
    end
  end

  test 'do the stuff' do
    weather = assert_difference 'WeatherLocation.count', 1 do
      VCR.use_cassette("geocoded_white_house") do
      WeatherLocation.create(address: '1600 Pennsylvania Avenue NW, Washington, DC 20500')
      end
    end
    assert_no_difference 'WeatherLocation.count' do
      VCR.use_cassette("geocoded_white_house_forecast") do
        OpenWeatherApi.fetch_weather!(weather)
        assert_difference 'Forecast.count', 40 do
          OpenWeatherApi.fetch_weather!(weather)
        end
      end
    end
  end

end