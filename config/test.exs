import Config

config :gpio, TempMon.Repo,
	username: "postgres",
	password: "postgres",
	database: "tsdb_test",
	hostname: "localhost",
	pool: Ecto.Adapters.SQL.Sandbox
