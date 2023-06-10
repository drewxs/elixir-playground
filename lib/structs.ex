# Structs are bare maps with compile-time checks and default values
# Protocols implemented for maps not available, but `Map` functions are

defmodule Cat do
  defstruct name: "Ciel", age: 3
end

defmodule Main do
  %Cat{} |> IO.inspect()
  # out: %Cat{name: "Ciel", age: 3}
  %Cat{name: "Alice", age: 2} |> IO.inspect()
  # out: %Cat{name: "Alice", age: 2}

  # Access and update
  ciel = %Cat{}
  ciel.name |> IO.puts()
  # out: Ciel
  alice = %{ciel | name: "Alice"}
  alice |> IO.inspect()
  # out: %Cat{name: "Alice", age: 3}

  ciel.__struct__ |> IO.puts()
  # out: Elixir.Cat
end

# Default values / required keys

defmodule Kitten do
  # nil is assumed if no default value
  # Can use `@enforce_keys` to require keys
  @enforce_keys [:name]
  defstruct [:breed, :name, age: 3]
end

defmodule Main2 do
  %Kitten{name: "Alice"} |> IO.inspect()
  # out: %Kitten{breed: nil, name: "Alice", age: 3}
end
