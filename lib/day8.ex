defmodule Day8 do
  def parse(input) do
    input
    |> String.split(["\n"], trim: true)
    |> Enum.map(fn s ->
      s
      |> String.split(["|"])
      |> Enum.map(fn s ->
        s
        |> String.trim()
        |> String.split([" "], trim: true)
      end)
    end)
  end

  def part1(input) do
    parse(input)
    |> Enum.map(fn l ->
      case l do
        [_, b] -> b
      end
    end)
    |> List.flatten()
    |> Enum.count(fn word ->
      l = String.length(word)
      l == 2 or l == 3 or l == 4 or l == 7
    end)
  end

  def part2(input) do
    parse(input)
    # |> Enum.take(1)
    |> Enum.map(fn l ->
      l
      |> Enum.map(fn words ->
        words
        |> Enum.map(fn word ->
          word
          |> String.split("", trim: true)
          |> MapSet.new()
        end)
      end)
      |> case do
        [patterns, outputs] ->
          digits = resolve_digits(patterns)
          compute_output(outputs, digits)
      end
    end)
    |> Enum.sum()
  end

  def resolve_digits(words) do
    words = MapSet.new(words)
    {one, words} = find_by_unique_segments(words, 2)
    {four, words} = find_by_unique_segments(words, 4)
    {seven, words} = find_by_unique_segments(words, 3)
    {eight, words} = find_by_unique_segments(words, 7)

    # possible_top_segment =
    #   MapSet.difference(MapSet.intersection(seven, eight), MapSet.union(one, four))

    # possible_bottom_segment =
    #   MapSet.difference(eight, MapSet.union(MapSet.union(one, four), seven))

    possible_middle_segment =
      MapSet.difference(MapSet.intersection(four, eight), MapSet.union(one, seven))

    # possible_topleft_segment =
    #   MapSet.difference(MapSet.intersection(four, eight), MapSet.union(one, seven))

    possible_topright_segment =
      MapSet.intersection(one, MapSet.intersection(four, MapSet.intersection(seven, eight)))

    possible_bottomleft_segment =
      MapSet.difference(eight, MapSet.union(MapSet.union(one, four), seven))

    possible_bottomright_segment =
      MapSet.intersection(one, MapSet.intersection(four, MapSet.intersection(seven, eight)))

    {zero, words} = find_which_doesnt_have(words, 6, possible_middle_segment)
    {six, words} = find_which_doesnt_have(words, 6, possible_topright_segment)
    {nine, words} = find_which_doesnt_have(words, 6, possible_bottomleft_segment)
    {three, words} = find_which_has(words, 5, one)
    {five, words} = find_which_is_in(words, 5, six)
    {two, words} = find_which_doesnt_have(words, 5, possible_bottomright_segment)

    # IO.inspect(words)
    # IO.inspect({"zero", zero})
    # IO.inspect({"one", one})
    # IO.inspect({"two", two})
    # IO.inspect({"three", three})
    # IO.inspect({"four", four})
    # IO.inspect({"five", five})
    # IO.inspect({"six", six})
    # IO.inspect({"seven", seven})
    # IO.inspect({"eight", eight})
    # IO.inspect({"nine", nine})

    # IO.inspect({ "top", possible_top_segment })
    # IO.inspect({ "bottom", possible_bottom_segment })
    # IO.inspect({ "middle", possible_middle_segment })
    # IO.inspect({ "topleft", possible_topleft_segment })
    # IO.inspect({ "topright", possible_topright_segment })
    # IO.inspect({ "bottomleft", possible_bottomleft_segment })
    # IO.inspect({ "bottomright", possible_bottomright_segment })

    %{
      zero => 0,
      one => 1,
      two => 2,
      three => 3,
      four => 4,
      five => 5,
      six => 6,
      seven => 7,
      eight => 8,
      nine => 9
    }
  end

  def compute_output(words, digits) do
    # IO.inspect(digits)
    # IO.inspect(words)

    words
    |> Enum.map(fn word ->
      digits[word]
    end)
    |> IO.inspect()
    |> case do
      [a, b, c, d] -> a * 1000 + b * 100 + c * 10 + d
    end
  end

  def find_which_has(words, count, segments_included) do
    match =
      filter_by_unique_segments(words, count)
      |> Enum.filter(fn ms ->
        segments_included
        |> Enum.all?(fn c ->
          MapSet.member?(ms, c)
        end)
      end)
      |> case do
        l when length(l) > 1 -> IO.inspect({words, count, segments_included, l}) ; raise "BAD"
        [a] -> a
      end

    {match, MapSet.delete(words, match)}
  end

  def find_which_is_in(words, count, superset) do
    match =
      filter_by_unique_segments(words, count)
      |> Enum.filter(fn ms ->
        ms
        |> Enum.all?(fn c ->
          MapSet.member?(superset, c)
        end)
      end)
      |> case do
        l when length(l) > 1 -> IO.inspect({words, count, superset, l}) ; raise "BAD"
        [a] -> a
      end

    {match, MapSet.delete(words, match)}
  end

  def find_which_doesnt_have(words, count, possible_segment) do
    match =
      filter_by_unique_segments(words, count)
      |> Enum.reject(fn ms ->
        possible_segment
        |> Enum.all?(fn c ->
          MapSet.member?(ms, c)
        end)
      end)
      |> case do
        l when length(l) > 1 -> IO.inspect({words, count, possible_segment, l}) ; raise "BAD"
        [a] -> a
      end

    {match, MapSet.delete(words, match)}
  end

  def find_by_unique_segments(words, count) do
    match =
      words
      |> Enum.find(nil, fn word ->
        MapSet.size(word) == count
      end)

    {match, MapSet.delete(words, match)}
  end

  def filter_by_unique_segments(words, count) do
    words
    |> Enum.filter(fn word ->
      MapSet.size(word) == count
    end)
  end
end
