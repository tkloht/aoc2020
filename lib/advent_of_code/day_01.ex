defmodule AdventOfCode.Day01 do

  def combinations(elements) do
    for x <- elements, y <- elements, x != y, do: [x, y]
  end

  def combinations_3(elements) do
    for x <- elements, y <- elements, z <- elements, x != y && x != z, do: [x, y, z]
  end

  def part1(args) do
    args
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> combinations
    |> Enum.find(fn [x, y] -> x + y == 2020 end)
    |> (fn [x, y] -> x * y end).()
  end

  def part2(args) do
    args
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> combinations_3
    |> Enum.find(fn [x, y, z] -> x + y + z == 2020 end)
    |> (fn [x, y, z] -> x * y * z end).()
  end
end
