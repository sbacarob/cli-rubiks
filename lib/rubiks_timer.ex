defmodule RubiksTimer do
  @moduledoc """
  Documentation for Rubiks Timer.
  """
  @behaviour Ratatouille.App

  import Ratatouille.View
  import Ratatouille.Constants, only: [key: 1, color: 1]
  import RubiksTimer.{Helper, Scrambler, Stats}

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
            label(content: "'Q' - Close the timer. This won't save your solves")
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
end

Ratatouille.run(RubiksTimer, interval: 10)
