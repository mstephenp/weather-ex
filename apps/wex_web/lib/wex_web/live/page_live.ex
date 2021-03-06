defmodule WexWeb.PageLive do
  use WexWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
      #  query: "",
      #  results: %{},
       weather: [
         temp: Wex.average_temp(),
         pressure: Wex.average_pressure(),
         description: Wex.description(),
         location: Wex.location(),
         wind_speed: Wex.average_windspeed(),
         humidity: Wex.average_humidity(),
         ext_service: Wex.ext_service()
       ]
     )}
  end

  # @impl true
  # def handle_event("suggest", %{"q" => query}, socket) do
  #   {:noreply, assign(socket, results: search(query), query: query)}
  # end

  # @impl true
  # def handle_event("search", %{"q" => query}, socket) do
  #   case search(query) do
  #     %{^query => vsn} ->
  #       {:noreply, redirect(socket, external: "https://hexdocs.pm/#{query}/#{vsn}")}

  #     _ ->
  #       {:noreply,
  #        socket
  #        |> put_flash(:error, "No dependencies found matching \"#{query}\"")
  #        |> assign(results: %{}, query: query)}
  #   end
  # end

  @impl true
  def handle_event("update", _value, socket) do
    Wex.update()

    {:noreply,
     socket
     |> assign(
       weather: [
         temp: Wex.average_temp(),
         pressure: Wex.average_pressure(),
         description: Wex.description(),
         location: Wex.location(),
         wind_speed: Wex.average_windspeed(),
         humidity: Wex.average_humidity(),
         ext_service: Wex.ext_service()
       ]
     )}
  end

  # defp search(query) do
  #   if not WexWeb.Endpoint.config(:code_reloader) do
  #     raise "action disabled when not in development"
  #   end

  #   for {app, desc, vsn} <- Application.started_applications(),
  #       app = to_string(app),
  #       String.starts_with?(app, query) and not List.starts_with?(desc, ~c"ERTS"),
  #       into: %{},
  #       do: {app, vsn}
  # end
end
