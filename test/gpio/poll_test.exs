defmodule TempMon.PollTest do
  use ExUnit.Case, async: true
  use TempMon.RepoCase

  alias TempMon.Poll

  describe "start_link/1" do
    test "starts with args as state" do
      args = [pin: 4, sensor: :dht11]

      assert {:ok, _pid} = Poll.start_link(args)
    end
  end
end
