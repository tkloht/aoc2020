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

  def part2(_args) do
  end
end
