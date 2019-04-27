defmodule RubiksTimer.Helper do

  import Ratatouille.View
  import Ratatouille.Constants, only: [color: 1, attribute: 1]

  @red color(:red)
  @green color(:green)
  @blue color(:blue)
  @bold attribute(:bold)

  def get_children(solves) do
    times = solves
      |> Enum.map(fn %{time: time} -> time end)
      |> Enum.take(10)

    times
    |> Enum.with_index(1)
    |> Enum.map(fn
      {v, i} ->
        cond do
          v == Enum.min(times) ->
            [ table_row([table_cell(content: "#{i}. #{v}", color: @green)]) ]
          v == Enum.max(times) ->
            [ table_row([table_cell(content: "#{i}. #{v}", color: @red)]) ]
          true ->
            [ table_row([table_cell(content: "#{i}. #{v}")]) ]
        end
    end)
  end

  def get_time_frequencies(solves) do
    data = solves
      |> to_histogram()
      |> Enum.map(fn
       {k, v} ->
          [ table_row([
            table_cell(content: "#{k}.00 - #{k + 0.99}"),
            table_cell(content: "#{v}")
          ]) ]
      end)

    header = [[table_row([
      table_cell(content: "Range", color: @blue, attributes: [@bold]),
      table_cell(content: "# of times", color: @blue, attributes: [@bold])
    ])]]

    header ++ data
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

  def to_histogram(solves) do
    solves
    |> Enum.group_by(fn %{time: time} -> Kernel.trunc(time) end)
    |> Enum.map(fn {k, v} -> {k, length(v)} end)
    |> Map.new()
  end

  def get_autosave_state(true), do: "enabled"
  def get_autosave_state(false), do: "disabled"

  def get_labels_from_scramble(scramble) do
    scramble
    |> String.split(", ")
    |> Enum.chunk_every(5)
    |> Enum.map(fn portion ->
      label(content: Enum.join(portion, ", "), attributes: [@bold], color: @blue)
    end)
  end
end
