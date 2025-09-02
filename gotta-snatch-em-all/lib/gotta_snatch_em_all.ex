defmodule GottaSnatchEmAll do
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @spec new_collection(card()) :: collection()
  def new_collection(card) do
    MapSet.new([card])
  end

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection) do
    {MapSet.member?(collection, card), MapSet.put(collection, card)}
  end

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection) do
    is_tradeable =
      MapSet.member?(collection, your_card) && not MapSet.member?(collection, their_card)

    {is_tradeable,
     collection
     |> MapSet.put(their_card)
     |> MapSet.delete(your_card)}
  end

  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates(cards) do
    cards |> MapSet.new() |> to_sorted_list()
  end

  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection) do
    MapSet.difference(your_collection, their_collection) |> MapSet.size()
  end

  @spec boring_cards([collection()]) :: [card()]
  def boring_cards([]), do: []

  def boring_cards(collections) do
    Enum.reduce(collections, &MapSet.intersection/2)
    |> to_sorted_list()
  end

  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards(collections) do
    Enum.reduce(collections, MapSet.new(), &MapSet.union/2)
    |> MapSet.size()
  end

  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
    shiny_cards = collection |> MapSet.filter(&String.contains?(&1, "Shiny"))
    other_cards = MapSet.difference(collection, shiny_cards)

    {shiny_cards |> to_sorted_list(), other_cards |> to_sorted_list()}
  end

  @spec to_sorted_list(collection()) :: [card()]
  defp to_sorted_list(map_set), do: map_set |> MapSet.to_list() |> Enum.sort()
end
