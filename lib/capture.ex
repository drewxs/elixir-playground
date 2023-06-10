defmodule Math do
  def zero?(0), do: true
  def zero?(x) when is_integer(x), do: false
end

# retrieve named functions as function types
fun = &Math.zero?/1
is_function(fun) |> IO.puts()
fun.(0) |> IO.puts()
# out: true

# capture without module
(&is_function/1).(fun) |> IO.puts()
# out: true

# capture operators
add = &+/2
add.(7, 3) |> IO.puts()
# out: 10

# capture syntax as a shortcut for creating functions
# short function defs: &(&1 + 1) == fn x -out: x + 1 end
plus_one = &(&1 + 1)
plus_one.(2) |> IO.puts()
# out: 3
