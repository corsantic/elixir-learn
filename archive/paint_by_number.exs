defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    palette_bit_size(color_count, 1)
  end

  defp palette_bit_size(color_count, bit_size) do
    if(2 ** bit_size >= color_count) do
      bit_size
    else
      palette_bit_size(color_count, bit_size + 1)
    end
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<00::2, 01::2, 10::2, 11::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    bit_size = palette_bit_size(color_count)
    <<pixel_color_index::size(bit_size), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _), do: nil

  def get_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)
    <<first::size(bit_size), _::bitstring>> = picture
    first
  end

  def drop_first_pixel(<<>>, _), do: <<>>

  def drop_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)
    <<_::size(bit_size), rest::bitstring>> = picture
    <<rest::bitstring>>
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end

IO.inspect(PaintByNumber.palette_bit_size(10))
IO.inspect(PaintByNumber.empty_picture())
IO.inspect(PaintByNumber.test_picture())

picture = <<2::4, 0::4>>
color_count = 13
pixel_color_index = 11

IO.inspect(PaintByNumber.prepend_pixel(picture, color_count, pixel_color_index))

picture = <<20::5, 2::5, 18::5>>
color_count = 20

IO.inspect(PaintByNumber.get_first_pixel(picture, color_count))

picture = <<2::3, 5::3, 5::3, 0::3>>
color_count = 6

IO.inspect(PaintByNumber.drop_first_pixel(picture, color_count))

picture1 = <<52::6, 51::6>>
picture2 = <<0::6, 34::6, 12::6>>

IO.inspect(PaintByNumber.concat_pictures(picture1, picture2))
