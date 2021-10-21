module Api
  module OpenWeatherMap
    class Request
      attr_accessor :query

      def initialize(location_id)
        @query = {
          id: location_id,
          units: 'metric',
          appid: Rails.application.credentials.open_weather[:appid],
        }
      end

      def request
        client = HTTPClient.new
        request = client.get(Rails.application.credentials.open_weather[:uri], query) # 戻り値は3時間ごとのデータ5日分
        JSON.parse(request.body)
      end

      def self.attributes_for(attrs)
        rainfall = attrs['rain']['3h'] if attrs['rain']
        date = attrs['dt_txt'].in_time_zone('UTC').in_time_zone

        {
          temp_max: attrs['main']['temp_max'],
          temp_min: attrs['main']['temp_min'],
          temp_feel: attrs['main']['feels_like'],
          weather_id: attrs['weather'][0]['id'],
          rainfall: rainfall,
          date: date,
          aquired_at: Time.current,
        }
      end
    end
  end
end