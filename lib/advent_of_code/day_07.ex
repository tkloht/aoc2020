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
        # IO.inspect(candidates, label: "Maybe Candidates")
        new_candidates = get_new_candidates(rules, candidates)
        # IO.inspect(new_candidates, label: "new candidates")
        Enum.map(new_candidates, fn x -> build_path(rules, x)end)
        |> Enum.reduce(fn x, y -> x || y end)
      end
    end
  end

  def normalize_bags(bag) do
    Regex.replace(~r/^\d+ /, bag, "")
    |> (fn x -> Regex.replace(~r/ bags?$/, x, "") end).()
  end

  def normalize_bags_2(bag) do
    without_bags = Regex.replace(~r/ bags?$/, bag, "")
    if (without_bags == "no other") do
      []
    else
      [count, color] = Regex.run(~r/(\d+) (.+)/, without_bags, capture: :all_but_first)
      # IO.inspect(count, label: "captures")
      Enum.to_list( 1..String.to_integer(count))
      |> Enum.map(fn _ -> color end)
    end

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

  def collapse_bags(current_rule, all_rules) do
    {_color, bags} = current_rule

    bags
    |> Enum.concat(Enum.flat_map(bags, fn search_color ->
      new_rule = Enum.find(all_rules, fn({color, _bags}) -> color == search_color end)
      collapse_bags(new_rule, all_rules)
    end))
  end

  def part2(args) do
    rules = args
    |> (fn x -> Regex.replace(~r/\.$/, x, "") end).()
    |> String.split(".\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn x -> String.split(x, " bags contain ") end)
    |> Enum.map(fn [left, right] -> {left, right |> String.split(", ") |> Enum.flat_map(&normalize_bags_2/1)} end)

    # IO.inspect(rules, label: "rules")

    golden_rule = Enum.find(rules, fn({color, _bags}) -> color == "shiny gold" end)
    Enum.count(collapse_bags(golden_rule, rules))
  end
end
