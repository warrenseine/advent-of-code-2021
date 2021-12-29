defmodule Day5 do
  def parse(input, diag) do
    vents = input
    |> String.trim()
    |> String.split(["\n"], trim: true)
    |> Enum.map(fn line -> line
      |> String.split([" -> "], trim: true)
      |> Enum.map(fn coord -> coord
        |> String.split([","])
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)
    end)

    if diag do
      vents
    else
      vents |> Enum.filter(fn [{x1, y1}, {x2, y2}] -> x1 == x2 or y1 == y2 end)
    end
  end

  def compute(vents) do
    # IO.inspect(vents)

    matrix = vents
    |> Enum.reduce(Map.new(), fn [{x1, y1}, {x2, y2}], matrix ->
      IO.inspect({{x1, y1}, {x2, y2}})
      line({x1, y1}, {x2, y2})
      |> Enum.reduce(matrix, fn {x, y}, matrix -> Map.update(matrix, {x, y}, 1, &(&1 + 1)) end)
    end)

    # IO.inspect(matrix)

    # debug = 0..9 |> Enum.map(fn y ->
    #   (0..9 |> Enum.map(fn x -> Integer.to_string(Map.get(matrix, {x, y}, 0)) end)) ++ "\n"
    # end)

    # IO.puts(debug)

    matrix
    |> Enum.count(fn {_, v} -> v > 1 end)
  end

  def part1(input) do
    vents = parse(input, false)
    compute(vents)
  end

  def part2(input) do
    vents = parse(input, true)
    compute(vents)
  end

  defp line({x1, y1}, {x2, y2}) when x1 == x2 or y1 == y2 do
    for x <- min(x1, x2)..max(x1, x2), y <- min(y1, y2)..max(y1, y2), do: {x, y}
  end

  defp line({x1, y1}, {x2, y2}) do
    Enum.zip([x1..x2//sign(x2-x1), y1..y2//sign(y2-y1)])
  end

  defp sign(n) do
    if n >= 0 do 1 else -1 end
  end
end
