ExUnit.start()

defmodule LogLevelTests do
  use ExUnit.Case

  test "to_label return :debug" do
    assert LogLevel.to_label(1, true) == :debug
  end

  test "to_label return :trace" do
    assert LogLevel.to_label(0, false) == :trace
  end

  test "to_label level 1  return :debug" do
    assert LogLevel.to_label(1, false) == :debug
  end

  test "to_label level 1 and legacy :debug" do
    assert LogLevel.to_label(1, true) == :debug
  end

  test "to_label return :fatal" do
    assert LogLevel.to_label(5, false) == :fatal
  end

  test "to_label failed to find return :unknown" do
    assert LogLevel.to_label(0, true) == :unknown
  end

  test "alert_recipient on :error alert ops team" do
    assert(LogLevel.alert_recipient(4, true) == :ops)
  end

  test "alert_recipient on :fatal alert ops team" do
    assert(LogLevel.alert_recipient(5, false) == :ops)
  end

  test "alert_recipient on :unknown and legacy alert dev1 team" do
    assert(LogLevel.alert_recipient(6, true) == :dev1)
  end

  test "alert_recipient on :unknown and not legacy alert dev2 team" do
    assert(LogLevel.alert_recipient(6, false) == :dev2)
  end

  test "alert_recipient error not found label" do
    assert(LogLevel.alert_recipient(0, false) == false)
  end
end
