defmodule Math do
  def zero?(0), do: true
  def zero?(x) when is_integer(x), do: false
end

# retrieve named functions as function types
fun = &Math.zero?/1
IO.puts(is_function(fun))
IO.puts(fun.(0))
# true

# capture without module
IO.puts((&is_function/1).(fun))
# true

# capture operators
add = &+/2
IO.puts(add.(7, 3))
# 10

# capture syntax as a shortcut for creating functions
# short function defs: &(&1 + 1) == fn x -> x + 1 end
plus_one = &(&1 + 1)
IO.puts(plus_one.(2))
# 3
