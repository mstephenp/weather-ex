defmodule WexData.Weatherbit do
  @history_max Application.fetch_env!(:wex_server, :history_max)

  def get_weather_weatherbit([weather | forecast]) do
    {
      %WexData{
        cloud_cover: [get(weather, :clouds)],
        description: get(weather, :description),
        humidity: [get(weather, :humidity)],
        pressure: [get(weather, :pressure)],
        temp: [get(weather, :temp)],
        temp_min: [get_forecasted(forecast, :temp_min)],
        temp_max: [get_forecasted(forecast, :temp_max)],
        wind_speed: [get(weather, :wind_speed)],
        location: get(weather, :location)
      },
      weather
    }
  end

  def update_weather_weatherbit([current_weather | forecast], {prev_weather, _prev_raw}) do
    {
      %WexData{
        description: get(current_weather, :description),
        cloud_cover: trim_length(prev_weather.cloud_cover, get(current_weather, :clouds)),
        humidity: trim_length(prev_weather.humidity, get(current_weather, :humidity)),
        pressure: trim_length(prev_weather.pressure, get(current_weather, :pressure)),
        temp: trim_length(prev_weather.temp, get(current_weather, :temp)),
        temp_min: trim_length(prev_weather.temp_min, get_forecasted(forecast, :temp_min)),
        temp_max: trim_length(prev_weather.temp_max, get_forecasted(forecast, :temp_max)),
        wind_speed: trim_length(prev_weather.wind_speed, get(current_weather, :wind_speed)),
        location: prev_weather.location
      },
      current_weather
    }
  end

  defp get(weather, key) do
    case key do
      :temp ->
        weather["temp"]

      :clouds ->
        weather["clouds"]

      :pressure ->
        weather["pres"]

      :wind_speed ->
        weather["wind_spd"]

      :humidity ->
        weather["rh"]

      :description ->
        weather["weather"]["description"]

      :location ->
        "#{weather["city_name"]},#{weather["state_code"]} - Station: #{weather["station"]}"
    end
  end

  defp get_forecasted(forecast, key) do
    case key do
      :temp_min ->
        List.first(forecast)["min_temp"]

      :temp_max ->
        List.first(forecast)["max_temp"]
    end
  end

  def trim_length(list, value) do
    if length(list) >= @history_max do
      List.delete_at(list, 0) ++ [value]
    else
      list ++ [value]
    end
  end
end
