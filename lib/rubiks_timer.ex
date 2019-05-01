defmodule RubiksTimer do
  @moduledoc """
  Documentation for Rubiks Timer.
  """
  @behaviour Ratatouille.App

  import Ratatouille.View
  import Ratatouille.Constants, only: [key: 1, color: 1, attribute: 1]
  import RubiksTimer.{Helper, Scrambler, Stats, NumberRenderer}

  alias Ratatouille.Runtime.Subscription

  @spacebar key(:space)
  @green color(:green)
  @white color(:white)
  @bold attribute(:bold)

  def init(_context) do
    %{
      timer_running: false,
      init_time: DateTime.utc_now(),
      time: 0.0,
      times: get_historic_times(),
      scramble: get_scramble(),
      solves: get_historic_solves(),
      instructions_showing: false,
      autosave_enabled: true,
      display_time_visuals: false,
      visualize_times_history: false
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
      instructions_showing: instructions_showing,
      autosave_enabled: autosave_enabled,
      display_time_visuals: display_time_visuals,
      visualize_times_history: visualize_times_history
    } = model

    case msg do
      {:event, %{key: @spacebar}} ->
        if timer_running do
          solves = [%{scramble: scramble, date: DateTime.utc_now(), time: time} | solves]

          if autosave_enabled, do: save_solve_data(solves)

          %{
            model | solves: solves,
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

      {:event, %{ch: ?i}} ->
        %{model | instructions_showing: !instructions_showing}

      {:event, %{ch: ?a}} ->
        %{model | autosave_enabled: !autosave_enabled}

      {:event, %{ch: ?t}} ->
        %{model | display_time_visuals: !display_time_visuals}

      {:event, %{ch: ?h}} ->
        %{model | visualize_times_history: !visualize_times_history}

      {:event, %{ch: ?d}} ->
        solves = Enum.slice(solves, 1, length(solves))

        if autosave_enabled, do: save_solve_data(solves)

        %{model | times: Enum.slice(times, 1, length(times)),
          time: 0.0,
          solves: solves
        }

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
            label(content: "spacebar -  start/stop the timer")
            label(content: "'Q' - Close the application")
            label(content: "'I' - Show/hide display complete instructions")
            label(content: "autosave #{get_autosave_state(model.autosave_enabled)}", attributes: [@bold])
          end
        end
      end

      row do
        column(size: 3) do
          panel title: "Scramble", height: 11 do
            get_labels_from_scramble(model[:scramble])
          end
        end

        column(size: 9) do

          panel title: "Time" do
            canvas(height: 8, width: 100) do
              render_big_number(model[:time])
            end
          end

        end

      end

      row do
        column(size: 12) do
          row do

            column(size: 3) do

              panel title: "Last 10 times" do
                table(solve_times)
              end

            end


            column(size: 9) do

              panel title: "Statistics" do

                table do
                  table_row do
                    table_cell(content: "Stat", color: @white, attributes: [@bold])
                    table_cell(content: "Last", color: @white, attributes: [@bold])
                    table_cell(content: "Best", color: @white, attributes: [@bold])
                  end

                  table_row do
                    table_cell(content: "Single")
                    table_cell(content: "#{List.first(model.times)}")
                    table_cell(content: "#{get_best(model.times)}", color: @green)
                  end

                  table_row do
                    table_cell(content: "Average of 5")
                    table_cell(content: "#{get_3_of_5(model.times)}")
                    table_cell(content: "#{get_best_average_of_5(model.times)}")
                  end

                  table_row do
                    table_cell(content: "Average of 12")
                    table_cell(content: "#{get_10_of_12(model.times)}")
                    table_cell(content: "#{get_best_average_of_12(model.times)}")
                  end

                end

                label(content: "Solve count: #{length(model.times)}")
                label(content: "All time mean: #{get_average(model.times)}")

              end
            end

          end
        end
      end

      if model.instructions_showing do
        overlay(padding: 10) do
          panel title: "Instructions", height: :fill do
            label(content: "spacebar -  Start/stop the timer")
            label(content: "'S' - Generate a new scramble without starting the timer")
            label(content: "'D' - Delete the last recorded time")
            label(content: "'G' - Save the solves data")
            label(content: "'Q' - Close the timer")
            label(content: "'I' - Show/hide complete instructions")
            label(content: "'A' - Enable/disable autosave")
            label(content: "'T' - Show/hide solve times distribution and fequencies")
          end
        end
      end

      if model.display_time_visuals do
        overlay(padding: 10) do
          row do

            column(size: 6) do
              panel title: "Solve times frequency" do
                table(get_time_frequencies(model.solves))
              end
            end

            column(size: 6) do
              panel title: "Solve times distribution" do

                chart(type: :line, series: model[:solves] |> to_histogram() |> Map.values(), height: 15)

              end
            end

          end
        end
      end

      if model.visualize_times_history do
        overlay(padding: 10) do
          panel title: "Solve times history" do
            chart(type: :line, series: model[:times] |> Enum.take(100) |> Enum.reverse(), height: 10)
          end
        end
      end

    end
  end
end

Ratatouille.run(RubiksTimer, interval: 10)
