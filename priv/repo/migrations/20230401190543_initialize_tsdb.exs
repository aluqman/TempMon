defmodule TempMon.Repo.Migrations.InitializeTsdb do
  use Ecto.Migration

  def change do
    execute("CREATE EXTENSION IF NOT EXISTS timescaledb;")
  end
end
