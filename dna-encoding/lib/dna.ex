defmodule DNA do
  @nucleic_acid_map %{
    ?\s => 0b0000,
    ?A => 0b0001,
    ?C => 0b0010,
    ?G => 0b0100,
    ?T => 0b1000
  }
  def encode_nucleotide(char), do: @nucleic_acid_map[char]

  def decode_nucleotide(code) do
    {char, _} = Enum.find(@nucleic_acid_map, fn {_, v} -> v == code end)
    char
  end

  def encode(dna) do
    encode(dna, <<>>)
  end

  defp encode([], acc), do: acc

  defp encode([char | rest], acc) do
    encode(rest, <<acc::bitstring, encode_nucleotide(char)::4>>)
  end

  def decode(dna) do
    decode(dna, [])
  end

  defp decode(<<>>, acc), do: reverse(acc, [])

  defp decode(<<code::4, rest::bitstring>>, acc) do
    decode(rest, [decode_nucleotide(code) | acc])
  end

  defp reverse([], acc), do: acc
  defp reverse([h | t], acc), do: reverse(t, [h | acc])

end
