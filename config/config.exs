import Config

config :gpio, TempMon.Repo,
  database: "tsdb",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :gpio,
  ecto_repos: [TempMon.Repo]
