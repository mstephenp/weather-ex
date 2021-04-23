defmodule WexService.Weatherbit do
  use HTTPoison.Base

  @expected_fields ~w(
    data
  )

  # http://api.weatherbit.io/v2.0/current
  # ?key=APIKEY
  # &city=LOCATION
  # &unit=I FOR Imperial (F not C)

  def process_request_url(url) do
    "http://api.weatherbit.io/v2.0/current" <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!()
    |> Map.take(@expected_fields)
    |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
  end
end
