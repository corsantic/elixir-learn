ExUnit.start()

defmodule LanguageListTest do
  use ExUnit.Case

  test "new list" do
    assert LanguageList.new() == []
  end

  test "add to list" do
    assert LanguageList.add([], "test") == ["test"]
  end

  test "remove first element from list" do
    assert LanguageList.remove(["test", "best"]) == ["best"]
  end

  test "get first element from the list" do
    assert LanguageList.first(["test", "best"]) == "test"
  end

  test "\"Elixir\" exists in list " do
    assert LanguageList.functional_list?(["Elixir", "Belixir"]) == true
  end

  test "\"Elixir\" does not exists in list " do
    assert LanguageList.functional_list?(["KElixir", "Belixir"]) == false
  end
end
