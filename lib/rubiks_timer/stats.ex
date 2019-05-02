defmodule RubiksTimer.Stats do

  def get_best([]), do: "-"
  def get_best(times), do: Enum.min(times)

  def get_average([]), do: "-"
  def get_average(times), do: Enum.sum(times) / Kernel.length(times)

  def get_average_of_n(times, n) when length(times) < n, do: "-"
  def get_average_of_n(times, n) do
    cut = trunc(leave_out(n) / 2)

    times
    |> Enum.take(n)
    |> Enum.sort()
    |> Enum.slice(cut, n - (cut + 1))
    |> Enum.sum()
    |> Kernel./(n - 2 * cut)
  end

  def get_best_average_of_n(times, n) when length(times) < n, do: "-"
  def get_best_average_of_n(times, n) do
    times
    |> Stream.unfold(fn
      [] -> nil
      l -> {Enum.take(l, n) |> get_average_of_n(n), tl(l)}
    end)
    |> Enum.to_list()
    |> Enum.min()
  end

  defp leave_out(n) do
    rounded_up_half = n
      |> Kernel./(10)
      |> Float.ceil()
      |> Kernel.trunc()

    if rem(rounded_up_half, 2) == 0, do: rounded_up_half, else: rounded_up_half + 1
  end
end
