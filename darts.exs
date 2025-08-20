defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    distance_to_center = :math.sqrt(:math.pow(x, 2) + :math.pow(y, 2))
    cond do
      distance_to_center > 10 -> 0
      distance_to_center > 5 -> 1
      distance_to_center > 1 -> 5
      distance_to_center >= 0 -> 10
    end
  end
end

