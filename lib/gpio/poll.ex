defmodule TempMon.Poll do
  @moduledoc """
  Abstraction of polling a sensor using a GenServer.
  Responsible for polling the sensor on a given interval
  before shipping the results off to be processed in a separate thread.

  In the interest of accuracy for the polling interval, processing of results 
  is handled by a separate process. 
  """
  @default_interval_millis 60_000

  use GenServer
  alias TempMon.Sensor
	alias TempMon.Reading

  @spec start_link(list()) :: {:ok, pid()}
  @doc """
  Starts a GenServer for the module. The args to passed to `init`
  become the state of the server.
  """
  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  @impl true
  def init(args) do
    Process.send(self(), :poll, [])

    {:ok, args}
  end

  @impl true
  def handle_info(:poll, state) do
    # poll
    reading =
      Sensor.read(
        state[:pin],
        state[:sensor]
      )

    # send result to partner thread
		Task.start(fn -> 
			Reading.process(reading)
		end)

    Process.send_after(
      self(),
      :poll,
      Keyword.get(state, :interval_millis, @default_interval_millis)
    )

		{:noreply, state}
  end
end
