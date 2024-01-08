json.extract! weather_location, :id, :address, :latitude, :longitude, :postal_code, :weather_description, :current_temperature, :high_temperature, :low_temperature, :units, :date_checked, :created_at, :updated_at
json.url weather_location_url(weather_location, format: :json)
