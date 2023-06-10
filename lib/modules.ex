# default args
defmodule Adder do
  def add(a \\ 1, b \\ 1) do
    a + b
  end
end

Adder.add(3) |> IO.puts()
# out: 4
Adder.add() |> IO.puts()
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

Concat.join("ciel", "alice") |> IO.puts()
# out: ciel alice
Concat.join("ciel", "alice", "_") |> IO.puts()
# out: ciel_alice
Concat.join("ciel") |> IO.puts()
# out: ciel
