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
  # test "the truth" do
  #   assert true
  # end
end
