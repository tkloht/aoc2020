defmodule AdventOfCode.Day05 do

  def binary_partition(input, array) do
    chars = String.graphemes(input)
    # IO.inspect(chars)
    chars
    |> Enum.reduce(array, fn (x, acc) ->
      mid = trunc(Enum.count(acc) / 2)
      # IO.inspect({mid, acc}, charlists: false)
      {left, right} = Enum.split(acc, mid)
      # IO.inspect({x, acc, left, right})
      case x do
        "F" -> left
        "B" -> right
        "L" -> left
        "R" -> right
      end
    end)
    |> Enum.at(0)
  end

  def part1(args) do
    available_rows = Enum.to_list(0..127)
    available_columns = Enum.to_list(0..7)
    seats = args
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn x -> String.split_at(x, 7) end)
    |> Enum.map(
      fn {rows, columns} ->
        rowIdx = binary_partition(rows, available_rows)
        colIdx = binary_partition(columns, available_columns)
        {rowIdx, colIdx}
      end)
    ids = seats |> Enum.map(fn {row, col} -> row *8 + col end)

    Enum.max(ids)
  end

  def part2(args) do
    expected_cols = Enum.to_list(0..7)
    available_rows = Enum.to_list(0..127)
    available_columns = Enum.to_list(0..7)
    seats = args
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn x -> String.split_at(x, 7) end)
    |> Enum.map(
      fn {rows, columns} ->
        rowIdx = binary_partition(rows, available_rows)
        colIdx = binary_partition(columns, available_columns)
        {rowIdx, colIdx}
      end)

      row_seats = seats
      |> Enum.sort_by(fn {row, _col} -> row end)
      |> Enum.chunk_by(fn {row, _col} -> row end)
      |> Enum.drop(1)
      |> Enum.drop(-1)
      |> Enum.find(fn x -> Enum.count(x) < 8 end)

      {row_nr, _} = Enum.at(row_seats, 0)
      cols_in_row = Enum.map(row_seats, fn {_, x} -> x end)

      col_nr = Enum.find(expected_cols, (fn x -> !Enum.member?(cols_in_row, x) end))

      id = row_nr *8 + col_nr
      {row_nr, col_nr, id}


  end
end
