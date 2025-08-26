defmodule WineCellar do
  def explain_colors do
    [
      {:white, "Fermented without skin contact."},
      {:red, "Fermented with skin contact using dark-colored grapes."},
      {:rose, "Fermented with some skin contact, but not enough to qualify as a red wine."}
    ]
  end


  def filter(cellar, color, opts \\ []) do
    values = Keyword.get_values(cellar, color)

    cond do
      Keyword.get(opts, :year) != nil and Keyword.get(opts, :country) != nil ->
        filter_by_year(values, Keyword.get(opts, :year))
        |> filter_by_country(Keyword.get(opts, :country))

      Keyword.get(opts, :year) ->
        filter_by_year(values, Keyword.get(opts, :year))

      Keyword.get(opts, :country) ->
        filter_by_country(values, Keyword.get(opts, :country))

      true ->
        values
    end
  end

  # The functions below do not need to be modified.

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end

IO.inspect(WineCellar.explain_colors())

IO.inspect(
  WineCellar.filter(
    [
      white: {"Chardonnay", 2015, "Italy"},
      white: {"Pinot grigio", 2017, "Germany"},
      red: {"Pinot noir", 2016, "France"},
      rose: {"Dornfelder", 2018, "Germany"}
    ],
    :rose
  )
)

IO.inspect(
  WineCellar.filter(
    [
      white: {"Chardonnay", 2015, "Italy"},
      white: {"Pinot grigio", 2017, "Germany"},
      red: {"Pinot noir", 2016, "France"},
      rose: {"Dornfelder", 2018, "Germany"}
    ],
    :white,
    year: 2015
  )
)

IO.inspect(
  WineCellar.filter(
    [
      white: {"Chardonnay", 2015, "Italy"},
      white: {"Pinot grigio", 2017, "Germany"},
      red: {"Pinot noir", 2016, "France"},
      rose: {"Dornfelder", 2018, "Germany"}
    ],
    :rose,
    year: 2018,
    country: "Germany"
  )
)
