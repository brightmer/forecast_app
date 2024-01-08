class CreateWeatherLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :weather_locations do |t|
      t.text :address
      t.float :latitude
      t.float :longitude
      t.string :postal_code
      t.string :weather_description
      t.float :current_temperature
      t.float :high_temperature
      t.float :low_temperature
      t.string :units
      t.datetime :date_checked

      t.timestamps
    end
  end
end
