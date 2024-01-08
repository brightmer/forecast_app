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
  after_save :fetch_forecast, :if => lambda{ |obj| obj.latitude.present? || obj.longitude.present? }
  validates :address, presence: true

  geocoded_by :address do |obj, results|
    if geo = results.first
      obj.postal_code = geo.postal_code
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
    end
  end

  private
  def fetch_forecast



    return unless latitude.present? && longitude.present?

    openapi_url = "https://api.openweathermap.org/data/2.5/weather"
    RestClient.get( openapi_url, params: {
      :lat => latitude,
      :lon => longitude,
      :units =>'imperial',
      :appid => 'c1760c2a5cbeb02fa5d4fb5be3207f7d'
    }) do |response, _request|

      case response.code
      when 200
        data = JSON.parse(response.body)
        self.date_checked = time_to_datetime(data["dt"])
        self.current_temperature = data["main"]["temp"].to_f if data["main"]["temp"]
        self.high_temperature = data["main"]["temp_min"].to_f if data["main"]["temp_min"]
        self.low_temperature = data["main"]["temp_max"].to_f if data["main"]["temp_max"]
        self.weather_description = data["weather"][0]["description"]
        self.units = 'imperial'
      else
        flash[:warn] = "D'oh we couldn't get your weather report - hire me anyway"
        redirect_to weather_locations_path
      end
    end

    forecast_url = "https://api.openweathermap.org/data/2.5/forecast"
    RestClient.get( forecast_url, params: {
      :lat => latitude,
      :lon => longitude,
      :units =>'imperial',
      :appid => 'c1760c2a5cbeb02fa5d4fb5be3207f7d'
    }) do |response, _request|

      case response.code
      when 200
        data = JSON.parse(response.body)
        data["list"].each do |w|
          Forecast.create(
            weather_location: self,
            current_temperature: w["main"]["temp"].to_f,
            forecast_at: time_to_datetime(w["dt"]),
            high_temperature: w["main"]["temp_min"].to_f,
            low_temperature: w["main"]["temp_max"].to_f,
            units: 'imperial',
            weather_description: w["weather"][0]["description"],
            weather_icon: w["weather"][0]["icon"]
          )
        end
      else
        flash[:warn] = "D'oh we couldn't get your forecast - hire me anyway"
        redirect_to weather_locations_path
      end
    end
  end

  def time_to_datetime(timestamp)
    (Time.at(timestamp)).to_datetime
  end
end
