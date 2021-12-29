defmodule AdventTest do
  use ExUnit.Case

  @tag :skip
  doctest Advent

  @tag :skip
  test "Day1" do
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

    real_input = File.read!("test/day1.txt")

    IO.puts(Day1.part1(test_input))
    IO.puts(Day1.part2(test_input))

    IO.puts(Day1.part1(real_input))
    IO.puts(Day1.part2(real_input))
  end

  @tag :skip
  test "Day2" do
    test_input = """
    forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2
    """

    real_input = File.read!("test/day2.txt")

    IO.puts(Day2.part1(test_input))
    IO.puts(Day2.part2(test_input))

    IO.puts(Day2.part1(real_input))
    IO.puts(Day2.part2(real_input))
  end

  @tag :skip
  test "Day3" do
    test_input = """
    00100
    11110
    10110
    10111
    10101
    01111
    00111
    11100
    10000
    11001
    00010
    01010
    """

    real_input = File.read!("test/day3.txt")

    IO.puts(Day3.part1(test_input))
    IO.puts(Day3.part2(test_input))

    IO.puts(Day3.part1(real_input))
    IO.puts(Day3.part2(real_input))
  end

  @tag :skip
  test "Day4" do
    test_input = """
    7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

    22 13 17 11  0
     8  2 23  4 24
    21  9 14 16  7
     6 10  3 18  5
     1 12 20 15 19

     3 15  0  2 22
     9 18 13 17  5
    19  8  7 25 23
    20 11 10 24  4
    14 21 16 12  6

    14 21 17 24  4
    10 16 15  9 19
    18  8 23 26 20
    22 11 13  6  5
     2  0 12  3  7
    """

    real_input = File.read!("test/day4.txt")

    IO.puts(Day4.part1(test_input))
    IO.puts(Day4.part2(test_input))

    IO.puts(Day4.part1(real_input))
    IO.puts(Day4.part2(real_input))
  end

  @tag :skip
  test "Day5" do
    test_input = """
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
    """

    real_input = File.read!("test/day5.txt")

    IO.puts(Day5.part1(test_input))
    IO.puts(Day5.part2(test_input))

    IO.puts(Day5.part1(real_input))
    IO.puts(Day5.part2(real_input))
  end

  @tag :skip
  test "Day6" do
    test_input = "3,4,3,1,2"

    real_input = File.read!("test/day6.txt")

    IO.puts(Day6.part1(test_input))
    IO.puts(Day6.part2(test_input))

    IO.puts(Day6.part1(real_input))
    IO.puts(Day6.part2(real_input))
  end

  @tag :skip
  test "Day7" do
    test_input = "16,1,2,0,4,2,7,1,2,14"

    real_input = File.read!("test/day7.txt")

    IO.puts(Day7.part1(test_input))
    IO.puts(Day7.part2(test_input))

    IO.puts(Day7.part1(real_input))
    IO.puts(Day7.part2(real_input))
  end
end
