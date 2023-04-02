defmodule TempMon.Sensor do
  @moduledoc """
  Abstraction over a sensor.

  This is used to implement a behavior for a sensor, delegating to
  whatever is configurd by the application.
  """

  @callback read(integer(), atom()) :: {:ok, map()} | {:error, integer()}

  @doc """
  Read sensor data from a pin. Returns either {:ok, map} where
  map contains sensor data, or {:error, error_code}.
  """
  def read(pin, sensor), do: impl().read(pin, sensor)

  defp impl, do: Application.get_env(:gpio, :sensor_lib, DHT)
end
