defmodule TempMon.Repo do
  use Ecto.Repo,
    otp_app: :gpio,
    adapter: Ecto.Adapters.Postgres
end
