defmodule RubiksTimer.Stats do

  def get_best([]), do: "-"
  def get_best(times), do: Enum.min(times)

  def get_average([]), do: "-"
  def get_average(times), do: Enum.sum(times) / Kernel.length(times)

  def get_3_of_5(times) when length(times) < 3, do: "-"
  def get_3_of_5(times) do
    times
    |> Enum.take(5)
    |> Enum.sort()
    |> Enum.slice(1, 3)
    |> Enum.sum()
    |> Kernel./(3)
  end

  def get_10_of_12(times) when length(times) < 12, do: "-"
  def get_10_of_12(times) do
    times
    |> Enum.take(12)
    |> Enum.sort()
    |> Enum.slice(1, 10)
    |> Enum.sum()
    |> Kernel./(10)
  end
end
