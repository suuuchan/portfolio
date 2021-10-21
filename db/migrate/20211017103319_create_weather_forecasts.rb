class CreateWeatherForecasts < ActiveRecord::Migration[5.2]
  def change
    create_table :weather_forecasts do |t|
      t.integer :city, foreign_key: true
      t.integer :weather_id
      t.string :weather_main
      t.float :temp
      t.float :feels_like
      t.float :temp_min
      t.float :temp_max
      t.timestamps
    end
  end
end
