defmodule Math do
  def sum([head | tail], accumulator) do
    sum(tail, head + accumulator)
  end

  def sum([], accumulator) do
    accumulator
  end

  def double([head | tail]) do
    [head * 2 | double(tail)]
  end

  def double([]) do
    []
  end
end

Math.sum([1, 2, 3], 0) |> IO.puts()
# out: 6
Math.double([1, 2, 3])
# out: [2, 4, 6]

# capture syntax with enumerables
Enum.reduce([1, 2, 3], 0, &+/2) |> IO.puts()
# out: 6
Enum.map([1, 2, 3], &(&1 * 3))
# out: [3, 6, 9]
