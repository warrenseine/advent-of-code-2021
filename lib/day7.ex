defmodule Day7 do
  # def compute(positions) do
  #   positions
  #   |> IO.inspect()
  #   |> Enum.map(fn {k, _} ->
  #     (positions
  #     |> Enum.reduce(0, fn {k2, v2}, acc ->
  #       acc + abs(k2 - k) * v2
  #     end))
  #   end)
  #   |> IO.inspect(charlists: :as_lists)
  #   |> Enum.min()
  # end

  def compute(positions) do
    positions
  end

  def part1(input) do
    positions = input
    |> String.split([","])
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(%{}, fn n, acc ->
      Map.update(acc, n, 1, &(&1 + 1))
    end)

    positions
    |> IO.inspect()
    |> Enum.map(fn {k, _} ->
      positions
      |> Enum.reduce(0, fn {k2, v2}, acc ->
        acc + abs(k2 - k) * v2
      end)
    end)
    |> IO.inspect(charlists: :as_lists)
    |> Enum.min()
  end

  def part2(input) do
    # IO.inspect(sum_of_integers(4))
    positions = input
    |> String.split([","])
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(%{}, fn n, acc ->
      Map.update(acc, n, 1, &(&1 + 1))
    end)

    # positions
    # |> IO.inspect()

    candidates = 0..Enum.max(positions |> Enum.map(&(elem(&1, 0))))

    # IO.inspect(candidates)

    Enum.map(candidates, fn k ->
      positions
      |> Enum.reduce(0, fn {k2, v2}, acc ->
        # IO.inspect({ k, k2, sum_of_integers(abs(k2 - k)) })
        acc + sum_of_integers(abs(k2 - k)) * v2
      end)
    end)
    |> IO.inspect(charlists: :as_lists)
    |> Enum.min()
  end

  def sum_of_integers(n) do
    n * (1 + n) / 2
  end
end
