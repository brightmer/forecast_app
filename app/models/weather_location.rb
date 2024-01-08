class WeatherLocation < ApplicationRecord
  has_many :forecasts, dependent: :delete_all
end
