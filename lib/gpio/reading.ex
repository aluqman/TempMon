defmodule TempMon.Reading do
  @moduledoc """
  Schema and changeset for the reading of data from a sensor. 
  Contains information relating solely to temperature and humidity.
  """

  use Ecto.Schema
	require Logger

  @primary_key false

  schema "readings" do
    field(:temperature, :float)
    field(:humidity, :float)
    timestamps(updated_at: false, type: :utc_datetime)
  end

  def changeset(reading, params \\ %{}) do
    reading
    |> Ecto.Changeset.cast(params, [:temperature, :humidity])
    |> Ecto.Changeset.validate_required([:temperature, :humidity])
  end

	@doc """
	Responsible for processing a reading from a sensor, and inserting
	properly formatted data in to the database.
	"""
	@spec process({:ok, map()} | {:error, integer()}) :: any()
	def process({:ok, reading}) do
		Logger.info("Analyzing reading.")

		%TempMon.Reading{}
		|> changeset(reading)
		|> TempMon.Repo.insert()
	end

	def process({:error, error_code}) do
		Logger.error("Sensor responded with error code #{error_code}.")
	end
end
