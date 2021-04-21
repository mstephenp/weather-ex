defmodule WexService.Weatherbit do

  use HTTPoison.Base

  @expected_fields ~w(
    data
  )

  # http://api.weatherbit.io/v2.0/current?key=9b722dd7b120407b937ebd93a01da7c6&city=Batavia,Illinois

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
