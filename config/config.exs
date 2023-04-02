import Config

config :gpio, TempMon.Repo,
  database: "tsdb",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :gpio,
  ecto_repos: [TempMon.Repo],
  sensor: :dht11,
  pin: 4,
  interval_millis: 2_000
