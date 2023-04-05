defmodule TempMonTest.Reading do
  use ExUnit.Case, async: true
	use TempMon.RepoCase

  alias TempMon.Reading
  import ExUnit.CaptureLog
  require Logger

  @good_reading {:ok, %{temperature: 99.0, humidity: 99.0}}
  @bad_reading {:error, -99}
  @state [pin: 4, sensor: :dht11]

  describe "process/2" do
    test "handles proper data" do
      assert capture_log(fn ->
               Reading.process(@good_reading, @state)
             end) =~ "Analyzing reading."

      assert {:ok, _res} = Reading.process(@good_reading, @state)
    end

    test "handles improper data" do
      assert capture_log(fn ->
               Reading.process(@bad_reading, @state)
             end) =~ "Sensor responded with error code -99"
    end
  end
end
