defmodule AdventOfCode.Day08 do

  def run(instructions, pointer, acc) do
    {instruction, arg, visited} = Enum.at(instructions, pointer)
    if (visited) do
      acc
    else
      instructions_visited = List.replace_at(instructions, pointer,  {instruction, arg, true} )
      case instruction do
        "nop" -> run(instructions_visited, pointer + 1, acc)
        "jmp" -> run(instructions_visited, pointer + arg, acc)
        "acc" -> run(instructions_visited, pointer + 1, acc + arg)
      end
    end
  end

  def part1(args) do
    instructions = args
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn x -> String.split(x, " ") end)
    |> Enum.map(fn [instruction, arg] -> {instruction, String.to_integer(arg), false} end)


    run(instructions, 0, 0)
  end

  def run_2(instructions, pointer, acc) when pointer == length(instructions) do
    # IO.inspect(pointer, label: "pointer terminating")
    acc
  end

  def run_2(instructions, pointer, acc) do
    current = Enum.at(instructions, pointer)
    # IO.inspect(pointer, label: "pointer running")
    if (current == nil) do
      nil
    else
      {instruction, arg, visited} = current
      if (visited) do
        nil
      else
        instructions_visited = List.replace_at(instructions, pointer,  {instruction, arg, true} )
        result = case instruction do
          "nop" -> run_2(instructions_visited, pointer + 1, acc)
          "jmp" -> run_2(instructions_visited, pointer + arg, acc)
          "acc" -> run_2(instructions_visited, pointer + 1, acc + arg)
        end

        result
      end
    end


  end

  def get_permutation(current, idx, all) do
    # IO.inspect(current, label: "current")
    {instruction, arg, visited} = current
    replaced = case instruction do
      "nop" -> {"jmp", arg, visited}
      "jmp" -> {"nop", arg, visited}
      _ -> current
    end
    # IO.inspect(replaced, label: "replaced")

    List.replace_at(all, idx, replaced)

  end

  def part2(args) do

    instructions = args
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn x -> String.split(x, " ") end)
    |> Enum.map(fn [instruction, arg] -> {instruction, String.to_integer(arg), false} end)


    permutations = instructions
    |> Enum.with_index
    |> Enum.map(fn {x, idx} -> get_permutation(x, idx, instructions) end)

    # IO.inspect(permutations, label: "permutations")

    permutations
    |> Enum.map(fn x -> run_2(x, 0, 0) end)
    |> Enum.find(fn x -> x !== nil end)


  end
end
