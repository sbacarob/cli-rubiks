defmodule RubiksTimer do
  @moduledoc """
  Documentation for Rubiks Timer.
  """
  @behaviour Ratatouille.App

  import Ratatouille.View
  import Ratatouille.Constants, only: [key: 1, color: 1, attribute: 1]
  import RubiksTimer.{Helper, Scrambler, Stats, TextRenderer}

  alias Ratatouille.Runtime.Subscription

  @spacebar key(:space)
  @green color(:green)
  @white color(:white)
  @bold attribute(:bold)

  def init(_context) do
    times = get_historic_times()

    %{
      timer_running: false,
      init_time: DateTime.utc_now(),
      time: 0.0,
      times: times,
      scramble: get_scramble(),
      solves: get_historic_solves(),
      instructions_showing: false,
      autosave_enabled: true,
      display_time_visuals: false,
      visualize_times_history: false,
      ao5: get_average_of_n(times, 5),
      bao5: get_best_average_of_n(times, 5),
      ao12: get_average_of_n(times, 12),
      bao12: get_best_average_of_n(times, 12),
      ao50: get_average_of_n(times, 50),
      bao50: get_best_average_of_n(times, 50),
      ao100: get_average_of_n(times, 100),
      bao100: get_best_average_of_n(times, 100),
      display_time: true
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
      visualize_times_history: visualize_times_history,
      bao5: best_average_of_5,
      bao12: best_average_of_12,
      bao50: best_average_of_50,
      bao100: best_average_of_100,
      display_time: display_time
    } = model

    case msg do
      {:event, %{key: @spacebar}} ->
        if timer_running do
          solves = [%{scramble: scramble, date: DateTime.utc_now(), time: time} | solves]
          times = [time | times]
          lao5 = get_average_of_n(times, 5)
          lao12 = get_average_of_n(times, 12)
          lao50 = get_average_of_n(times, 50)
          lao100 = get_average_of_n(times, 100)

          if autosave_enabled, do: save_solve_data(solves)

          %{
            model | solves: solves,
            timer_running: !timer_running,
            scramble: get_scramble(),
            times: times,
            ao5: lao5,
            ao12: lao12,
            ao50: lao50,
            ao100: lao100,
            bao5: min(lao5, best_average_of_5),
            bao12: min(lao12, best_average_of_12),
            bao50: min(lao50, best_average_of_50),
            bao100: min(lao100, best_average_of_100)
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

      {:event, %{ch: ?2}} ->
        plus_2(model)

      {:event, %{ch: ?f}} ->
        dnf(model)

      {:event, %{ch: p}} ->
        %{model | display_time: !display_time}

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
              if model.timer_running && !model.display_time do
                render_text("-.-")
              else
                render_text(model[:time])
              end
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
                    table_cell(content: "#{display_value(List.first(model.times))}")
                    table_cell(content: "#{clean_times(model.times) |>get_best()}", color: @green)
                  end

                  table_row do
                    table_cell(content: "Average of 5")
                    table_cell(content: "#{display_value(model.ao5)}")
                    table_cell(content: "#{display_value(model.bao5)}")
                  end

                  table_row do
                    table_cell(content: "Average of 12")
                    table_cell(content: "#{display_value(model.ao12)}")
                    table_cell(content: "#{display_value(model.bao12)}")
                  end

                  table_row do
                    table_cell(content: "Average of 50")
                    table_cell(content: "#{display_value(model.ao50)}")
                    table_cell(content: "#{display_value(model.bao50)}")
                  end

                  table_row do
                    table_cell(content: "Average of 100")
                    table_cell(content: "#{display_value(model.ao100)}")
                    table_cell(content: "#{display_value(model.bao100)}")
                  end

                end

                label(content: "Solve count: #{length(model.times)}")
                label(content: "All time mean: #{clean_times(model.times) |> get_average()}")

              end
            end

          end
        end
      end

      if model.instructions_showing do
        overlay(padding: 10) do
          panel title: "Instructions", height: :fill do
            label(content: "spacebar -  Start/stop the timer")
            label(content: "'2' - Plus 2 to the last time")
            label(content: "'F' - DNF last time")
            label(content: "'S' - Generate a new scramble without starting the timer")
            label(content: "'D' - Delete the last recorded time")
            label(content: "'G' - Save the solves data")
            label(content: "'Q' - Close the timer")
            label(content: "'I' - Show/hide complete instructions")
            label(content: "'A' - Enable/disable autosave")
            label(content: "'T' - Show/hide solve times distribution and frequencies")
            label(content: "'P' - Toggle display time while solving")
          end
        end
      end

      if model.display_time_visuals do
        overlay(padding: 10) do
          row do

            column(size: 6) do
              panel title: "Solve times frequency", height: 20, padding: 0 do
                table(get_time_frequencies(model.solves))
              end
            end

            column(size: 4) do
              panel title: "Solve times distribution" do

                chart(type: :line, series: get_times_distribution(model.solves), height: 15)

              end
            end

          end
        end
      end

      if model.visualize_times_history do
        overlay(padding: 10) do
          panel title: "Solve times history" do
            chart(type: :line, series: get_recent_times(model.times), height: 10)
          end
        end
      end

    end
  end
end

Ratatouille.run(RubiksTimer, interval: 10)
