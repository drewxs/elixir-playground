# IO.inspect/2

1..10
|> IO.inspect()
|> Enum.map(fn x -> x * 2 end)
|> IO.inspect()
|> Enum.sum()
|> IO.inspect()

# out:
# 1..10
# [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
# 110

# decorate with `label` option
[1, 2, 3]
|> IO.inspect(label: "before")
|> Enum.map(&(&1 * 2))
|> IO.inspect(label: "after")
|> Enum.sum()

# out:
# before: [1, 2, 3]
# after: [2, 4, 6]

# use IO.inspect/2 with binding() to return all variables in scope
# def some_fun(a, b, c) do
#   IO.inspect(binding())
# end

# dbg
feature = %{name: :dbg, inspiration: "Rust"}
# dbg(feature)
# dbg(Map.put(feature, :in_version, "1.14.0"))
# out:
# [iex:3: (file)]
# Map.put(feature, :in_version, "1.14.0") #=> %{name: :dbg, inspiration: "Rust", in_version: "1.14.0"}
# %{name: :dbg, inspiration: "Rust", in_version: "1.14.0"}

# OBSERVER

# $ iex
# iex> :observer.start()

# running `iex` with `-S mix`
# iex> Mix.ensure_application!(:wx)
# iex> Mix.ensure_application!(:runtime_tools)
# iex> Mix.ensure_application!(:observer)
# iex> :observer.start()
