defmodule Gpio.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  @default_interval_millis 60_000

  use Application

  def start(_type, _args) do
    sensor_args = [
      pin: Application.fetch_env!(:gpio, :pin),
      sensor: Application.fetch_env!(:gpio, :sensor),
      interval_millis:
        Application.get_env(
          :gpio,
          :interval_millis,
          @default_interval_millis
        )
    ]

    children = [
      TempMon.Repo,
      {TempMon.Poll, sensor_args}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gpio.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
