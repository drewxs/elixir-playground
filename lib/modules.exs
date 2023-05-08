# default args
defmodule Adder do
  def add(a \\ 1, b \\ 1) do
    a + b
  end
end

IO.puts(Adder.add(3))
# out: 4
IO.puts(Adder.add())
# out: 2

# default values with multiple clauses
defmodule Concat do
  def join(a, b \\ nil, sep \\ " ")

  def join(a, b, _sep) when is_nil(b) do
    a
  end

  def join(a, b, sep) do
    a <> sep <> b
  end
end

IO.puts(Concat.join("ciel", "alice"))
# out: ciel alice
IO.puts(Concat.join("ciel", "alice", "_"))
# out: ciel_alice
IO.puts(Concat.join("ciel"))
# out: ciel
