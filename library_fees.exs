defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    NaiveDateTime.to_time(datetime) |> Time.before?(~T[12:00:00])
  end

  def return_date(checkout_datetime) do
    NaiveDateTime.add(checkout_datetime, get_given_day(checkout_datetime), :day)
    |> NaiveDateTime.to_date()
  end

  defp get_given_day(checkout_datetime), do: if(before_noon?(checkout_datetime), do: 28, else: 29)

  def days_late(planned_return_date, actual_return_datetime) do
    dif = Date.diff(NaiveDateTime.to_date(actual_return_datetime), planned_return_date)

    cond do
      dif <= 0 -> 0
      true -> dif
    end
  end

  def monday?(datetime) do
    date = NaiveDateTime.to_date(datetime)
    Date.beginning_of_week(date) |> Date.compare(date) |> equal?()
  end

  defp equal?(:eq), do: true
  defp equal?(_), do: false

  def calculate_late_fee(checkout, return, rate) do
    converted_return_date = datetime_from_string(return)

    days_late =
      datetime_from_string(checkout)
      |> return_date()
      |> days_late(converted_return_date)

    cond do
      monday?(converted_return_date) ->
        trunc(rate * days_late * 0.5)

      true ->
        rate * days_late
    end
  end
end

IO.inspect(LibraryFees.datetime_from_string("2021-01-01T13:30:45Z"))

IO.inspect(LibraryFees.before_noon?(~N[2021-01-12 08:23:03]))

IO.inspect(LibraryFees.return_date(~N[2020-11-28 11:55:33]))
IO.inspect(LibraryFees.days_late(~D[2020-12-27], ~N[2020-12-28 09:23:36]))

IO.inspect(LibraryFees.monday?(~N[2025-08-26 13:30:45Z]))

IO.inspect(LibraryFees.calculate_late_fee("2020-11-28T15:55:33Z", "2021-01-04T09:02:11Z", 100))
IO.inspect(LibraryFees.calculate_late_fee("2020-11-28T15:55:33Z", "2021-01-03T13:30:45Z", 100))
