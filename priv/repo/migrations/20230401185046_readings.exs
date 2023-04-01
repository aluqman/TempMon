defmodule TempMon.Repo.Migrations.Readings do
  use Ecto.Migration

  def change do
		create table(:readings) do
			add :temperature, :float
			add :humidity, :float
			timestamps()
		end
  end
end
