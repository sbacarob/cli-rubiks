defmodule RubiksTimer.Scrambler do

  def get_scramble() do
    Stream.unfold(Enum.random(valid_tokens(nil)), fn x ->
      new_token = Enum.random(valid_tokens(x))
      {new_token, [new_token | x]}
    end)
    |> Enum.take(24)
    |> Enum.join(", ")
  end

  def valid_tokens([t | tail]) do
    get_move_face(t)
    |> remove_redundant_moves(tail)
  end

  def valid_tokens(_), do: all_tokens()

  defp remove_redundant_moves(face, tail) when is_list(tail) do
    previous_face = tail
      |> List.first()
      |> get_move_face()

    if previous_face == opposite_face(face) do
      (all_tokens() -- face_moves()[face]) -- face_moves()[previous_face]
    else
      all_tokens() -- face_moves()[face]
    end
  end

  defp remove_redundant_moves(face, _tail), do: all_tokens() -- face_moves()[face]

  def all_tokens() do
    face_moves()
    |> Map.values()
    |> List.flatten()
  end

  defp face_moves do
    %{
      "L" => ["L", "L'", "L2"],
      "R" => ["R", "R'", "R2"],
      "D" => ["D", "D'", "D2"],
      "U" => ["U", "U'", "U2"],
      "F" => ["F", "F'", "F2"],
      "B" => ["B", "B'", "B2"]
    }
  end

  defp get_move_face(move) do
    face_moves()
    |> Enum.find(fn {_k, v} -> move in v end)
    |> elem(0)
  end

  defp opposite_face("L"), do: "R"
  defp opposite_face("R"), do: "L"
  defp opposite_face("U"), do: "D"
  defp opposite_face("D"), do: "U"
  defp opposite_face("F"), do: "B"
  defp opposite_face("B"), do: "F"

end
