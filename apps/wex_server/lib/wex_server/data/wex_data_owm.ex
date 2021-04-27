defmodule WexData.Owm do
  @history_max Application.fetch_env!(:wex_server, :history_max)

  def get_weather_owm(weather) do
    {
      %WexData{
        cloud_cover: [get(weather, :clouds)],
        description: get(weather, :description),
        humidity: [get(weather, :humidity)],
        pressure: [get(weather, :pressure)],
        temp: [get(weather, :temp)],
        temp_min: [get(weather, :temp_min)],
        temp_max: [get(weather, :temp_max)],
        wind_speed: [get(weather, :wind_speed)],
        location: get(weather, :location),
        ext_service: :openweathermap

      },
      weather
    }
  end

  def update_weather_owm(raw, {prev_weather, _prev_raw}) do
    {
      %WexData{
        description: get(raw, :description),
        cloud_cover: trim_length(prev_weather.cloud_cover, get(raw, :clouds)),
        humidity: trim_length(prev_weather.humidity, get(raw, :humidity)),
        pressure: trim_length(prev_weather.pressure, get(raw, :pressure)),
        temp: trim_length(prev_weather.temp, get(raw, :temp)),
        temp_min: trim_length(prev_weather.temp_min, get(raw, :temp_min)),
        temp_max: trim_length(prev_weather.temp_max, get(raw, :temp_max)),
        wind_speed: trim_length(prev_weather.wind_speed, get(raw, :wind_speed)),
        location: prev_weather.location,
        ext_service: :openweathermap
      },
      raw
    }
  end

  defp get(weather, key) do
    case key do
      :temp ->
        weather[:main]["temp"]

      :temp_max ->
        weather[:main]["temp_max"]

      :temp_min ->
        weather[:main]["temp_min"]

      :clouds ->
        weather[:clouds]["all"]

      :pressure ->
        weather[:main]["pressure"]

      :wind_speed ->
        weather[:wind]["speed"]

      :humidity ->
        weather[:main]["humidity"]

      :description ->
        List.first(weather[:weather])["description"]

      :location ->
        weather[:name]
    end
  end

  defp trim_length(list, value) do
    if length(list) >= @history_max do
      List.delete_at(list, 0) ++ [value]
    else
      list ++ [value]
    end
  end
end
