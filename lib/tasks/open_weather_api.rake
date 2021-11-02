namespace :open_weather_api do
  desc 'Requests and save in database'
  task weather_forecasts: :environment do
    City.all.each do |city|
      open_weather = Api::OpenWeatherMap::Request.new(city.location_id)

     
      response = open_weather.request

      # binding.irb

      # 3時間ごとのデータ2日分を保存(有料バージョンのため、１日分にする↓)
      # 16.times do |i|
        # params = Api::OpenWeatherMap::Request.attributes_for(response['list'][i])
        # if weather_forecast = WeatherForecast.where(city: city, date: params[:date]).presence
        #   weather_forecast[0].update!(params)
        # else
        #   city.weather_forecasts.create!(params)
        # end
        # p params
      # end

      weather = WeatherForecast.find_by(city_id: city.id)

      # binding.irb
      #この記述復習

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
