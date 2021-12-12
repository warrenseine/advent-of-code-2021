defmodule Day1 do
  def part1(input) do
    input
    |> String.trim()
    |> String.split(["\n"])
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce({ :infinity, 0 }, fn current, { previous, count } ->
      { current, if current > previous do count + 1 else count end }
    end)
    |> elem(1)
  end

  def part2(input) do
    input
    |> String.trim()
    |> String.split(["\n"])
    |> Enum.map(&String.to_integer/1)
    |> count_increasing_windows(:infinity, 0)
  end

  def count_increasing_windows(remaining, previous, count) do
    case remaining do
      [a, b, c | tail] ->
        count_increasing_windows([b, c | tail], a + b + c, if a + b + c > previous do count + 1 else count end)
      [_ | _] -> count
    end
  end
end

test_input = """
199
200
208
210
200
207
240
269
260
263
"""

real_input = File.read!("day1.txt")

IO.puts(Day1.part1(real_input))
IO.puts(Day1.part2(real_input))
