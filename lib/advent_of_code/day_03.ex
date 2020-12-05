defmodule AdventOfCode.Day03 do

  def run_sled(terrain, stepsize) do
    {count, _idx} = Enum.reduce(terrain, {0, 0}, fn (x, {count, idx}) ->
      case String.at(x, rem(idx, String.length(x))) do
        "#" -> {count + 1, idx + stepsize}
        _ -> {count, idx + stepsize}
      end
    end)
    count
  end


  # encountered_trees idx current_row
  def part1(args) do
    args
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> run_sled(3)

  end

  def part2(args) do
    terrain = args
    |> String.split("\n")
    |> Enum.map(&String.trim/1)

    result1 = [1, 3, 5, 7]
    |> Enum.map(fn x -> run_sled(terrain, x) end)
    |> Enum.reduce(fn x, y -> x * y end)

    result2 = terrain
    |> Enum.take_every(2)
    |> run_sled(1)


    result2 * result1
  end
end
