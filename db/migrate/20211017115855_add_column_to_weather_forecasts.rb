class AddColumnToWeatherForecasts < ActiveRecord::Migration[5.2]
  def change
    add_column :weather_forecasts, :icon, :string
  end
end
