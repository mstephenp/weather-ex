# WeatherEx

### *An Elixir / Phoenix based weather app* 

### Supported backends
- [Open Weather](https://openweathermap.org)
- [Weatherbit](https://www.weatherbit.io/)

### Configuration

1. Add a config/config.exs to the project root
2. Put the following:

```elixir
import Config

config :wex_server,
  history_max: 10,
  # external_service: :weatherbit,
  external_service: :openweathermap,
  wex_service_owm: [
    id: "4884192",
    units: "imperial",
    app_id: "YOUR OPENWEATHER API KEY"
  ],
  wex_service_weatherbit: [
    api_key: "YOUR WEATHERBIT API KEY",
    location: "Batavia,Illinois",
    units: "I"
  ]
```
See the API docs for information about locations / units
