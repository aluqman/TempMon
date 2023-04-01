defmodule TempMon.Repo.Migrations.Readings do
  use Ecto.Migration

  def change do
		create table(:readings, primary_key: false) do
			add :temperature, :float
			add :humidity, :float
			timestamps(updated_at: false, type: :utc_datetime)
		end
  end
end
