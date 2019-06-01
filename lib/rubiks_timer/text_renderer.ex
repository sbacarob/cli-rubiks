defmodule RubiksTimer.TextRenderer do
  
  import Ratatouille.View

  def render_text(-1) do
    as_list = ["D", "N", "F"]

    Enum.with_index(as_list, 1)
    |> Enum.map(fn {v, i} ->
      render_char(v, calculate_width(as_list, i))
    end)
  end
  def render_text(number) do
    as_list = convert(number)

    Enum.with_index(as_list, 1)
    |> Enum.map(fn {v, i} -> 
      render_char(v, calculate_width(as_list, i))
    end)
  end

  def render_char(num, x \\ 0, y \\ 0)
  def render_char("0", x, y), do: number_0(x, y)
  def render_char("1", x, y), do: number_1(x, y)
  def render_char("2", x, y), do: number_2(x, y)
  def render_char("3", x, y), do: number_3(x, y)
  def render_char("4", x, y), do: number_4(x, y)
  def render_char("5", x, y), do: number_5(x, y)
  def render_char("6", x, y), do: number_6(x, y)
  def render_char("7", x, y), do: number_7(x, y)
  def render_char("8", x, y), do: number_8(x, y)
  def render_char("9", x, y), do: number_9(x, y)
  def render_char("D", x, y), do: letter_d(x, y)
  def render_char("N", x, y), do: letter_n(x, y)
  def render_char("F", x, y), do: letter_f(x, y)
  def render_char(".", x, y), do: dot(x, y)
  def render_char("-", x, y), do: dash(x, y)

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
  def width("-"), do: 7
  def width("D"), do: 7
  def width("N"), do: 7
  def width("F"), do: 7

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

  def letter_d(x \\ 0, y \\ 0) do
    [
      canvas_cell(x: x + 1, y: y, char: "_"),
      canvas_cell(x: x + 2, y: y, char: "_"),
      canvas_cell(x: x + 3, y: y, char: "_"),
      canvas_cell(x: x + 4, y: y, char: "_"),
      canvas_cell(x: x, y: y + 1, char: "|"),
      canvas_cell(x: x + 3, y: y + 1, char: "_"),
      canvas_cell(x: x + 5, y: y + 1, char: "\\"),
      canvas_cell(x: x, y: y + 2, char: "|"),
      canvas_cell(x: x + 2, y: y + 2, char: "|"),
      canvas_cell(x: x + 4, y: y + 2, char: "|"),
      canvas_cell(x: x + 6, y: y + 2, char: "|"),
      canvas_cell(x: x, y: y + 3, char: "|"),
      canvas_cell(x: x + 2, y: y + 3, char: "|"),
      canvas_cell(x: x + 3, y: y + 3, char: "_"),
      canvas_cell(x: x + 4, y: y + 3, char: "|"),
      canvas_cell(x: x + 6, y: y + 3, char: "|"),
      canvas_cell(x: x, y: y + 4, char: "|"),
      canvas_cell(x: x + 1, y: y + 4, char: "_"),
      canvas_cell(x: x + 2, y: y + 4, char: "_"),
      canvas_cell(x: x + 3, y: y + 4, char: "_"),
      canvas_cell(x: x + 4, y: y + 4, char: "_"),
      canvas_cell(x: x + 5, y: y + 4, char: "/"),
    ]
  end

  def letter_n(x \\ 0, y \\ 0) do
    [
      canvas_cell(x: x + 1, y: y, char: "_"),
      canvas_cell(x: x + 5, y: y, char: "_"),
      canvas_cell(x: x, y: y + 1, char: "|"),
      canvas_cell(x: x + 2, y: y + 1, char: "\\"),
      canvas_cell(x: x + 4, y: y + 1, char: "|"),
      canvas_cell(x: x + 6, y: y + 1, char: "|"),
      canvas_cell(x: x, y: y + 2, char: "|"),
      canvas_cell(x: x + 3, y: y + 2, char: "\\"),
      canvas_cell(x: x + 4, y: y + 2, char: "|"),
      canvas_cell(x: x + 6, y: y + 2, char: "|"),
      canvas_cell(x: x, y: y + 3, char: "|"),
      canvas_cell(x: x + 2, y: y + 3, char: "|"),
      canvas_cell(x: x + 3, y: y + 3, char: "\\"),
      canvas_cell(x: x + 6, y: y + 3, char: "|"),
      canvas_cell(x: x, y: y + 4, char: "|"),
      canvas_cell(x: x + 1, y: y + 4, char: "_"),
      canvas_cell(x: x + 2, y: y + 4, char: "|"),
      canvas_cell(x: x + 4, y: y + 4, char: "\\"),
      canvas_cell(x: x + 5, y: y + 4, char: "_"),
      canvas_cell(x: x + 6, y: y + 4, char: "|")
    ]
  end

  def letter_f(x \\ 0, y \\ 0) do
    [
      canvas_cell(x: x + 1, y: y, char: "_"),
      canvas_cell(x: x + 2, y: y, char: "_"),
      canvas_cell(x: x + 3, y: y, char: "_"),
      canvas_cell(x: x + 4, y: y, char: "_"),
      canvas_cell(x: x + 5, y: y, char: "_"),
      canvas_cell(x: x, y: y + 1, char: "|"),
      canvas_cell(x: x + 3, y: y + 1, char: "_"),
      canvas_cell(x: x + 4, y: y + 1, char: "_"),
      canvas_cell(x: x + 5, y: y + 1, char: "_"),
      canvas_cell(x: x + 6, y: y + 1, char: "|"),
      canvas_cell(x: x, y: y + 2, char: "|"),
      canvas_cell(x: x + 2, y: y + 2, char: "|"),
      canvas_cell(x: x + 3, y: y + 2, char: "_"),
      canvas_cell(x: x, y: y + 3, char: "|"),
      canvas_cell(x: x + 3, y: y + 3, char: "_"),
      canvas_cell(x: x + 4, y: y + 3, char: "|"),
      canvas_cell(x: x, y: y + 4, char: "|"),
      canvas_cell(x: x + 1, y: y + 4, char: "_"),
      canvas_cell(x: x + 2, y: y + 4, char: "|"),
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

  def dash(x \\ 0, y \\ 0) do
    [
      canvas_cell(x: x + 1, y: y + 1, char: "_"),
      canvas_cell(x: x + 2, y: y + 1, char: "_"),
      canvas_cell(x: x + 3, y: y + 1, char: "_"),
      canvas_cell(x: x + 4, y: y + 1, char: "_"),
      canvas_cell(x: x + 5, y: y + 1, char: "_"),
      canvas_cell(x: x, y: y + 2, char: "|"),
      canvas_cell(x: x + 1, y: y + 2, char: "_"),
      canvas_cell(x: x + 2, y: y + 2, char: "_"),
      canvas_cell(x: x + 3, y: y + 2, char: "_"),
      canvas_cell(x: x + 4, y: y + 2, char: "_"),
      canvas_cell(x: x + 5, y: y + 2, char: "_"),
      canvas_cell(x: x + 6, y: y + 2, char: "|")
    ]
  end

end
