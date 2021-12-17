defmodule Day4 do
  def part1(input) do
    [ draw_line | board_lines ] = input
    |> String.trim()
    |> String.split(["\n"], trim: true)

    draw = draw_line
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)

    boards = board_lines
    |> Enum.chunk_every(5)
    |> Enum.map(fn block ->
      block
      |> Enum.map(fn line ->
        String.split(line, " ", trim: true)
        |> Enum.map(fn value -> { String.to_integer(value), false } end)
      end)
    end)

    positions = boards
    |> Enum.with_index()
    |> Enum.reduce(Map.new(), fn { board, board_id }, acc ->
      board
      |> Enum.with_index()
      |> Enum.reduce(acc, fn { row, y }, acc ->
        row
        |> Enum.with_index()
        |> Enum.reduce(acc, fn { { value, _ }, x }, acc ->
          Map.update(acc, value, [{ board_id, y, x }], fn current ->
            [{ board_id, y, x } | current]
          end)
        end)
      end)
    end)

    # IO.inspect(draw)
    # IO.inspect(boards)
    # IO.inspect(positions)

    draw
    |> Enum.reduce_while({ boards, 0 }, fn value, { boards, _ } ->
      new_boards = case positions[value] do
        nil -> boards
        positions_to_mark -> mark_boards(boards, positions_to_mark)
      end

      case game_over(new_boards) do
        nil -> { :cont, { new_boards, 0 } }
        board_id -> { :halt, { new_boards, compute_score(Enum.at(new_boards, board_id), value) } }
      end
    end)
    |> case do
      { _, score } -> score
    end
  end

  def mark_boards(boards, positions_to_mark) do
    positions_to_mark
    |> Enum.reduce(boards, fn { board_id, y, x }, boards ->
      boards
      |> Kernel.update_in([Access.at!(board_id), Access.at!(y), Access.at!(x)], fn { value, _ } -> { value, true } end)
    end)
  end

  def game_over(boards) do
    boards
    |> Enum.find_index(&game_over_board/1)
  end

  def game_over_board(board) do
    (Enum.any?(0..4, fn y ->
      Enum.all?(0..4, fn x ->
        Kernel.get_in(board, [Access.at(y), Access.at(x), Access.elem(1)])
      end)
    end)) or
    (Enum.any?(0..4, fn x ->
      Enum.all?(0..4, fn y ->
        Kernel.get_in(board, [Access.at(y), Access.at(x), Access.elem(1)])
      end)
    end))
  end

  def compute_score(board, value) do
    (board
    |> Enum.map(fn row ->
      row
      |> Enum.filter(fn { _, marked } -> not marked end)
      |> Enum.map(fn { value, _ } -> value end)
      |> Enum.sum()
    end)
    |> Enum.sum()) * value
  end

  def part2(input) do
    [ draw_line | board_lines ] = input
    |> String.trim()
    |> String.split(["\n"], trim: true)

    draw = draw_line
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)

    boards = board_lines
    |> Enum.chunk_every(5)
    |> Enum.map(fn block ->
      block
      |> Enum.map(fn line ->
        String.split(line, " ", trim: true)
        |> Enum.map(fn value -> { String.to_integer(value), false } end)
      end)
    end)

    positions = boards
    |> Enum.with_index()
    |> Enum.reduce(Map.new(), fn { board, board_id }, acc ->
      board
      |> Enum.with_index()
      |> Enum.reduce(acc, fn { row, y }, acc ->
        row
        |> Enum.with_index()
        |> Enum.reduce(acc, fn { { value, _ }, x }, acc ->
          Map.update(acc, value, [{ board_id, y, x }], fn current ->
            [{ board_id, y, x } | current]
          end)
        end)
      end)
    end)

    # IO.inspect(draw)
    # IO.inspect(boards)
    # IO.inspect(positions)

    # FIXME: Use MapSet instead.
    remaining_board_ids = Range.new(0, length(boards) - 1)

    draw
    |> Enum.reduce_while({ boards, remaining_board_ids, 0 }, fn value, { boards, remaining_board_ids, _ } ->
      new_boards = case positions[value] do
        nil -> boards
        positions_to_mark -> mark_boards(boards, positions_to_mark)
      end

      case game_over_2(new_boards, remaining_board_ids) do
        { [winner_board_id], [] } -> { :halt, { new_boards, [], compute_score(Enum.at(new_boards, winner_board_id), value) } }
        { winner_board_ids, _ } -> { :cont, { new_boards, MapSet.to_list(MapSet.difference(MapSet.new(remaining_board_ids), MapSet.new(winner_board_ids))), 0 } }
      end
    end)
    |> case do
      { _, _, score } -> score
    end
  end

  def game_over_2(boards, remaining_board_ids) do
    remaining_board_ids
    |> Enum.split_with(fn board_id -> game_over_board(Enum.at(boards, board_id)) end)
  end
end
