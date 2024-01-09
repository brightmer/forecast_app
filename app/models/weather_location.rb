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
class WeatherLocation < ApplicationRecord
  has_many :forecasts, dependent: :delete_all

  after_validation :geocode
  validates :address, presence: true

  geocoded_by :address do |obj, results|
    if geo = results.first
      obj.postal_code = geo.postal_code
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
    end
  end
end
