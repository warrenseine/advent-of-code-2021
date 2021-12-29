defmodule Day6 do
  # def compute(fish, iterations) do
  #   if iterations <= 0 do
  #     length(fish)
  #   else
  #     fish
  #     |> Enum.reduce([], fn n, fish ->
  #       if n > 0 do
  #         [n - 1 | fish]
  #       else
  #         [6 | [8 | fish]]
  #       end
  #     end)
  #     |> compute(iterations - 1)
  #   end
  # end

  def compute(fish, iterations) do
    if iterations <= 0 do
      fish
      |> Enum.reduce(0, fn {_, v}, acc -> acc + v end)
    else
      fish
      |> Enum.reduce(%{}, fn {k, v}, acc ->
        if k > 0 do
          acc
          |> Map.update(k - 1, v, &(&1 + v))
        else
          acc
          |> Map.update(8, v, &(&1 + v))
          |> Map.update(6, v, &(&1 + v))
        end
      end)
      |> compute(iterations - 1)
    end
  end

  def part1(input) do
    input
    |> String.split([","])
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(%{}, fn n, acc ->
      Map.update(acc, n, 1, &(&1 + 1))
    end)
    |> compute(80)
  end

  def part2(input) do
    input
    |> String.split([","])
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(%{}, fn n, acc ->
      Map.update(acc, n, 1, &(&1 + 1))
    end)
    |> compute(256)
  end
end
