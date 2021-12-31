defmodule Day9 do
  def parse(input) do
    input
    |> String.split(["\n"], trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {s, y}, acc ->
      s
      |> String.trim()
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {n, x}, acc ->
        Map.put(acc, {x, y}, n)
      end)
    end)
  end

  def part1(input) do
    heatmap = parse(input)

    heatmap
    |> Enum.filter(fn {{x, y}, n} ->
      Map.get(heatmap, {x - 1, y}, :infinity) > n and
        Map.get(heatmap, {x + 1, y}, :infinity) > n and
        Map.get(heatmap, {x, y - 1}, :infinity) > n and
        Map.get(heatmap, {x, y + 1}, :infinity) > n
    end)
    |> Enum.map(fn {_, n} -> n + 1 end)
    |> Enum.sum()
  end

  def part2(input) do
    heatmap = parse(input)

    heatmap
    |> Enum.filter(fn {{x, y}, n} ->
      [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}]
      |> Enum.all?(fn {x2, y2} ->
        Map.get(heatmap, {x2, y2}, :infinity) > n
      end)
    end)
    |> Enum.map(fn {{x, y}, _} -> basin_size(heatmap, x, y) end)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> IO.inspect()
    |> Enum.product()
  end

  def basin_size(heatmap, x, y) do
    flood_fill(heatmap, x, y, %{})
    |> map_size()
  end

  def flood_fill(heatmap, x, y, mark) do
    n = Map.get(heatmap, {x, y})

    [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}]
    |> Enum.reduce(Map.put(mark, {x, y}, true), fn {x2, y2}, mark ->
      case Map.get(heatmap, {x2, y2}, :infinity) do
        m when m > n and m < 9 -> flood_fill(heatmap, x2, y2, mark)
        _ -> mark
      end
    end)
  end
end
