defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  # {{:def, [line: 1], [{:adjust, [line: 1], nil}, [do: :scale]]}, :adjust, nil,
  #  ["re"]}
  defp decode_secret_message_part(ast_node, func, args, acc) do
    # IO.inspect({ast_node, func, args, acc})
    if args == nil or length(args) == 0 do
      {ast_node, ["" | acc]}
    else
      {ast_node, [func |> Atom.to_string() |> String.slice(0..(length(args) - 1)) | acc]}
    end
  end

  def decode_secret_message_part(
        {:def, _, [{:when, _, [{func, _, args}, _]}, _]} = ast_node,
        acc
      ),
      do: decode_secret_message_part(ast_node, func, args, acc)

  def decode_secret_message_part(
        {:defp, _, [{:when, _, [{func, _, args}, _]}, _]} = ast_node,
        acc
      ),
      do: decode_secret_message_part(ast_node, func, args, acc)

  def decode_secret_message_part({:def, _, [{func, _, args}, _]} = ast_node, acc),
    do: decode_secret_message_part(ast_node, func, args, acc)

  def decode_secret_message_part({:defp, _, [{func, _, args}, _]} = ast_node, acc),
    do: decode_secret_message_part(ast_node, func, args, acc)

  def decode_secret_message_part(ast_node, acc), do: {ast_node, acc}

  def decode_secret_message(string) do
    ast = to_ast(string)

    Macro.prewalk(ast, [], fn
      {:def, meta, node}, acc -> decode_secret_message_part({:def, meta, node}, acc)
      {:defp, meta, node}, acc -> decode_secret_message_part({:defp, meta, node}, acc)
      other, acc -> {other, acc}
    end)
    |> elem(1)
    |> Enum.reverse()
    |> Enum.join("")
  end
end

# IO.inspect(TopSecret.to_ast("div(4, 3)"))
#
# ast_node = TopSecret.to_ast("defp cat(a, b), do: nil")
#
# IO.inspect(ast_node)
# IO.inspect(TopSecret.decode_secret_message_part(ast_node, ["day"]))
#
# ast_node = TopSecret.to_ast("10 + 3")
# IO.inspect(TopSecret.decode_secret_message_part(ast_node, ["day"]))
#
# ast_node = TopSecret.to_ast("defp cat(a, b) when is_nil(a), do: nil")
# IO.inspect(ast_node)
# IO.inspect(TopSecret.decode_secret_message_part(ast_node, ["day"]))
#
# code = """
# defmodule MyCalendar do
#   def busy?(date, time) do
#     Date.day_of_week(date) != 7 and
#       time.hour in 10..16
#   end
#
#   def yesterday?(date) do
#     Date.diff(Date.utc_today, date)
#   end
# end
# """
#
# # IO.inspect(TopSecret.to_ast(code))
#
# IO.inspect(TopSecret.decode_secret_message(code))
# {:defp, [line: 1],
#  [
#    {:cat, [line: 1],
#     [{:a, [line: 1], nil}, {:b, [line: 1], nil}, {:c, [line: 1], nil}]},
#    [do: nil]
#  ]}

string = "def sign(a) when a >= 0, do: :+"
ast = TopSecret.to_ast(string)
acc = ["e"]
IO.inspect(TopSecret.decode_secret_message_part(ast, acc))
