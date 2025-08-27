defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    [h | t] = String.split(path, ".", parts: 2)
    # [team_mascot, animal]
    cond do
      t == [] -> data[h]
      true -> extract_from_path(data[h], Enum.join(t, "."))
    end
  end

  def get_in_path(data, path) do
    Kernel.get_in(data, String.split(path, "."))
  end
end

data = %{
  "team_mascot" => %{
    "animal" => "bear",
    "actor" => %{
      "first_name" => "Noel"
    }
  }
}

IO.inspect(BasketballWebsite.extract_from_path(data, "team_mascot.actor.first_name"))
IO.inspect(BasketballWebsite.get_in_path(data, "team_mascot.actor.first_name"))
