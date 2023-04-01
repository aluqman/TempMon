defmodule TempMon.Reading do
	use Ecto.Schema

	@primary_key false

	schema "readings" do
		field :temperature, :float
		field :humidity, :float
		field :inserted_at, :utc_datetime
	end

	def changeset(reading, params \\ %{}) do
		reading
		|> Ecto.Changeset.cast(params, [:temperature, :humidity, :inserted_at])
		|> Ecto.Changeset.validate_required([:temperature, :humidity, :inserted_at])
	end
end
