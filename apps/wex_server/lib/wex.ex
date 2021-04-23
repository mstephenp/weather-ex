defmodule Wex do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  @spec init(any) :: {:ok, {WexData.t(), Map.t()}}
  def init(_opts) do
    {:ok, init_weather()}
  end

  @spec init_weather() :: WexData.t()
  def init_weather() do
    WexService.get_weather()
  end

  @spec current :: WexData.t()
  def current() do
    GenServer.call(Wex, {:current_weather})
  end

  @spec update :: :ok
  def update() do
    GenServer.cast(Wex, {:update_weather})
  end

  @spec description() :: String.t()
  def description() do
    GenServer.call(Wex, {:description})
  end

  @spec average_temp :: number()
  def average_temp() do
    GenServer.call(Wex, {:avg_temp})
  end

  @spec average_humidity :: number()
  def average_humidity() do
    GenServer.call(Wex, {:avg_humidity})
  end

  @spec average_pressure :: number()
  def average_pressure() do
    GenServer.call(Wex, {:avg_pressure})
  end

  @spec average_windspeed :: number()
  def average_windspeed() do
    GenServer.call(Wex, {:avg_windspeed})
  end

  @spec location :: String.t()
  def location() do
    GenServer.call(Wex, {:location})
  end

  @impl true
  def handle_call(call, _from, {current, current_raw}) do
    case call do
      {:current_weather} ->
        {:reply, current, {current, current_raw}}

      {:description} ->
        {:reply, current.description, {current, current_raw}}

      {:avg_temp} ->
        {:reply, avg(current.temp), {current, current_raw}}

      {:avg_humidity} ->
        {:reply, avg(current.humidity), {current, current_raw}}

      {:avg_pressure} ->
        {:reply, avg(current.pressure), {current, current_raw}}

      {:avg_windspeed} ->
        {:reply, avg(current.wind_speed), {current, current_raw}}

      {:location} ->
        {:reply, current.location, {current, current_raw}}
    end
  end

  @spec avg(list) :: float
  def avg(values) do
    Enum.sum(values) / length(values)
  end

  @impl true
  def handle_cast(cast, current) do
    case cast do
      {:update_weather} ->
        {:noreply, WexService.update_weather(current)}
    end
  end

  @impl true
  def handle_info({:DOWN, _ref, :process, _pid, _reason}, _weather) do
    {:noreply, []}
  end

  @impl true
  def handle_info(_msg, weather) do
    {:noreply, weather}
  end
end
