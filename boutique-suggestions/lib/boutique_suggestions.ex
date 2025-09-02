defmodule BoutiqueSuggestions do
  @default_price 100
  def get_combinations(tops, bottoms) do
    _get_combinations(tops, bottoms, @default_price)
  end

  def get_combinations(tops, bottoms, maximum_price: price) do
    _get_combinations(tops, bottoms, price)
  end

  def get_combinations(tops, bottoms, _) do
    _get_combinations(tops, bottoms, @default_price)
  end

  defp _get_combinations(tops, bottoms, price) do
    for x <- tops, y <- bottoms, x.base_color != y.base_color, x.price + y.price <= price do
      {x, y}
    end
  end
end
