defmodule RubiksTimer.Helper do

  import Ratatouille.View

  def get_children(solves) do
    solves
    |> Enum.map(fn %{time: time} -> time end)
    |> Enum.take(10)
    |> Enum.with_index(1)
    |> Enum.map(fn {v, i} -> [ table_row([table_cell(content: "#{i}. #{v}")]) ] end)
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
end
