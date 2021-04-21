defmodule WexService.OpenWeatherMap do
  use HTTPoison.Base

  @expected_fields ~w(
    main wind clouds rain snow weather sys
  )

  def process_request_url(url) do
    "http://api.openweathermap.org/data/2.5/weather" <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!()
    |> Map.take(@expected_fields)
    |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
  end
end
