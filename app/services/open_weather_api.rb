# frozen_string_literal: true

class OpenWeatherApi
  class << self
    def fetch_weather!(location)
        return if location.forecasts.size > 0 # do not refetch forecast
        return unless location.latitude.present? && location.longitude.present?

        openapi_url = "https://api.openweathermap.org/data/2.5/weather"
        RestClient.get( openapi_url, params: {
          :lat => location.latitude,
          :lon => location.longitude,
          :units =>'imperial',
          :appid => 'c1760c2a5cbeb02fa5d4fb5be3207f7d'
        }) do |response, _request|

          case response.code
          when 200
            data = JSON.parse(response.body)
            location.date_checked = time_to_datetime(data["dt"])
            location.current_temperature = data["main"]["temp"].to_f if data["main"]["temp"]
            location.high_temperature = data["main"]["temp_min"].to_f if data["main"]["temp_min"]
            location.low_temperature = data["main"]["temp_max"].to_f if data["main"]["temp_max"]
            location.weather_description = data["weather"][0]["description"]
            location.units = 'imperial'
          else
            flash[:warn] = "D'oh we couldn't get your weather report - hire me anyway"
            raise response.error_messages
          end
        end
        location.save
    end

    def fetch_forecast!(location)
      forecast_url = "https://api.openweathermap.org/data/2.5/forecast"
      RestClient.get( forecast_url, params: {
        :lat => location.latitude,
        :lon => location.longitude,
        :units =>'imperial',
        :appid => 'c1760c2a5cbeb02fa5d4fb5be3207f7d'
      }) do |response, _request|

        case response.code
        when 200
          data = JSON.parse(response.body)
          data["list"].each do |w|
            Forecast.create(
              weather_location: location,
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
          raise response.error_messages
        end
      end
    end

    def time_to_datetime(timestamp)
      (Time.at(timestamp.to_i)).to_datetime

    end
  end
end
