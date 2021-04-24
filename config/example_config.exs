# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :wex_web,
  ecto_repos: [WexWeb.Repo],
  generators: [context_app: false]

# Configures the endpoint
config :wex_web, WexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ne7McBwDQWNUy0Q2XhgGNMBYsn29+XhGyIlBOOkxTtvSCmwHZEsnyqLNhm0qlExx",
  render_errors: [view: WexWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: WexWeb.PubSub,
  live_view: [signing_salt: "YsqCuczU"]

config :wex_web,
  ecto_repos: [WexWeb.Repo],
  generators: [context_app: false]

# Configures the endpoint
config :wex_web, WexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LmrgTwfaAfUeR3T+bWyKwolPdjO1SzPZdPOMaTjCyhwtq0HjuAUCiOPnRwnl8MmZ",
  render_errors: [view: WexWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: WexWeb.PubSub,
  live_view: [signing_salt: "pqSfztTN"]

config :wex_server,
  history_max: 10,
  # external_service: :weatherbit,
  external_service: :openweathermap,
  wex_service_owm: [
    id: "YOUR LOCATION ID",
    units: "imperial",
    app_id: "OWM API KEY"
  ],
  wex_service_weatherbit: [
    api_key: "WEATHERBIT API KEY",
    location: "YOUR LOCATION",
    units: "I",
    days: 2
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
