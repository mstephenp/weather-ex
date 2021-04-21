defmodule WexData.Weatherbit do

  @history_max Application.fetch_env!(:wex_server, :history_max)

  # data comes in as:
  #   [
  #     %{
  #       "datetime" => "2021-04-21:11",
  #       "slp" => 1017.9,
  #       "app_temp" => -1.3,
  #       "dewpt" => -2.3,
  #       "dni" => 0,
  #       "wind_cdir_full" => "south-southwest",
  #       "wind_spd" => 2.06,
  #       "clouds" => 100,
  #       "vis" => 5,
  #       "timezone" => "America/Chicago",
  #       "rh" => 78,
  #       "elev_angle" => -1.3,
  #       "weather" => %{
  #         "code" => 802,
  #         "description" => "Scattered clouds",
  #         "icon" => "c02n"
  #       },
  #       "country_code" => "US",
  #       "ob_time" => "2021-04-21 11:27",
  #       "ghi" => 0,
  #       "lat" => 41.85003,
  #       "solar_rad" => 0,
  #       "wind_dir" => 202,
  #       "precip" => 0,
  #       "pod" => "n",
  #       "wind_cdir" => "SSW",
  #       "uv" => 0,
  #       "lon" => -88.31257,
  #       "aqi" => 22,
  #       "sunrise" => "11:03",
  #       "sunset" => "00:41",
  #       "snow" => 0,
  #       "dhi" => 0,
  #       "h_angle" => -90,
  #       "ts" => 1619004420,
  #       "temp" => 1.1,
  #       "city_name" => "Batavia",
  #       "station" => "C0571",
  #       "pres" => 990.6,
  #       "state_code" => "IL"
  #     }
  #   ]
  # ]

  def get_weather_weatherbit([weather]) do
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

  def update_weather_weatherbit([current_weather], {prev_weather, _prev_raw}) do
    {
      %WexData{
        description: get_description(current_weather),
        cloud_cover: trim_length(prev_weather.cloud_cover, get_clouds(current_weather)),
        humidity: trim_length(prev_weather.humidity, get_humidity(current_weather)),
        pressure: trim_length(prev_weather.pressure, get_pressure(current_weather)),
        temp: trim_length(prev_weather.temp, get_temp(current_weather)),
        wind_speed: trim_length(prev_weather.wind_speed, get_wind_speed(current_weather))
      },
      current_weather
    }
  end

  def get_clouds(weather) do
    weather["clouds"]
  end

  def get_temp(weather) do
    weather["temp"]
  end

  def get_pressure(weather) do
    weather["pres"]
  end

  def get_wind_speed(weather) do
    weather["wind_spd"]
  end

  def get_humidity(weather) do
    weather["rh"]
  end

  def get_description(weather) do
    weather["weather"]["description"]
  end

  def trim_length(list, value) do
    if length(list) >= @history_max do
      List.delete_at(list, 0) ++ [value]
    else
      list ++ [value]
    end
  end

end
