defmodule RubiksTimer.NumberRenderer do
  
  import Ratatouille.View

  def render_big_number(number) do
    as_list = convert(number)

    Enum.with_index(as_list, 1)
    |> Enum.map(fn {v, i} -> 
      render_number(v, calculate_width(as_list, i))
    end)
  end

  def render_number(num, x \\ 0, y \\ 0)
  def render_number("0", x, y), do: number_0(x, y)
  def render_number("1", x, y), do: number_1(x, y)
  def render_number("2", x, y), do: number_2(x, y)
  def render_number("3", x, y), do: number_3(x, y)
  def render_number("4", x, y), do: number_4(x, y)
  def render_number("5", x, y), do: number_5(x, y)
  def render_number("6", x, y), do: number_6(x, y)
  def render_number("7", x, y), do: number_7(x, y)
  def render_number("8", x, y), do: number_8(x, y)
  def render_number("9", x, y), do: number_9(x, y)
  def render_number(".", x, y), do: dot(x, y)

  def width("0"), do: 7
  def width("1"), do: 3
  def width("2"), do: 7
  def width("3"), do: 7
  def width("4"), do: 8
  def width("5"), do: 7
  def width("6"), do: 7
  def width("7"), do: 7
  def width("8"), do: 7
  def width("9"), do: 7
  def width("."), do: 3

  defp convert(num) do
    as_list = to_string(num) |> String.split("")
    len = length(as_list)                       
    Enum.slice(as_list, 1, len - 2)             
  end

  defp calculate_width(list, up_to_index) do
    list
    |> Enum.slice(0, up_to_index)
    |> Enum.reduce(0, fn x, acc -> acc + width(x) end)
  end

  def number_0(x \\ 0, y \\ 0) do
    [
      canvas_cell(x: x + 2, y: y, char: "_"),
      canvas_cell(x: x + 3, y: y, char: "_"),
      canvas_cell(x: x + 4, y: y, char: "_"),
      canvas_cell(x: x + 1, y: y + 1, char: "/"),
      canvas_cell(x: x + 3, y: y + 1, char: "_"),
      canvas_cell(x: x + 5, y: y + 1, char: "\\"),
      canvas_cell(x: x, y: y + 2, char: "|"),
      canvas_cell(x: x + 2, y: y + 2, char: "|"),
      canvas_cell(x: x + 4, y: y + 2, char: "|"),
      canvas_cell(x: x + 6, y: y + 2, char: "|"),
      canvas_cell(x: x, y: y + 3, char: "|"),
      canvas_cell(x: x + 3, y: y + 3, char: "_"),
      canvas_cell(x: x + 2, y: y + 3, char: "|"),
      canvas_cell(x: x + 4, y: y + 3, char: "|"),
      canvas_cell(x: x + 6, y: y + 3, char: "|"),
      canvas_cell(x: x + 1, y: y + 4, char: "\\"),
      canvas_cell(x: x + 2, y: y + 4, char: "_"),
      canvas_cell(x: x + 3, y: y + 4, char: "_"),
      canvas_cell(x: x + 4, y: y + 4, char: "_"),
      canvas_cell(x: x + 5, y: y + 4, char: "/"),
    ]
  end

  def number_1(x \\ 0, y \\ 0) do
    [
      canvas_cell(x: x + 5, y: y, char: "_"),
      canvas_cell(x: x + 4, y: y + 1, char: "/"),
      canvas_cell(x: x + 6, y: y + 1, char: "|"),
      canvas_cell(x: x + 4, y: y + 2, char: "|"),
      canvas_cell(x: x + 6, y: y + 2, char: "|"),
      canvas_cell(x: x + 4, y: y + 3, char: "|"),
      canvas_cell(x: x + 6, y: y + 3, char: "|"),
      canvas_cell(x: x + 4, y: y + 4, char: "|"),
      canvas_cell(x: x + 5, y: y + 4, char: "_"),
      canvas_cell(x: x + 6, y: y + 4, char: "|"),
    ]
  end

  def number_2(x \\ 0, y \\ 0) do
    [
      canvas_cell(x: x + 1, y: y, char: "_"),
      canvas_cell(x: x + 2, y: y, char: "_"),
      canvas_cell(x: x + 3, y: y, char: "_"),
      canvas_cell(x: x + 4, y: y, char: "_"),
      canvas_cell(x: x, y: y + 1, char: "|"),
      canvas_cell(x: x + 1, y: y + 1, char: "_"),
      canvas_cell(x: x + 2, y: y + 1, char: "_"),
      canvas_cell(x: x + 3, y: y + 1, char: "_"),
      canvas_cell(x: x + 5, y: y + 1, char: "\\"),
      canvas_cell(x: x + 2, y: y + 2, char: "_"),
      canvas_cell(x: x + 3, y: y + 2, char: "_"),
      canvas_cell(x: x + 4, y: y + 2, char: ")"),
      canvas_cell(x: x + 6, y: y + 2, char: "|"),
      canvas_cell(x: x + 1, y: y + 3, char: "/"),
      canvas_cell(x: x + 3, y: y + 3, char: "_"),
      canvas_cell(x: x + 4, y: y + 3, char: "_"),
      canvas_cell(x: x + 5, y: y + 3, char: "/"),
      canvas_cell(x: x, y: y + 4, char: "|"),
      canvas_cell(x: x + 1, y: y + 4, char: "_"),
      canvas_cell(x: x + 2, y: y + 4, char: "_"),
      canvas_cell(x: x + 3, y: y + 4, char: "_"),
      canvas_cell(x: x + 4, y: y + 4, char: "_"),
      canvas_cell(x: x + 5, y: y + 4, char: "_"),
      canvas_cell(x: x + 6, y: y + 4, char: "|")
    ]
  end

  def number_3(x \\ 0, y \\ 0) do
    [
      canvas_cell(x: x + 1, y: y, char: "_"),
      canvas_cell(x: x + 2, y: y, char: "_"),
      canvas_cell(x: x + 3, y: y, char: "_"),
      canvas_cell(x: x + 4, y: y, char: "_"),
      canvas_cell(x: x + 5, y: y, char: "_"),
      canvas_cell(x: x, y: y + 1, char: "|"),
      canvas_cell(x: x + 1, y: y + 1, char: "_"),
      canvas_cell(x: x + 2, y: y + 1, char: "_"),
      canvas_cell(x: x + 3, y: y + 1, char: "_"),
      canvas_cell(x: x + 5, y: y + 1, char: "/"),
      canvas_cell(x: x + 2, y: y + 2, char: "|"),
      canvas_cell(x: x + 3, y: y + 2, char: "_"),
      canvas_cell(x: x + 5, y: y + 2, char: "\\"),
      canvas_cell(x: x + 1, y: y + 3, char: "_"),
      canvas_cell(x: x + 2, y: y + 3, char: "_"),
      canvas_cell(x: x + 3, y: y + 3, char: "_"),
      canvas_cell(x: x + 4, y: y + 3, char: ")"),
      canvas_cell(x: x + 6, y: y + 3, char: "|"),
      canvas_cell(x: x, y: y + 4, char: "|"),
      canvas_cell(x: x + 1, y: y + 4, char: "_"),
      canvas_cell(x: x + 2, y: y + 4, char: "_"),
      canvas_cell(x: x + 3, y: y + 4, char: "_"),
      canvas_cell(x: x + 4, y: y + 4, char: "_"),
      canvas_cell(x: x + 5, y: y + 4, char: "/")
    ]
  end

  def number_4(x \\ 0, y \\ 0) do
    [
      canvas_cell(x: x + 1, y: y, char: "_"),
      canvas_cell(x: x + 4, y: y, char: "_"),
      canvas_cell(x: x, y: y + 1, char: "|"),
      canvas_cell(x: x + 2, y: y + 1, char: "|"),
      canvas_cell(x: x + 3, y: y + 1, char: "|"),
      canvas_cell(x: x + 5, y: y + 1, char: "|"),
      canvas_cell(x: x, y: y + 2, char: "|"),
      canvas_cell(x: x + 2, y: y + 2, char: "|"),
      canvas_cell(x: x + 3, y: y + 2, char: "|"),
      canvas_cell(x: x + 5, y: y + 2, char: "|"),
      canvas_cell(x: x + 6, y: y + 2, char: "_"),
      canvas_cell(x: x, y: y + 3, char: "|"),
      canvas_cell(x: x + 1, y: y + 3, char: "_"),
      canvas_cell(x: x + 2, y: y + 3, char: "_"),
      canvas_cell(x: x + 6, y: y + 3, char: "_"),
      canvas_cell(x: x + 7, y: y + 3, char: "|"),
      canvas_cell(x: x + 3, y: y + 4, char: "|"),
      canvas_cell(x: x + 4, y: y + 4, char: "_"),
      canvas_cell(x: x + 5, y: y + 4, char: "|")
    ]
  end

  def number_5(x \\ 0, y \\ 0) do
    [
      canvas_cell(x: x + 1, y: y, char: "_"),
      canvas_cell(x: x + 2, y: y, char: "_"),
      canvas_cell(x: x + 3, y: y, char: "_"),
      canvas_cell(x: x + 4, y: y, char: "_"),
      canvas_cell(x: x, y: y + 1, char: "|"),
      canvas_cell(x: x + 2, y: y + 1, char: "_"),
      canvas_cell(x: x + 3, y: y + 1, char: "_"),
      canvas_cell(x: x + 4, y: y + 1, char: "_"),
      canvas_cell(x: x + 5, y: y + 1, char: "|"),
      canvas_cell(x: x, y: y + 2, char: "|"),
      canvas_cell(x: x + 1, y: y + 2, char: "_"),
      canvas_cell(x: x + 2, y: y + 2, char: "_"),
      canvas_cell(x: x + 3, y: y + 2, char: "_"),
      canvas_cell(x: x + 5, y: y + 2, char: "\\"),
      canvas_cell(x: x + 1, y: y + 3, char: "_"),
      canvas_cell(x: x + 2, y: y + 3, char: "_"),
      canvas_cell(x: x + 3, y: y + 3, char: "_"),
      canvas_cell(x: x + 4, y: y + 3, char: ")"),
      canvas_cell(x: x + 6, y: y + 3, char: "|"),
      canvas_cell(x: x, y: y + 4, char: "|"),
      canvas_cell(x: x + 1, y: y + 4, char: "_"),
      canvas_cell(x: x + 2, y: y + 4, char: "_"),
      canvas_cell(x: x + 3, y: y + 4, char: "_"),
      canvas_cell(x: x + 4, y: y + 4, char: "_"),
      canvas_cell(x: x + 5, y: y + 4, char: "/"),
    ]
  end

  def number_6(x \\ 0, y \\ 0) do
    [
      canvas_cell(x: x + 2, y: y, char: "_"),
      canvas_cell(x: x + 3, y: y, char: "_"),
      canvas_cell(x: x + 1, y: y + 1, char: "/"),
      canvas_cell(x: x + 3, y: y + 1, char: "/"),
      canvas_cell(x: x + 4, y: y + 1, char: "_"),
      canvas_cell(x: x, y: y + 2, char: "|"),
      canvas_cell(x: x + 2, y: y + 2, char: "'"),
      canvas_cell(x: x + 3, y: y + 2, char: "_"),
      canvas_cell(x: x + 5, y: y + 2, char: "\\"),
      canvas_cell(x: x, y: y + 3, char: "|"),
      canvas_cell(x: x + 2, y: y + 3, char: "("),
      canvas_cell(x: x + 3, y: y + 3, char: "_"),
      canvas_cell(x: x + 4, y: y + 3, char: ")"),
      canvas_cell(x: x + 6, y: y + 3, char: "|"),
      canvas_cell(x: x + 1, y: y + 4, char: "\\"),
      canvas_cell(x: x + 2, y: y + 4, char: "_"),
      canvas_cell(x: x + 3, y: y + 4, char: "_"),
      canvas_cell(x: x + 4, y: y + 4, char: "_"),
      canvas_cell(x: x + 5, y: y + 4, char: "/"),
    ]
  end

  def number_7(x \\ 0, y \\ 0) do
    [
      canvas_cell(x: x + 1, y: y, char: "_"),
      canvas_cell(x: x + 2, y: y, char: "_"),
      canvas_cell(x: x + 3, y: y, char: "_"),
      canvas_cell(x: x + 4, y: y, char: "_"),
      canvas_cell(x: x + 5, y: y, char: "_"),
      canvas_cell(x: x, y: y + 1, char: "|"),
      canvas_cell(x: x + 1, y: y + 1, char: "_"),
      canvas_cell(x: x + 2, y: y + 1, char: "_"),
      canvas_cell(x: x + 3, y: y + 1, char: "_"),
      canvas_cell(x: x + 6, y: y + 1, char: "|"),
      canvas_cell(x: x + 3, y: y + 2, char: "/"),
      canvas_cell(x: x + 5, y: y + 2, char: "/"),
      canvas_cell(x: x + 2, y: y + 3, char: "/"),
      canvas_cell(x: x + 4, y: y + 3, char: "/"),
      canvas_cell(x: x + 1, y: y + 4, char: "/"),
      canvas_cell(x: x + 2, y: y + 4, char: "_"),
      canvas_cell(x: x + 3, y: y + 4, char: "/"),
    ]
  end

  def number_8(x \\ 0, y \\ 0) do
    [
      canvas_cell(x: x + 2, y: y, char: "_"),
      canvas_cell(x: x + 3, y: y, char: "_"),
      canvas_cell(x: x + 4, y: y, char: "_"),
      canvas_cell(x: x + 1, y: y + 1, char: "("),
      canvas_cell(x: x + 3, y: y + 1, char: "_"),
      canvas_cell(x: x + 5, y: y + 1, char: ")"),
      canvas_cell(x: x + 1, y: y + 2, char: "/"),
      canvas_cell(x: x + 3, y: y + 2, char: "_"),
      canvas_cell(x: x + 5, y: y + 2, char: "\\"),
      canvas_cell(x: x, y: y + 3, char: "|"),
      canvas_cell(x: x + 2, y: y + 3, char: "("),
      canvas_cell(x: x + 3, y: y + 3, char: "_"),
      canvas_cell(x: x + 4, y: y + 3, char: ")"),
      canvas_cell(x: x + 6, y: y + 3, char: "|"),
      canvas_cell(x: x + 1, y: y + 4, char: "\\"),
      canvas_cell(x: x + 2, y: y + 4, char: "_"),
      canvas_cell(x: x + 3, y: y + 4, char: "_"),
      canvas_cell(x: x + 4, y: y + 4, char: "_"),
      canvas_cell(x: x + 5, y: y + 4, char: "/")
    ]
  end

  def number_9(x \\ 0, y \\ 0) do
    [
      canvas_cell(x: x + 2, y: y, char: "_"),
      canvas_cell(x: x + 3, y: y, char: "_"),
      canvas_cell(x: x + 4, y: y, char: "_"),
      canvas_cell(x: x + 1, y: y + 1, char: "/"),
      canvas_cell(x: x + 3, y: y + 1, char: "_"),
      canvas_cell(x: x + 5, y: y + 1, char: "\\"),
      canvas_cell(x: x, y: y + 2, char: "|"),
      canvas_cell(x: x + 2, y: y + 2, char: "("),
      canvas_cell(x: x + 3, y: y + 2, char: "_"),
      canvas_cell(x: x + 4, y: y + 2, char: ")"),
      canvas_cell(x: x + 6, y: y + 2, char: "|"),
      canvas_cell(x: x + 1, y: y + 3, char: "\\"),
      canvas_cell(x: x + 2, y: y + 3, char: "_"),
      canvas_cell(x: x + 3, y: y + 3, char: "_"),
      canvas_cell(x: x + 4, y: y + 3, char: ","),
      canvas_cell(x: x + 6, y: y + 3, char: "|"),
      canvas_cell(x: x + 3, y: y + 4, char: "/"),
      canvas_cell(x: x + 4, y: y + 4, char: "_"),
      canvas_cell(x: x + 5, y: y + 4, char: "/"),
    ]
  end

  def dot(x \\ 0, y \\ 0) do
    [
      canvas_cell(x: x + 5, y: y + 3, char: "_"),
      canvas_cell(x: x + 4, y: y + 4, char: "("),
      canvas_cell(x: x + 5, y: y + 4, char: "_"),
      canvas_cell(x: x + 6, y: y + 4, char: ")"),
    ]
  end

end
