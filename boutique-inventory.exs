defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, & &1.price, :asc)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(&1.price == nil))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(
      inventory,
      fn item ->
        %{item | name: String.replace(item.name, old_word, new_word)}
      end
    )
  end

  def increase_quantity(item, count) do
    %{
      item
      | quantity_by_size:
          Enum.into(item.quantity_by_size, [], fn {k, v} -> {k, v + count} end) |> Map.new()
    }
  end

  def total_quantity(item) do
    Enum.into(item.quantity_by_size, []) |> Enum.reduce(0, fn {_, v}, sum -> sum + v end)
    # this works too
    # Enum.sum_by(item.quantity_by_size, fn {_, v} -> v end)
  end
end

IO.inspect(
  BoutiqueInventory.sort_by_price([
    %{price: 65, name: "Maxi Brown Dress", quantity_by_size: %{}},
    %{price: 50, name: "Red Short Skirt", quantity_by_size: %{}},
    %{price: 50, name: "Black Short Skirt", quantity_by_size: %{}},
    %{price: 20, name: "Bamboo Socks Cats", quantity_by_size: %{}}
  ])
)

IO.inspect(
  BoutiqueInventory.with_missing_price([
    %{price: 40, name: "Black T-shirt", quantity_by_size: %{}},
    %{price: nil, name: "Denim Pants", quantity_by_size: %{}},
    %{price: nil, name: "Denim Skirt", quantity_by_size: %{}},
    %{price: 40, name: "Orange T-shirt", quantity_by_size: %{}}
  ])
)

IO.inspect(
  BoutiqueInventory.update_names(
    [
      %{price: 40, name: "Black T-shirt", quantity_by_size: %{}},
      %{price: 70, name: "Denim Pants", quantity_by_size: %{}},
      %{price: 65, name: "Denim Skirt", quantity_by_size: %{}},
      %{price: 40, name: "Orange T-shirt", quantity_by_size: %{}}
    ],
    "T-shirt",
    "Tee"
  )
)

IO.inspect(
  BoutiqueInventory.increase_quantity(
    %{
      name: "Polka Dot Skirt",
      price: 68,
      quantity_by_size: %{s: 3, m: 5, l: 3, xl: 4}
    },
    6
  )
)

IO.inspect(
  BoutiqueInventory.total_quantity(%{
    name: "Red Shirt",
    price: 62,
    quantity_by_size: %{s: 3, m: 6, l: 5, xl: 2}
  })
)
