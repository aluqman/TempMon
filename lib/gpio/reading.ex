defmodule TempMon.Reading do
  @moduledoc """
  Schema and changeset for the reading of data from a sensor.
  Contains information relating solely to temperature and humidity.
  """

  use Ecto.Schema
  require Logger
  alias Ecto.Changeset
  alias TempMon.Sensor

  @primary_key false

  schema "readings" do
    field(:temperature, :float)
    field(:humidity, :float)
    timestamps(updated_at: false, type: :utc_datetime)
  end

  def changeset(reading, params \\ %{}) do
    reading
    |> Changeset.cast(params, [:temperature, :humidity])
    |> Changeset.validate_required([:temperature, :humidity])
    |> Changeset.validate_number(:temperature, less_than: 100)
    |> Changeset.validate_number(:humidity, less_than: 100)
  end

  @doc """
  Responsible for processing a reading from a sensor, and inserting
  properly formatted data in to the database.
  """
  @spec process({:ok, map()} | {:error, integer()}, list()) :: any()
  def process({:ok, reading}, _state) do
    Logger.info("Analyzing reading.")

    %TempMon.Reading{}
    |> changeset(reading)
    |> TempMon.Repo.insert()
  end

  def process({:error, error_code}, state) do
    Logger.error("Sensor responded with error code #{error_code}.")

    # Retry failed readings.
    Sensor.read(
      state[:pin],
      state[:sensor]
    )
    |> process(state)
  end
end
