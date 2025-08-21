defmodule Lasagna do
  def expected_minutes_in_oven, do: 40
  def remaining_minutes_in_oven(time_in_oven), do: expected_minutes_in_oven() - time_in_oven
  def preparation_time_in_minutes(layers), do: layers * 2

  def total_time_in_minutes(layers, in_oven_time_in_minutes) do
    preparation_time_in_minutes(layers) + in_oven_time_in_minutes
  end

  def alarm, do: "Ding!"
end

IO.puts(Lasagna.total_time_in_minutes(1, 30))
