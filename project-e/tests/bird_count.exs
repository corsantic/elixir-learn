ExUnit.start()

defmodule BirdCountTests do
  use ExUnit.Case

  test "today get first value" do
    assert BirdCount.today([2, 5, 1]) == 2
  end

  test "today get return nil if empty list " do
    assert BirdCount.today([]) == nil
  end

  test "increment_day_count increment today by 1" do
    assert BirdCount.increment_day_count([4, 0, 2]) == [5, 0, 2]
  end

  test "increment_day_count return [1] if list empty" do
    assert BirdCount.increment_day_count([]) == [1]
  end

  test "has_day_without_birds? should return true" do
    assert BirdCount.has_day_without_birds?([2, 0, 4]) == true
  end

  test "has_day_without_birds? should return false" do
    assert BirdCount.has_day_without_birds?([2, 2, 4]) == false
  end

  test "total return total" do
    assert BirdCount.total([2, 2, 4]) == 8
  end

  test "busy_days return 2 busy days" do
    assert BirdCount.busy_days([4, 5, 0, 0, 6]) == 2
  end
end
