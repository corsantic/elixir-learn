defmodule Username do
  def sanitize(~c""), do: ~c""

  def sanitize([h | t]) do
    char =
      case h do
        ?ä -> ~c"ae"
        ?ö -> ~c"oe"
        ?ü -> ~c"ue"
        ?ß -> ~c"ss"
        x when x >= ?a and x <= ?z -> [x]
        ?_ -> ~c"_"
        _ -> ~c""
      end

    char ++ sanitize(t)
  end
end

IO.inspect(Username.sanitize(~c"cäcilie_weiß"))
