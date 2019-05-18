defmodule RubiksTimer.Stats do

  import RubiksTimer.Helper, only: [clean_times: 1]

  def get_best([]), do: "-"
  def get_best(times), do: Enum.min(times)

  def get_average([]), do: 0
  def get_average(times), do: Enum.sum(times) / Kernel.length(times)

  def get_average_of_n(times, n) when length(times) < n, do: "-"
  def get_average_of_n(times, n) do
    cut = trunc(leave_out(n) / 2)

    times
    |> Enum.take(n)
    |> replace_dnf_times()
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
    |> Enum.reject(&(&1 == 0))
    |> Enum.min()
  end

  defp leave_out(n) do
    rounded_up_half = n
      |> Kernel./(10)
      |> Float.ceil()
      |> Kernel.trunc()

    if rem(rounded_up_half, 2) == 0, do: rounded_up_half, else: rounded_up_half + 1
  end

  defp replace_dnf_times([]), do: []
  defp replace_dnf_times(times) do
    no_dnfs_avg = clean_times(times)
      |> get_average()

    Enum.map(times, fn time -> if time == -1, do: no_dnfs_avg, else: time end)
  end
end
