defmodule AdventOfCode.Day07 do

  def get_new_candidates(rules, candidates) do
    Enum.map(candidates, fn candidate ->
      {_name, values} = Enum.find(rules, fn {x, _y} -> x == candidate end)
      values
    end)
  end

  def build_path(rules, candidates) do

    if (Enum.member?(candidates, "shiny gold")) do
      true
    else
       if (Enum.member?(candidates, "no other")) do
        false
      else
        IO.inspect(candidates, label: "Maybe Candidates")
        new_candidates = get_new_candidates(rules, candidates)
        IO.inspect(new_candidates, label: "new candidates")
        Enum.map(new_candidates, fn x -> build_path(rules, x)end)
        |> Enum.reduce(fn x, y -> x || y end)
      end
    end
  end

  def normalize_bags(bag) do
    Regex.replace(~r/^\d+ /, bag, "")
    |> (fn x -> Regex.replace(~r/ bags?$/, x, "") end).()
  end

  def part1(args) do
    rules = args
    |> (fn x -> Regex.replace(~r/\.$/, x, "") end).()
    |> String.split(".\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn x -> String.split(x, " bags contain ") end)
    |> Enum.map(fn [left, right] -> {left, right |> String.split(", ") |> Enum.map(&normalize_bags/1)} end)

     Enum.map(rules, fn {_name, x} -> x end)
    |> Enum.map(fn candidate -> build_path(rules, candidate) end)
    |> Enum.filter(fn x -> x end)
    |> Enum.count()
  end

  def part2(_args) do
  end
end
