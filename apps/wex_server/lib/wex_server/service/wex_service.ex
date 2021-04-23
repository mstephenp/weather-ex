defmodule WexService do
  @external_service Application.fetch_env!(:wex_server, :external_service)

  @spec get_weather() :: {WexData.t(), Map.t()}
  def get_weather() do
    WexData.get_weather(
      @external_service,
      get_current_weather()
    )
  end

  @spec update_weather({WexData.t(), Map.t()}) :: {WexData.t(), Map.t()}
  def update_weather(prev_weather) do
    WexData.update_weather(
      @external_service,
      get_current_weather(),
      prev_weather
    )
  end

  def get_current_weather() do
    case @external_service do
      :openweathermap ->
        owm_config = Application.fetch_env!(:wex_server, :wex_service_owm)

        WexService.OpenWeatherMap.get!(
          "?id=#{owm_config[:id]}&units=#{owm_config[:units]}&appid=#{owm_config[:app_id]}"
        ).body

      :weatherbit ->
        weatherbit_config = Application.fetch_env!(:wex_server, :wex_service_weatherbit)

        current =
          WexService.Weatherbit.get!(
            "?key=#{weatherbit_config[:api_key]}&city=#{weatherbit_config[:location]}&units=#{
              weatherbit_config[:units]
            }"
          ).body[:data]

        forecast =
          WexService.Weatherbit.Forecast.get!(
            "?days=#{weatherbit_config[:days]}&key=#{weatherbit_config[:api_key]}&city=#{
              weatherbit_config[:location]
            }&units=#{weatherbit_config[:units]}"
          ).body[:data]

        current ++ forecast

      _ ->
        # space to add different backend api calls
        throw(%WexError{message: "unsupported backend service"})
    end
  end
end
