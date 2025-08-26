defmodule LogParser do
  def valid_line?(line) do
    String.match?(line, ~r/^\[DEBUG\]|\[INFO\]|\[WARNING\]|\[ERROR\]/)
  end

  def split_line(line) do
    Regex.split(~r/\<[\~|\*|\=|\-]+\>|\<\>/, line)
  end

  def remove_artifacts(line) do
    String.replace(line, ~r/end-of-line\d+/i, "")
  end

  def tag_with_user_name(line) do
    map = Regex.run(~r/.*User[\s\n]+(\S+)[\s\n]*.*$/, line)

    cond do
      map == nil ->
        line

      true ->
        [all, user] = map
        "[USER] #{user} #{all}"
    end
  end
end

# IO.inspect(LogParser.valid_line?("[INFO]My name is Bob"))
#
# IO.inspect(
#   LogParser.split_line(
#     "[INFO] Start.<>[INFO] Processing...<~*->[INFO] Success. <==>[INFO] Complete!"
#   )
# )
#
# IO.inspect(LogParser.remove_artifacts("[WARNING] END-of-line23033 Network Failure end-of-line27"))
#
IO.inspect(LogParser.tag_with_user_name("[WARN] User James123 has exceeded storage space"))
IO.inspect(LogParser.tag_with_user_name("[DEBUG] Process started"))

IO.inspect(
  LogParser.tag_with_user_name("[ERROR] User\t!!!\tdoes not have a valid payment method")
)

IO.inspect(LogParser.tag_with_user_name("[INFO] New log in for User __JOHNNY__"))
IO.inspect(LogParser.tag_with_user_name("[DEBUG] Created User\nAlice908101\nat 14:02"))
