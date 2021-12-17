defmodule Day3 do
  def part1(input) do
    lines =
      input
      |> String.trim()
      |> String.split(["\n"])

    cols = String.length(Enum.at(lines, 0))

    lines
    |> Enum.reduce({List.duplicate(0, cols), 0}, fn current, {ones, rows} ->
      String.split(current, "", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.zip_with(ones, fn a, b -> a + b end)
      |> with_rows(rows + 1)
    end)
    |> to_gamma_and_epsilon()
    |> Enum.product()
  end

  def with_rows(l, rows) do
    {l, rows}
  end

  def is_one(s) do
    if s == "1" do
      1
    else
      0
    end
  end

  def to_gamma_and_epsilon({ones, rows}) do
    gamma =
      ones
      |> Enum.map(fn current ->
        if current * 2 <= rows do
          0
        else
          1
        end
      end)
      |> from_binary()

    epsilon =
      ones
      |> Enum.map(fn current ->
        if current * 2 > rows do
          0
        else
          1
        end
      end)
      |> from_binary()

    [gamma, epsilon]
  end

  def from_binary(l) do
    l
    |> Enum.reverse()
    |> Enum.reduce({0, 1}, fn current, {sum, mul} ->
      {sum + mul * current, mul * 2}
    end)
    |> elem(0)
  end

  def part2(input) do
    lines =
      input
      |> String.trim()
      |> String.split(["\n"])
      |> Enum.map(fn current ->
        String.split(current, "", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)

    oxigen =
      lines
      |> recursive_filter(
        fn ones, rows ->
          if ones * 2 >= rows do
            1
          else
            0
          end
        end,
        0
      )
      |> List.first()
      |> from_binary()

    co2 =
      lines
      |> recursive_filter(
        fn ones, rows ->
          if ones * 2 < rows do
            1
          else
            0
          end
        end,
        0
      )
      |> List.first()
      |> from_binary()

    oxigen * co2
  end

  def recursive_filter(lines, predicate, column) do
    rows = length(lines)

    if rows == 1 do
      lines
    else
      ones = Enum.count(lines, fn line -> Enum.at(line, column) == 1 end)
      bit = predicate.(ones, rows)

      lines
      |> Enum.filter(fn line -> Enum.at(line, column) == bit end)
      |> recursive_filter(predicate, column + 1)
    end
  end
end
