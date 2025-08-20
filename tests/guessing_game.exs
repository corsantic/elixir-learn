ExUnit.start()

defmodule GuessingGameTest do
  use ExUnit.Case

  test "Correct" do
    assert(GuessingGame.compare(5, 5) == "Correct")
  end
  test "Too high" do
    assert(GuessingGame.compare(5, 7) == "Too high")
  end
  test "Too low" do
    assert(GuessingGame.compare(5, 3) == "Too low")
  end
  test "So close lower" do
    assert(GuessingGame.compare(5, 4) == "So close")
  end
  test "So close upper" do
    assert(GuessingGame.compare(5, 6) == "So close")
  end
  test "No guess atom" do
    assert(GuessingGame.compare(5, :any_atom) == "Make a guess")
  end
  test "No guess blank" do
    assert(GuessingGame.compare(5) == "Make a guess")
  end

end
