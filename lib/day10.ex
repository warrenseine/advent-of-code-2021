defmodule Day10 do
  def parse(input) do
    input
    |> String.split(["\n"], trim: true)
    |> Enum.map(fn s ->
      s
      |> String.trim()
      |> String.split("", trim: true)
    end)
  end

  def part1(input) do
    parse(input)
    |> Enum.map(&score/1)
    |> Enum.sum()
  end

  def part2(input) do
    scores = parse(input)
    |> Enum.filter(fn l ->
      score(l) == 0
    end)
    |> Enum.map(&read_line/1)
    |> Enum.map(&complete_line/1)
    |> Enum.sort()

    middle_index = scores |> length() |> div(2)
    Enum.at(scores, middle_index)
  end

  def read_line(chars) do
    chars
    |> Enum.reduce_while([], fn c, s ->
      case c do
        "(" ->
          {:cont, ["(" | s]}

        "[" ->
          {:cont, ["[" | s]}

        "{" ->
          {:cont, ["{" | s]}

        "<" ->
          {:cont, ["<" | s]}

        ")" ->
          case s do
            ["(" | s] -> {:cont, s}
            _ -> {:halt, [c]}
          end

        "]" ->
          case s do
            ["[" | s] -> {:cont, s}
            _ -> {:halt, [c]}
          end

        "}" ->
          case s do
            ["{" | s] -> {:cont, s}
            _ -> {:halt, [c]}
          end

        ">" ->
          case s do
            ["<" | s] -> {:cont, s}
            _ -> {:halt, [c]}
          end
      end
    end)
  end

  def complete_line(stack) do
    stack
    |> Enum.reduce(0, fn c, total ->
      total * 5 +
        case c do
          "(" -> 1
          "[" -> 2
          "{" -> 3
          "<" -> 4
        end
    end)
  end

  def score(chars) do
    chars
    |> read_line()
    |> case do
      [c | _] ->
        case c do
          ")" -> 3
          "]" -> 57
          "}" -> 1197
          ">" -> 25137
          # Incomplete line
          _ -> 0
        end

      _ ->
        0
    end
  end
end
