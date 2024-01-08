# == Schema Information
#
# Table name: forecasts
#
#  id                  :bigint           not null, primary key
#  current_temperature :float(24)
#  forecast_at         :datetime
#  high_temperature    :float(24)
#  low_temperature     :float(24)
#  units               :string(255)
#  weather_description :string(255)
#  weather_icon        :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  weather_location_id :bigint           not null
#
# Indexes
#
#  index_forecasts_on_weather_location_id  (weather_location_id)
#
# Foreign Keys
#
#  fk_rails_...  (weather_location_id => weather_locations.id)
#
class Forecast < ApplicationRecord
  belongs_to :weather_location
end
