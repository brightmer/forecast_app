class CreateForecasts < ActiveRecord::Migration[7.1]
  def change
    create_table :forecasts do |t|
      t.references :weather_location, null: false, foreign_key: true
      t.datetime :forecast_at
      t.string :weather_description
      t.string :weather_icon
      t.float :current_temperature
      t.float :high_temperature
      t.float :low_temperature
      t.string :units

      t.timestamps
    end
  end
end
