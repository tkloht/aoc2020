defmodule AdventOfCode.Day02 do

  def is_valid([min, max, char, password]) do
    password
    |> String.graphemes
    |> Enum.count(fn x -> x == char end)
    |> (fn x -> x >= min && x <= max  end).()
  end

  def is_valid_2([pos1, pos2, char, password]) do
    password
    |> (fn x -> [ String.at(x, pos1 - 1), String.at(x, pos2 - 1) ] end).()
    |> Enum.filter(fn x -> x == char end)
    |> Enum.count
    |> (fn x -> x == 1 end).()
  end

  def part1(args) do
    args
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn x -> String.split(x, [": ", "-", " "]) end)
    |> Enum.map(fn [min, max, char, pwd] -> [String.to_integer(min), String.to_integer(max), char, pwd] end)
    |> Enum.map(&is_valid/1)
    |> Enum.count(fn x -> x end)
  end

  def part2(args) do
    args
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn x -> String.split(x, [": ", "-", " "]) end)
    |> Enum.map(fn [min, max, char, pwd] -> [String.to_integer(min), String.to_integer(max), char, pwd] end)
    |> Enum.map(&is_valid_2/1)
    |> Enum.count(fn x -> x end)
  end
end
