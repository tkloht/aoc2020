defmodule AdventOfCode.Day09 do
  def get_preamble(input, current_idx, length) do
    Enum.slice(input, current_idx - length, length)
  end

  def combinations(input) do
    for x <- input, y <- input, x != y, do: [x, y]
  end

  def checksum_valid(input, idx, length) do
    expected = input |> Enum.at(idx)
    input
    |> get_preamble( idx, length)
    |> combinations
    |> Enum.map(&Enum.sum/1)
    |> Enum.member?(expected)

  end

  def part1(args, preamble_length) do
    input = args
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)

    input
    |> Enum.with_index
    |> Enum.drop(preamble_length)
    |> Enum.find(fn {_, idx} -> !checksum_valid(input, idx, preamble_length) end)
    |> elem(0)
    # |> IO.inspect(label: "day9 part1 result")
  end

  def get_set_for_idx(input, end_idx) do
    0..end_idx
    |> Enum.map(fn start_idx -> Enum.slice(input, start_idx, end_idx) end)
  end

  def get_contiguous_sets(input) do
    input
    |> Enum.with_index
    |> Enum.flat_map(fn {_, idx} -> get_set_for_idx(input, idx) end)
    |> Enum.filter(fn x -> Enum.count(x) > 1 end)
  end

  def part2_alt(args, part1_result) do

    input = args
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)

    # {min, max} = input
    input
    |> Enum.filter(fn x -> x < part1_result end)
    |> get_contiguous_sets

    |> Enum.count
    |> IO.inspect(label: "sets count")

    # |> Enum.map(fn x -> {Enum.sum(x), x} end)
    # |> Enum.find(fn {sum, _} -> sum == part1_result end)
    # |> elem(1)
    # |> Enum.min_max

    # min + max


  end

  @spec part2(binary, any) :: [any]
  def part2(args, part1_result) do

    IO.inspect(part1_result, label: "part1 result")

    input = args
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)

    start_idxs = input
    |> Enum.with_index
    |> Enum.map(fn {_, x} -> x  end)

    result_row = start_idxs
    |> Enum.map(fn x -> Enum.slice(input, x..Enum.count(input)) end)
    |> Enum.map(fn x -> Enum.reduce_while(x, [], fn y, acc -> if Enum.sum(acc) < part1_result, do: {:cont, [y | acc]}, else: {:halt, acc} end)end)
    |> Enum.find(fn x -> Enum.sum(x) == part1_result end)

    {min, max} = result_row |> Enum.min_max
    min+max


  end

end
