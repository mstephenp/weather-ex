defmodule WexData.Owm do
  @history_max Application.fetch_env!(:wex_server, :history_max)

  def get_weather_owm(weather) do
    {
      %WexData{
        cloud_cover: [get_clouds(weather)],
        description: get_description(weather),
        humidity: [get_humidity(weather)],
        pressure: [get_pressure(weather)],
        temp: [get_temp(weather)],
        wind_speed: [get_wind_speed(weather)]
      },
      weather
    }
  end

  def update_weather_owm(raw, {prev_weather, _prev_raw}) do

    {
      %WexData{
        description: get_description(raw),
        cloud_cover: trim_length(prev_weather.cloud_cover, get_clouds(raw)),
        humidity: trim_length(prev_weather.humidity, get_humidity(raw)),
        pressure: trim_length(prev_weather.pressure, get_pressure(raw)),
        temp: trim_length(prev_weather.temp, get_temp(raw)),
        wind_speed: trim_length(prev_weather.wind_speed, get_wind_speed(raw))
      },
      raw
    }
  end

  defp get_clouds(weather) do
    weather[:clouds]["all"]
  end

  defp get_temp(weather) do
    weather[:main]["temp"]
  end

  defp get_pressure(weather) do
    weather[:main]["pressure"]
  end

  defp get_wind_speed(weather) do
    weather[:wind]["speed"]
  end

  defp get_humidity(weather) do
    weather[:main]["humidity"]
  end

  defp get_description(weather) do
    List.first(weather[:weather])["description"]
  end

  defp trim_length(list, value) do
    if length(list) >= @history_max do
      List.delete_at(list, 0) ++ [value]
    else
      list ++ [value]
    end
  end
end
