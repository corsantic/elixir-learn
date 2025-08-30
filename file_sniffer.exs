defmodule FileSniffer do
  def type_from_extension("exe"), do: "application/octet-stream"
  def type_from_extension("jpg"), do: "image/jpg"
  def type_from_extension("png"), do: "image/png"
  def type_from_extension("gif"), do: "image/gif"
  def type_from_extension("bmp"), do: "image/bmp"
  def type_from_extension(_), do: nil

  def type_from_binary(<<0xFF, 0xD8, 0xFF, _::binary>>), do: type_from_extension("jpg")
  def type_from_binary(<<0x7F, 0x45, 0x4C, 0x46, _::binary>>), do: type_from_extension("exe")
  def type_from_binary(<<0x42, 0x4D, _::binary>>), do: type_from_extension("bmp")

  def type_from_binary(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>>),
    do: type_from_extension("png")

  def type_from_binary(<<0x47, 0x49, 0x46, _::binary>>), do: type_from_extension("gif")
  def type_from_binary(_), do: nil

  def verify(file_binary, extension) do
    type_from_extension = type_from_extension(extension)

    cond do
      type_from_extension != nil and type_from_binary(file_binary) == type_from_extension ->
        {:ok, type_from_extension}

      true ->
        {:error, "Warning, file format and file extension do not match."}
    end
  end
end

file = File.read!("coffee.jpg")

IO.inspect(FileSniffer.type_from_binary(file))

IO.inspect(FileSniffer.type_from_extension("exe"))

IO.inspect(FileSniffer.verify(file, "sdas"))
