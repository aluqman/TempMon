defmodule TempMon.Repo.Migrations.AddHypertable do
  use Ecto.Migration

  def change do
    execute("SELECT create_hypertable('readings', 'inserted_at');")
  end
end
