defmodule Mix.Tasks.D10.P2 do
  use Mix.Task

  import AdventOfCode.Day10

  @shortdoc "Day 10 Part 2"
  def run(args) do
    input = "147
    174
    118
    103
    67
    33
    96
    28
    43
    22
    16
    138
    75
    148
    35
    6
    10
    169
    129
    115
    21
    52
    58
    79
    46
    7
    139
    104
    91
    51
    172
    57
    49
    126
    95
    149
    125
    123
    112
    30
    78
    44
    37
    167
    157
    29
    173
    98
    36
    63
    111
    160
    18
    8
    9
    159
    179
    72
    110
    2
    53
    150
    17
    81
    97
    108
    102
    56
    135
    166
    168
    163
    1
    25
    3
    158
    101
    132
    144
    45
    140
    34
    156
    178
    105
    68
    153
    80
    82
    59
    50
    122
    69
    85
    109
    40
    124
    119
    94
    88
    13
    180
    177
    133
    66
    134
    60
    141"

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_2: fn -> input |> part2() end}),
      else:
        input
        |> part2()
        |> IO.inspect(label: "Part 2 Results")
  end
end
