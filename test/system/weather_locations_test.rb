require "application_system_test_case"

class WeatherLocationsTest < ApplicationSystemTestCase
  setup do
    @weather_location = weather_locations(:one)
  end

  test "visiting the index" do
    visit weather_locations_url
    assert_selector "h1", text: "Weather locations"
  end

  test "should create weather location" do
    visit weather_locations_url
    click_on "New weather location"

    fill_in "Address", with: @weather_location.address
    fill_in "Current temperature", with: @weather_location.current_temperature
    fill_in "Date checked", with: @weather_location.date_checked
    fill_in "High temperature", with: @weather_location.high_temperature
    fill_in "Latitude", with: @weather_location.latitude
    fill_in "Longitude", with: @weather_location.longitude
    fill_in "Low temperature", with: @weather_location.low_temperature
    fill_in "Postal code", with: @weather_location.postal_code
    fill_in "Units", with: @weather_location.units
    fill_in "Weather description", with: @weather_location.weather_description
    click_on "Create Weather location"

    assert_text "Weather location was successfully created"
    click_on "Back"
  end

  test "should update Weather location" do
    visit weather_location_url(@weather_location)
    click_on "Edit this weather location", match: :first

    fill_in "Address", with: @weather_location.address
    fill_in "Current temperature", with: @weather_location.current_temperature
    fill_in "Date checked", with: @weather_location.date_checked
    fill_in "High temperature", with: @weather_location.high_temperature
    fill_in "Latitude", with: @weather_location.latitude
    fill_in "Longitude", with: @weather_location.longitude
    fill_in "Low temperature", with: @weather_location.low_temperature
    fill_in "Postal code", with: @weather_location.postal_code
    fill_in "Units", with: @weather_location.units
    fill_in "Weather description", with: @weather_location.weather_description
    click_on "Update Weather location"

    assert_text "Weather location was successfully updated"
    click_on "Back"
  end

  test "should destroy Weather location" do
    visit weather_location_url(@weather_location)
    click_on "Destroy this weather location", match: :first

    assert_text "Weather location was successfully destroyed"
  end
end
