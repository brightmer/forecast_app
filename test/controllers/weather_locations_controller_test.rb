require "test_helper"

class WeatherLocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @weather_location = weather_locations(:one)
  end

  test "should get index" do
    get weather_locations_url
    assert_response :success
  end

  test "should get new" do
    get new_weather_location_url
    assert_response :success
  end

  test "should create weather_location" do
    VCR.use_cassette("should_create_weather_location") do
      VCR.use_cassette("should_create_weather_location_forecast") do
        assert_difference("WeatherLocation.count") do
          post weather_locations_url, params: { weather_location: { address: @weather_location.address, current_temperature: @weather_location.current_temperature, date_checked: @weather_location.date_checked, high_temperature: @weather_location.high_temperature, latitude: @weather_location.latitude, longitude: @weather_location.longitude, low_temperature: @weather_location.low_temperature, postal_code: @weather_location.postal_code, units: @weather_location.units, weather_description: @weather_location.weather_description } }
        end
      end
      assert_redirected_to weather_location_url(WeatherLocation.last)
    end
  end

  test "should show weather_location" do
    get weather_location_url(@weather_location)
    assert_response :success
  end

  test "should get edit" do
    VCR.use_cassette("should_get_edit") do
      get edit_weather_location_url(@weather_location)
      assert_response :success
    end
  end

  test "should update weather_location" do
    VCR.use_cassette("should_update_weather_location") do
      VCR.use_cassette("should_update_weather_location_forecast") do
        patch weather_location_url(@weather_location), params: { weather_location: { address: @weather_location.address, current_temperature: @weather_location.current_temperature, date_checked: @weather_location.date_checked, high_temperature: @weather_location.high_temperature, latitude: @weather_location.latitude, longitude: @weather_location.longitude, low_temperature: @weather_location.low_temperature, postal_code: @weather_location.postal_code, units: @weather_location.units, weather_description: @weather_location.weather_description } }
        assert_redirected_to weather_location_url(@weather_location)
        end
      end
  end

  test "should destroy weather_location" do
    VCR.use_cassette("should_destroy_weather_location") do
      VCR.use_cassette("should_destroy_weather_location_forecast") do
        assert_difference("WeatherLocation.count", -1) do
          delete weather_location_url(@weather_location)
        end
      end


      assert_redirected_to weather_locations_url
    end
  end
end
