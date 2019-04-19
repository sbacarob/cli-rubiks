defmodule RubiksTimer do
  @moduledoc """
  Documentation for Rubiks Timer.
  """
  @behaviour Ratatouille.App

  import Ratatouille.View
  import Ratatouille.Constants, only: [key: 1, color: 1]
  alias Ratatouille.Runtime.Subscription

  @spacebar key(:space)
  @red color(:red)
  @blue color(:blue)
  @white color(:white)
  @green color(:green)
  @magenta color(:magenta)
  @yellow color(:yellow)

  def init(_context) do
    %{
      timer_running: false,
      init_time: DateTime.utc_now(),
      time: 0,
      times: get_historic_times(),
      scramble: get_scramble(),
      solves: get_historic_solves()
    }
  end

  def update(model, msg) do
    %{
      init_time: init_time,
      timer_running: timer_running,
      times: times,
      time: time,
      solves: solves,
      scramble: scramble,
    } = model

    case msg do
      {:event, %{key: @spacebar}} ->
        if timer_running do
          %{
            model | solves: [%{scramble: scramble, date: DateTime.utc_now(), time: time} | solves],
            timer_running: !timer_running,
            scramble: get_scramble(),
            times: [time | times],
          }
        else
          %{model | timer_running: !timer_running, init_time: DateTime.utc_now(), time: 0}
        end

      {:event, %{ch: ?s}} ->
        %{model | scramble: get_scramble()}

      {:event, %{ch: ?g}} ->
        save_solve_data(solves)
        model

      :tick ->
        if timer_running do
          %{model | time: DateTime.diff(DateTime.utc_now(), init_time, :microsecond) / 1000000}
        else
          model
        end
      _ -> model
    end
  end

  def subscribe(_model) do
    Subscription.interval(1, :tick)
  end

  def render(model) do
    solve_times = model |> Map.get(:solves) |> get_children
    view() do
      row do
        column(size: 12) do
          panel title: "Instructions" do
            label(content: "COMMANDS:")
            label(content: "spacebar -  start/stop the timer")
            label(content: "'S' - generate a new scramble without starting the timer")
            label(content: "'G' - save the data for the current session")
          end
        end
      end

      row do
        column(size: 12) do
          panel title: "Scramble" do
            label(content: model[:scramble])
          end
        end
      end

      row do
        column(size: 12) do
          row do
            column(size: 8) do
              panel title: "Time" do
                label(content: "Current time: #{model[:time]}s")
              end

              row do
                column(size: 8) do

                  panel title: "Cube State" do
                    table do
                      table_row do
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: "W", color: @white)
                        table_cell(content: "W", color: @white)
                        table_cell(content: "W", color: @white)
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                      end
                      table_row do
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: "W", color: @white)
                        table_cell(content: "W", color: @white)
                        table_cell(content: "W", color: @white)
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                      end
                      table_row do
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: "W", color: @white)
                        table_cell(content: "W", color: @white)
                        table_cell(content: "W", color: @white)
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                      end

                      table_row do
                        table_cell(content: "O", color: @magenta)
                        table_cell(content: "O", color: @magenta)
                        table_cell(content: "O", color: @magenta)
                        table_cell(content: "G", color: @green)
                        table_cell(content: "G", color: @green)
                        table_cell(content: "G", color: @green)
                        table_cell(content: "R", color: @red)
                        table_cell(content: "R", color: @red)
                        table_cell(content: "R", color: @red)
                        table_cell(content: "B", color: @blue)
                        table_cell(content: "B", color: @blue)
                        table_cell(content: "B", color: @blue)
                      end
                      table_row do
                        table_cell(content: "O", color: @magenta)
                        table_cell(content: "O", color: @magenta)
                        table_cell(content: "O", color: @magenta)
                        table_cell(content: "G", color: @green)
                        table_cell(content: "G", color: @green)
                        table_cell(content: "G", color: @green)
                        table_cell(content: "R", color: @red)
                        table_cell(content: "R", color: @red)
                        table_cell(content: "R", color: @red)
                        table_cell(content: "B", color: @blue)
                        table_cell(content: "B", color: @blue)
                        table_cell(content: "B", color: @blue)
                      end
                      table_row do
                        table_cell(content: "O", color: @magenta)
                        table_cell(content: "O", color: @magenta)
                        table_cell(content: "O", color: @magenta)
                        table_cell(content: "G", color: @green)
                        table_cell(content: "G", color: @green)
                        table_cell(content: "G", color: @green)
                        table_cell(content: "R", color: @red)
                        table_cell(content: "R", color: @red)
                        table_cell(content: "R", color: @red)
                        table_cell(content: "B", color: @blue)
                        table_cell(content: "B", color: @blue)
                        table_cell(content: "B", color: @blue)
                      end

                      table_row do
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: "Y", color: @yellow)
                        table_cell(content: "Y", color: @yellow)
                        table_cell(content: "Y", color: @yellow)
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                      end
                      table_row do
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: "Y", color: @yellow)
                        table_cell(content: "Y", color: @yellow)
                        table_cell(content: "Y", color: @yellow)
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                      end
                      table_row do
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: "Y", color: @yellow)
                        table_cell(content: "Y", color: @yellow)
                        table_cell(content: "Y", color: @yellow)
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                        table_cell(content: " ")
                      end
                    end
                  end
                end
              end
            end
            column(size: 4) do
              panel title: "Statistics" do
                table do
                  table_row do
                    table_cell(content: "Best:")
                    table_cell(content: "#{get_best(model[:times])}")
                  end

                  table_row do
                    table_cell(content: "Average:")
                    table_cell(content: "#{get_average(model[:times])}")
                  end

                  table_row do
                    table_cell(content: "Average 5:")
                    table_cell(content: "#{get_3_of_5(model[:times])}")
                  end

                  table_row do
                    table_cell(content: "Average 10:")
                    table_cell(content: "#{get_10_of_12(model[:times])}")
                  end
                end
              end

              panel title: "Last 10 times" do
                table(solve_times)
              end
            end
          end
        end
      end
    end
  end

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

  defp get_best([]), do: "-"
  defp get_best(times), do: Enum.min(times)

  defp get_average([]), do: "-"
  defp get_average(times), do: Enum.sum(times) / Kernel.length(times)

  defp get_3_of_5(times) when length(times) < 3, do: "-"
  defp get_3_of_5(times) do
    times
    |> Enum.take(5)
    |> Enum.sort()
    |> Enum.slice(1, 3)
    |> Enum.sum()
    |> Kernel./(3)
  end

  defp get_10_of_12(times) when length(times) < 12, do: "-"
  defp get_10_of_12(times) do
    times
    |> Enum.take(12)
    |> Enum.sort()
    |> Enum.slice(1, 10)
    |> Enum.sum()
    |> Kernel./(10)
  end

  defp valid_tokens([t | tail]) when t in ["L", "L'", "L2"] do
    remove_self = all_tokens() -- ["L", "L'", "L2"]
    if is_list(tail) and List.first(tail) =~ "R", do: remove_self -- ["R", "R'", "R2"], else: remove_self
  end

  defp valid_tokens([t | tail]) when t in ["U", "U'", "U2"] do
    remove_self = all_tokens() -- ["U", "U'", "U2"]
    if is_list(tail) and List.first(tail) =~ "D", do: remove_self -- ["D", "D'", "D2"], else: remove_self
  end

  defp valid_tokens([t | tail]) when t in ["R", "R'", "R2"] do
    remove_self = all_tokens() -- ["R", "R'", "R2"]
    if is_list(tail) and List.first(tail) =~ "L", do: remove_self -- ["L", "L'", "L2"], else: remove_self
  end

  defp valid_tokens([t | tail]) when t in ["F", "F'", "F2"] do
    remove_self = all_tokens() -- ["F", "F'", "F2"]
    if is_list(tail) and List.first(tail) =~ "B", do: remove_self -- ["B", "B'", "B2"], else: remove_self
  end

  defp valid_tokens([t | tail]) when t in ["B", "B'", "B2"] do
    remove_self = all_tokens() -- ["B", "B'", "B2"]
    if is_list(tail) and List.first(tail) =~ "F", do: remove_self -- ["F", "F'", "F2"], else: remove_self
  end

  defp valid_tokens([t | tail]) when t in ["D", "D'", "D2"] do
    remove_self = all_tokens() -- ["D", "D'", "D2"]
    if is_list(tail) and List.first(tail) =~ "U", do: remove_self -- ["U", "U'", "U2"], else: remove_self
  end

  defp valid_tokens(_), do: all_tokens()

  defp all_tokens() do
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

Ratatouille.run(RubiksTimer, interval: 10)
