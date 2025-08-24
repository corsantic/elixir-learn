defmodule RPG.CharacterSheet do
  def welcome() do
    IO.puts("Welcome! Let's fill out your character sheet together.")
  end

  def ask_name() do
    IO.gets("What is your character's name?\n") |> String.trim()
  end

  def ask_class() do
    IO.gets("What is your character's class?\n") |> String.trim()
  end

  def ask_level() do
    IO.gets("What is your character's level?\n")
    |> String.trim()
    |> String.to_integer()
  end

  def run() do
    welcome()
    name = ask_name()
    class = ask_class()
    level = ask_level()

    character =
      %{:name => name, :level => level, :class => class}

    character |> IO.inspect(label: "Your character")
  end
end

ExUnit.start()

defmodule RPG.CharacterSheetTests do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "run " do
    io = capture_io("Anne\nhealer\n4\n", fn -> RPG.CharacterSheet.run() end)
    assert io =~ "\nYour character: " <> inspect(%{name: "Anne", class: "healer", level: 4})
  end
end
