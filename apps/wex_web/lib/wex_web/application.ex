defmodule WexWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      WexWeb.Telemetry,
      # Start the Endpoint (http/https)
      WexWeb.Endpoint,
      # Start a worker by calling: WexWeb.Worker.start_link(arg)
      # {WexWeb.Worker, arg}
      {Phoenix.PubSub, name: WexWeb.PubSub}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WexWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    WexWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
