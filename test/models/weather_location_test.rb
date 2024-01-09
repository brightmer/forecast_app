# == Schema Information
#
# Table name: weather_locations
#
#  id                  :bigint           not null, primary key
#  address             :text(65535)
#  current_temperature :float(24)
#  date_checked        :datetime
#  high_temperature    :float(24)
#  latitude            :float(24)
#  longitude           :float(24)
#  low_temperature     :float(24)
#  postal_code         :string(255)
#  units               :string(255)
#  weather_description :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require "test_helper"

class WeatherLocationTest < ActiveSupport::TestCase
  def test_save_with_valid_address_geocodes_data
    VCR.use_cassette("geocoded_white_house") do
      location = WeatherLocation.new(address: '1600 Pennsylvania Avenue NW, Washington, DC 20500')
      assert_nil location.postal_code
      assert_nil location.latitude
      assert_nil location.longitude

      assert location.save

      # set via geocoding after save hook
      assert_equal '20500', location.postal_code
      assert_equal 38.897699700000004, location.latitude
      assert_equal -77.03655315, location.longitude
    end
  end

  def test_save_with_no_address_fails
    location = WeatherLocation.new
    assert_nil location.postal_code
    assert_nil location.latitude
    assert_nil location.longitude

    refute location.save
  end
end
