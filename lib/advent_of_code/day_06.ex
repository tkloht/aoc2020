defmodule AdventOfCode.Day06 do
  def part1(args) do
    args
    |> String.split("\n\n")
    |> Enum.map(fn x -> x
      |> String.split("\n")
      |> Enum.map(&String.trim/1)
      |> Enum.flat_map(&String.graphemes/1)
      |> Enum.uniq
      |> Enum.count
      end)
    |> Enum.sum

  end

  def group_each_contains(group, char) do
    # IO.inspect(group, label: "group")
    # IO.inspect(char, label: "char")

    group
    |> Enum.map(fn x -> Enum.member?(x, char) end )
    |> Enum.reduce(fn x, y -> x && y end)
  end

  def part2(args) do
    unique_answers = args
    |> String.split("\n\n")
    |> Enum.flat_map(fn x -> x
      |> String.split("\n")
      |> Enum.map(&String.trim/1)
      |> Enum.flat_map(&String.graphemes/1)
      |> Enum.uniq
      end)
    |> Enum.uniq

    groups = args
    |> String.split("\n\n")
    |> Enum.map(fn x -> x
      |> String.split("\n")
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.graphemes/1)
      end)

    IO.inspect(unique_answers, label: "unique ansers")

    unique_answers
    |> Enum.map(fn char ->
      groups
      |> Enum.map(fn x -> group_each_contains(x, char)end)
      |> Enum.filter(fn x -> x end)
      |> Enum.count
    end)
    |> Enum.sum

  end
end
