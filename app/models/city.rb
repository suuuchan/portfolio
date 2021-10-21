class City < ApplicationRecord
  has_one :weather_forecast
end
