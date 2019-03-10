defmodule RubiksTimer do
  @moduledoc """
  Documentation for Rubiks Timer.
  """
  @behaviour Ratatouille.App

  import Ratatouille.View
  import Ratatouille.Constants, only: [key: 1]
  alias Ratatouille.Runtime.Subscription

  @spacebar key(:space)

  def init(_context) do
    %{
      timer_running: false,
      init_time: DateTime.utc_now(),
      time: 0,
      times: [],
      scramble: get_scramble(),
      solves: %{}
    }
  end

  def update(model, msg) do
    %{
      init_time: init_time,
      timer_running: timer_running,
      times: times,
      time: time,
      scramble: scramble,
      solves: solves
    } = model

    case msg do
      {:event, %{key: @spacebar}} ->
        if timer_running do
          %{
            model | timer_running: !timer_running,
            solves: Map.put(solves, simplify(scramble), time),
            scramble: get_scramble(),
            times: [time | times],
          }
        else
          %{model | timer_running: !timer_running, init_time: DateTime.utc_now(), time: 0}
        end

      {:event, %{ch: ?s}} ->
        %{model | scramble: get_scramble()}

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
        column(size: 2) do
        end
        column(size: 8) do
          panel title: "Instructions" do
            label(content: "This is a simple cube timer. Inspired by http://www.cubetimer.com")
            label(content: "A new scramble will be generated each time you stop the timer")
            label(content: "COMMANDS:")
            label(content: "spacebar -  start/stop the timer")
            label(content: "'S' - generate a new scramble without starting the timer")
          end
        end
        column(size: 2) do
        end
      end

      row do
        column(size: 2) do
        end
        column(size: 8) do
          panel title: "Scramble" do
            label(content: model[:scramble])
          end
        end
        column(size: 2) do
        end
      end

      row do
        column(size: 2) do
        end
        column(size: 8) do
          row do
            column(size: 8) do
              panel title: "Time" do
                label(content: "Current time: #{model[:time]}s")
              end

              panel title: "All times" do
                table(solve_times)
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
                    table_cell(content: "#{get_average(model[:times])}")
                  end

                  table_row do
                    table_cell(content: "Average 10:")
                    table_cell(content: "#{get_average(model[:times])}")
                  end
                end
              end
            end
          end
        end
        column(size: 2) do
        end
      end
    end
  end

  def get_children(solves) do
    solves
    |> Enum.map(fn {k, v} ->
      [
        table_row([table_cell(content: "#{k}")]),
        table_row([table_cell(content: "#{v}")])
      ]
    end)
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

  defp get_best([]), do: "-"
  defp get_best(times), do: Enum.min(times)

  defp get_average([]), do: "-"
  defp get_average(times), do: Enum.sum(times) / Kernel.length(times)

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
    if is_list(tail) and List.first(tail) =~ "T", do: remove_self -- ["T", "T'", "T2"], else: remove_self
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
