for n <- [1, 2, 3, 4], do: (n * n) |> IO.puts()
# out: 1 4 9 16

# GENERATORS & FILTERS

# above: `n <- [1, 2, 3, 4]` is the generator, any enumerable can be passed RHS
for n <- 1..4, do: (n * n) |> IO.puts()
# out: 1 4 9 16

# pattern matching in generator expressions LHS
values = [good: 1, good: 2, good: 3, bad: 4]
for {:good, n} <- values, do: (n * n) |> IO.puts()
# out: 1 4 9

# filters can be used to select specific elements
for n <- 0..5, rem(n, 3) == 0, do: n
# out: 0 3

# multiple generators/filters
dirs = ['/home/drew/code', '/home/drew/.dotfiles']

for dir <- dirs, file <- File.ls!(dir), path = Path.join(dir, file), File.regular?(path) do
  File.stat!(path).size |> IO.puts()
end

# for i <- [:a, :b, :c], j <- [1, 2], do: {i, j} |> IO.inspect()
# out: [{:a, 1}, {:a, 2}, {:b, 1}, {:b, 2}, {:c, 1}, {:c, 2}]

# BITSTRING GENERATORS

pixels = <<213, 45, 132, 64, 76, 32, 76, 0, 0, 234, 32, 15>>
for <<r::8, g::8, b::8 <- pixels>>, do: {r, g, b} |> IO.inspect()

# `:into` OPTION

# `:into` -> comprehension result inserted into
# accepts any structure that implements the `Collectable` protocol
for <<c <- " hello ciel ">>, c != ?\s, into: "", do: <<c>>
# out: "hello ciel"

# transform values in a map
for {key, val} <- %{:a => 1, :b => 2}, into: %{}, do: {key, val * val} |> IO.inspect()
# out: {:a, 1} {:b, 4}

# "echo terminal": echoes back in uppercase whatever is typed
# stream = IO.stream(:stdio, :line)
# for line <- stream, into: stream, do: String.upcase(line) <> "\n"
