namespace :open_weather_api do
  desc 'Requests and save in database'
  task weather_forecasts: :environment do
    City.all.each do |city|
      open_weather = Api::OpenWeatherMap::Request.new(city.location_id)

     
      response = open_weather.request

      weather = WeatherForecast.find_by(city_id: city.id)

      if weather.nil?
        p 'CREATE'
        WeatherForecast.create(
          city_id: city.id,
          weather_id: response['weather'][0]['id'],
          weather_main: response['weather'][0]['main'],
          icon: response['weather'][0]['icon'],
          temp: response['main']['temp'],
          feels_like: response['main']['feels_like'],
          temp_min: response['main']['temp_min'],
          temp_max: response['main']['temp_max'],
          )
      else
        p 'UPDATE'
        weather.update(
          weather_id: response['weather'][0]['id'],
          weather_main: response['weather'][0]['main'],
          icon: response['weather'][0]['icon'],
          temp: response['main']['temp'],
          feels_like: response['main']['feels_like'],
          temp_min: response['main']['temp_min'],
          temp_max: response['main']['temp_max'],
          )
      end

    end
    puts 'completed!'
  end
end
