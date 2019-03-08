defmodule Counter do
  @moduledoc """
  Documentation for Counter.
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
      scramble: get_scramble()}
  end

  def update(%{init_time: init_time, timer_running: timer_running, times: times, time: time} = model, msg) do
    case msg do
      {:event, %{key: @spacebar}} ->
        if timer_running do
          %{model | timer_running: !timer_running, scramble: get_scramble(), times: [time | times]}
        else
          %{model | timer_running: !timer_running, init_time: DateTime.utc_now(), time: 0}
        end

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
    top_bar =
      bar do
        label(content: "This is a cube timer inspired by http://www.cubetimer.com")
      end

    view(top_bar: top_bar) do
      row do
        column(size: 2) do
        end
        column(size: 8) do
          panel title: "Instructions" do
            label(content: "This is a cube timer. You can start/stop it by pressing the space bar")
            label(content: "Or if you prefer, you can place two fingers on your")
            label(content: "trackpad and move them backwards to begin or forwards to stop")
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

  def get_scramble() do
    Stream.unfold(Enum.random(valid_tokens(nil)), fn x ->
      new_token = Enum.random(valid_tokens(x))
      {new_token, [new_token | x]}
    end)
    |> Enum.take(24)
    |> Enum.join(", ")
  end

  defp get_best([]), do: "-"
  defp get_best(times), do: Enum.min(times)

  defp get_average([]), do: "-"
  defp get_average(times), do: Enum.sum(times) / Kernel.length(times)

  defp valid_tokens([t | _]) when t in ["L", "L'", "L2"], do: all_tokens() -- ["L", "L'", "L2"]
  defp valid_tokens([t | _]) when t in ["U", "U'", "U2"], do: all_tokens() -- ["U", "U'", "U2"]
  defp valid_tokens([t | _]) when t in ["R", "R'", "R2"], do: all_tokens() -- ["R", "R'", "R2"]
  defp valid_tokens([t | _]) when t in ["F", "F'", "F2"], do: all_tokens() -- ["F", "F'", "F2"]
  defp valid_tokens([t | _]) when t in ["B", "B'", "B2"], do: all_tokens() -- ["B", "B'", "B2"]
  defp valid_tokens([t | _]) when t in ["D", "D'", "D2"], do: all_tokens() -- ["D", "D'", "D2"]
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

Ratatouille.run(Counter, interval: 10)
