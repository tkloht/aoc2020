defmodule AdventOfCode.Day04 do

  def parse_fields(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn x -> String.replace(x, "\n", " ") end)
    |> Enum.map(fn x -> String.split(x, " ", trim: true) end)
    |> Enum.map(fn passport ->
        Enum.map(passport,
        fn x -> String.split(x, ":")
        |> (fn [key, value] -> {key, value} end).()
      end)
    end )
  end

  def has_required_fields(passport) do
    required_fields =  ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", ]

    passport_fields = passport |> Enum.map(fn {x, _y} -> x end)

    required_fields
    |> Enum.map(fn x -> Enum.member?(passport_fields, x) end)
    |> Enum.reduce(fn x, y -> x && y end)
  end

  def number_between(x, min, max) do
    parsed = String.to_integer(x)
    parsed <= max && parsed >= min
  end

  def validate_height(x) do
    case String.split_at(x, -2) do
      {height, "cm"} -> number_between(height,  150, 193)
      {height, "in"} -> number_between(height,  59, 76)
      _ -> false
    end
  end

  def validate_field({key, value}) do
    case key do
      "byr" -> number_between(value, 1920, 2002) # four digits; at least 1920 and at most 2002.
      "iyr" -> number_between(value, 2010, 2020) # at least 2010 and at most 2020.
      "eyr" -> number_between(value, 2020, 2030) # four digits; at least 2020 and at most 2030.
      "hgt" -> validate_height(value) # a number followed by either cm or in:
      # If cm, the number must be at least 150 and at most 193.
      # If in, the number must be at least 59 and at most 76.
      "hcl" -> String.match?(value, ~r/^#[0-9a-f]{6}$/ ) # a # followed by exactly six characters 0-9 or a-f.
      "ecl" -> String.match?(value, ~r{^(amb|blu|brn|gry|grn|hzl|oth)$} )# exactly one of: amb blu brn gry grn hzl oth.
      "pid" -> String.match?(value, ~r{^\d\d\d\d\d\d\d\d\d$} ) # a nine-digit number, including leading zeroes.
      "cid" -> true
    end
  end

  def validate_passport(fields) do
    has_required_fields(fields) && fields |> Enum.map(&validate_field/1) |> Enum.reduce(fn x, y -> x && y end)
  end

  def part1(args) do
    args
    |> parse_fields
    |> Enum.map(&has_required_fields/1)
    |> Enum.filter(fn x -> x end)
    |> Enum.count
  end

  def part2(args) do
    args
    |> parse_fields
    |> Enum.map(&validate_passport/1)
    |> Enum.filter(fn x -> x end)
    |> Enum.count
  end
end
