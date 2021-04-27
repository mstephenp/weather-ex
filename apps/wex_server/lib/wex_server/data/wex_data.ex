defmodule WexData do
  defstruct [
    :description,
    :temp,
    :temp_min,
    :temp_max,
    :pressure,
    :humidity,
    :wind_speed,
    :cloud_cover,
    :location,
    :ext_service
  ]

  def get_weather(backend, weather) do
    case backend do
      :openweathermap ->
        WexData.Owm.get_weather_owm(weather)

      :weatherbit ->
        WexData.Weatherbit.get_weather_weatherbit(weather)

      _ ->
        throw(%WexError{message: "unsupported backend type"})
    end
  end

  def update_weather(backend, current, previous) do
    case backend do
      :openweathermap ->
        WexData.Owm.update_weather_owm(current, previous)

      :weatherbit ->
        WexData.Weatherbit.update_weather_weatherbit(current, previous)

      _ ->
        throw(%WexError{message: "unsupported backend type"})
    end
  end
end
