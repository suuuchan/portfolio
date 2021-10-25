class RenameCityColumnToWeatherForecasts < ActiveRecord::Migration[5.2]
  def change
     rename_column :weather_forecasts, :city, :city_id
  end
end
