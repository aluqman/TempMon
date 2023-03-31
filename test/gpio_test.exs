defmodule GpioTest do
  use ExUnit.Case
  doctest Gpio

  test "greets the world" do
    assert Gpio.hello() == :world
  end
end
