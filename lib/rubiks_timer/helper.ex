defmodule RubiksTimer.Helper do

  import Ratatouille.View

  def get_children(solves) do
    solves
    |> Enum.map(fn %{time: time} -> time end)
    |> Enum.take(10)
    |> Enum.with_index(1)
    |> Enum.map(fn {v, i} -> [ table_row([table_cell(content: "#{i}. #{v}")]) ] end)
  end

  def get_scramble() do
    Stream.unfold(Enum.random(valid_tokens(nil)), fn x ->
      new_token = Enum.random(valid_tokens(x))
      {new_token, [new_token | x]}
    end)
    |> Enum.take(24)
    |> Enum.join(", ")
  end

  def simplify(scramble) do
    scramble |> String.split(", ") |> Enum.join()
  end

  def save_solve_data(solves) do
    encoded = Jason.encode!(solves)

    File.write!("data/solves.json", encoded)
  end

  def get_historic_solves() do
    case File.read("data/solves.json") do
      {:error, _reason} -> []
      {:ok, contents} -> Jason.decode!(contents, keys: :atoms)
    end
  end

  def get_historic_times() do
    case File.read("data/solves.json") do
      {:error, _reason} -> []
      {:ok, contents} ->
        Jason.decode!(contents, keys: :atoms)
        |> Enum.map(fn x -> x[:time] end)
    end
  end

  def valid_tokens([t | tail]) when t in ["L", "L'", "L2"] do
    remove_self = all_tokens() -- ["L", "L'", "L2"]
    if is_list(tail) and List.first(tail) =~ "R", do: remove_self -- ["R", "R'", "R2"], else: remove_self
  end

  def valid_tokens([t | tail]) when t in ["U", "U'", "U2"] do
    remove_self = all_tokens() -- ["U", "U'", "U2"]
    if is_list(tail) and List.first(tail) =~ "D", do: remove_self -- ["D", "D'", "D2"], else: remove_self
  end

  def valid_tokens([t | tail]) when t in ["R", "R'", "R2"] do
    remove_self = all_tokens() -- ["R", "R'", "R2"]
    if is_list(tail) and List.first(tail) =~ "L", do: remove_self -- ["L", "L'", "L2"], else: remove_self
  end

  def valid_tokens([t | tail]) when t in ["F", "F'", "F2"] do
    remove_self = all_tokens() -- ["F", "F'", "F2"]
    if is_list(tail) and List.first(tail) =~ "B", do: remove_self -- ["B", "B'", "B2"], else: remove_self
  end

  def valid_tokens([t | tail]) when t in ["B", "B'", "B2"] do
    remove_self = all_tokens() -- ["B", "B'", "B2"]
    if is_list(tail) and List.first(tail) =~ "F", do: remove_self -- ["F", "F'", "F2"], else: remove_self
  end

  def valid_tokens([t | tail]) when t in ["D", "D'", "D2"] do
    remove_self = all_tokens() -- ["D", "D'", "D2"]
    if is_list(tail) and List.first(tail) =~ "U", do: remove_self -- ["U", "U'", "U2"], else: remove_self
  end

  def valid_tokens(_), do: all_tokens()

  def all_tokens() do
    [
      "L", "L'", "L2",
      "R", "R'", "R2",
      "U", "U'", "U2",
      "D", "D'", "D2",
      "F", "F'", "F2",
      "B", "B'", "B2"
    ]
  end
end
