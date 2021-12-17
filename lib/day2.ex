defmodule Day2 do
  def part1(input) do
    input
    |> String.trim()
    |> String.split(["\n"])
    |> Enum.reduce({0, 0}, fn current, {depth, hpos} ->
      case String.split(current) do
        [instruction, count] ->
          case instruction do
            "forward" -> {depth, hpos + String.to_integer(count)}
            "up" -> {depth - String.to_integer(count), hpos}
            "down" -> {depth + String.to_integer(count), hpos}
          end
      end
    end)
    |> Tuple.to_list()
    |> Enum.product()
  end

  def part2(input) do
    input
    |> String.trim()
    |> String.split(["\n"])
    |> Enum.reduce({0, 0, 0}, fn current, {depth, hpos, aim} ->
      case String.split(current) do
        [instruction, count] ->
          case instruction do
            "forward" ->
              {depth + aim * String.to_integer(count), hpos + String.to_integer(count), aim}

            "up" ->
              {depth, hpos, aim - String.to_integer(count)}

            "down" ->
              {depth, hpos, aim + String.to_integer(count)}
          end
      end
    end)
    |> Tuple.to_list()
    |> Enum.slice(0..1)
    |> Enum.product()
  end
end
