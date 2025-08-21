ExUnit.start()

defmodule KitchenCalculatorTest do
  use ExUnit.Case

  test "volume-pair tuple should return numeric component" do
    assert(KitchenCalculator.get_volume({:cup, 2.0}) == 2.0)
  end

  test "to_milliliter :cup should return volume * 240.0" do
    assert(KitchenCalculator.to_milliliter({:cup, 2.5}) == {:milliliter, 600.0})
  end

  test "to_milliliter :fluid_ounce should return volume * 30.0" do
    assert(KitchenCalculator.to_milliliter({:fluid_ounce, 2}) == {:milliliter, 60.0})
  end

  test "to_milliliter :teaspoon should return volume * 5.0" do
    assert(KitchenCalculator.to_milliliter({:teaspoon, 2.5}) == {:milliliter, 12.5})
  end

  test "to_milliliter :tablespoon should return volume * 15.0" do
    assert(KitchenCalculator.to_milliliter({:tablespoon, 3.0}) == {:milliliter, 45.0})
  end

  test "to_milliliter :milliliter should return volume * 1.0" do
    assert(KitchenCalculator.to_milliliter({:milliliter, 3.0}) == {:milliliter, 3.0})
  end

  test "from_milliliter :cup" do
    assert(KitchenCalculator.from_milliliter({:milliliter, 1320.0}, :cup) == {:cup, 5.5})
  end

  test "from_milliliter :fluid_ounce" do
    assert(
      KitchenCalculator.from_milliliter({:milliliter, 300.0}, :fluid_ounce) ==
        {:fluid_ounce, 10.0}
    )
  end

  test "from_milliliter :teaspoon" do
    assert(
      KitchenCalculator.from_milliliter({:milliliter, 300.0}, :teaspoon) ==
        {:teaspoon, 60.0}
    )
  end

  test "from_milliliter :tablespoon" do
    assert(
      KitchenCalculator.from_milliliter({:milliliter, 300.0}, :tablespoon) ==
        {:tablespoon, 20.0}
    )
  end

  test "from_milliliter :milliliter" do
    assert(
      KitchenCalculator.from_milliliter({:milliliter, 300.0}, :milliliter) ==
        {:milliliter, 300.0}
    )
  end

  test "convert :teaspoon to :tablespoon" do
    assert(KitchenCalculator.convert({:teaspoon, 9.0}, :tablespoon) == {:tablespoon, 3.0})
  end
end
