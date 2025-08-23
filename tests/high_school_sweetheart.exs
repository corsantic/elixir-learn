ExUnit.start()

defmodule HighSchoolSweetheartTest do
  use ExUnit.Case

  test "first_letter" do
    assert HighSchoolSweetheart.first_letter("Eli xir") == "E"
  end

  test "initial" do
    assert HighSchoolSweetheart.initial("robert") == "R."
  end

  test "initials" do
    assert HighSchoolSweetheart.initials("lance green") == "L. G."
  end

  test "pairs" do
    assert HighSchoolSweetheart.pair("Blake Miller", "Riley lewis") |> String.contains?("B. M.")
    assert HighSchoolSweetheart.pair("Blake Miller", "Riley lewis") |> String.contains?("R. L.")
  end
end
