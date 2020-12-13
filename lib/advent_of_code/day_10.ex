defmodule AdventOfCode.Day10 do
  import Enum
  def part1(args) do
    input = args
    |> String.split("\n")
    |> map(&String.trim/1)
    |> map(&String.to_integer/1)
    |> List.insert_at(0, 0)
    |> sort

    device_jolts = max(input) + 3

    deltas = input
    |> reverse
    |> reduce({device_jolts, []}, fn x, {prev, acc} -> {x, [ prev - x | acc]} end)
    |> elem(1)
    |> sort

    delta_three = deltas |> count(fn x -> x == 3 end)
    delta_one = deltas |> count(fn x -> x == 1 end)

    delta_one * delta_three
  end




  def part2(args) do
    input = args
    |> String.split("\n")
    |> map(&String.trim/1)
    |> map(&String.to_integer/1)
    |> List.insert_at(0, 0)
    |> sort

    device_jolts = max(input) + 3

    possibilities = [1, 2, 4, 7]

    deltas = input
    |> reverse
    |> reduce({device_jolts, []}, fn x, {prev, acc} -> {x, [ prev - x | acc]} end)
    |> elem(1)

    # IO.inspect(deltas, limit: 1000)

    deltas
    |> chunk_by(fn x -> x == 3 end)
    |> filter(fn x -> member?(x, 1) end)
    |> map(fn x -> count(x) end)
    |> reduce(1, fn x, acc -> acc * at(possibilities, x - 1) end)


    # count = count_connections(input, [{0, 1}])
  end
end
