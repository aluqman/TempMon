# TempMon

A simple Elixir program to poll a temperature sensor in my room
to tell me how shit the air quality is.

Leverages Ecto + TimescaleDB to create readings on a fixed interval (aka timeseries data).

Future additions (in order of priority): 

- [x] Add tests, linting, etc. and clean the code up a bit (including CI pipelines for all of the above)
  - [ ] (Maybe) auto-deploy updates to the Pi when CI succeeds 
- [ ] Add Grafana dashboards to visualize the data coming in.
- [ ] Add some way of alerting myself if something goes wrong (i.e. temperature goes above X)

## Isn't this super over-engineered?

Yes. Definitely. You could do the exact same thing with a cron job and a single-file Python script. Consider,
however, that this is *fun*. This is a little bit of an exercise in software architecture -
designing something this small and simple is hard to mess up, but gives a lot of room for experimentation.
Over-engineering this simply gives me the confidence to regular-engineer more intense projects.

Also, it makes me feel good about myself, and is fun to do. Sometimes that's the only reason you need.

## Requirements

- A local Elixir installation
- Some sensor to be read from. I'm using a Raspberry Pi with a DHT-11 to do readings.
- PostgreSQL with the TimescaleDB extension.

## Configuration

Config options are available under `config/config.exs`. 

A sensor and given GPIO data pin can be configured on a per-application basis there.
The database configuration is also present there. This project assumes that there is a local instance of PostgreSQL
running, with TimescaleDB installed. The migrations automagically create a database with the extension enabled.

In the event that you're not using the same sensor as I am, you can also add a different library to `mix.exs`
and configure that like so:

```elixir
config :gpio,
  ecto_repos: [TempMon.Repo],
  sensor: # insert sensor here,
  pin:  # insert pin number here,
  sensor_lib: # insert library here
```

## Initialization

Configure the application as you want, and then do the ol' Ecto goodness:

```shell
mix ecto.create
mix ecto.migrate
```

From there, you can run the app using `mix run --no-halt`. You can also run the app interactively
in `iex` using `iex -S mix` but, why would you?

## Installation

no <3
