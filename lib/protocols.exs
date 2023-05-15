# defmodule Utility do
#   def type(value) when is_binary(value), do: "string"
#   def type(value) when is_integer(value), do: "integer"
# end

# Protocols are kinda like Rust traits
# Implement the protocol for a type

defprotocol Utility do
  @spec type(t) :: String.t()
  def type(value)
end

defimpl Utility, for: BitString do
  def type(_value), do: "string"
end

defimpl Utility, for: Integer do
  def type(_value), do: "integer"
end

Utility.type("ciel") |> IO.puts()
# out: string
Utility.type(0) |> IO.puts()
# out: integer

# Implementing size for different types

defprotocol Size do
  @fallback_to_any true
  def size(data)
end

defimpl Size, for: BitString do
  def size(string), do: byte_size(string)
end

defimpl Size, for: Map do
  def size(map), do: map_size(map)
end

defimpl Size, for: Tuple do
  def size(tuple), do: tuple_size(tuple)
end

defimpl Size, for: List do
  def size(list), do: Enum.count(list)
end

defimpl Size, for: MapSet do
  def size(mapset), do: MapSet.size(mapset)
end

defmodule Cat do
  defstruct [:name, :age]
end

defimpl Size, for: Cat do
  def size(_), do: 2
end

defimpl Size, for: Any do
  def size(_), do: 0
end

defmodule OtherCat do
  @derive [Size]
  defstruct [:name, :age]
end

defmodule Main do
  def start do
    Size.size("ciel") |> IO.puts()
    # out: 4
    Size.size(%{name: "ciel"}) |> IO.puts()
    # out: 1
    Size.size({"ciel", "alice"}) |> IO.puts()
    # out: 2
    Size.size(["ciel", "alice"]) |> IO.puts()
    # out: 2
    Size.size(%OtherCat{name: "alice", age: 3}) |> IO.puts()
    # out: 2

    # Built-in protocols:

    # Enum implements the Enumerable protocol
    Enum.map([1, 2, 3], fn x -> x * 2 end) |> IO.inspect()
    # out: [2, 4, 6]

    # String.Chars protocol, exposed via to_string function
    to_string(:ciel) |> IO.puts()
    # out: "ciel"

    # String interpolation calls to_string
    "num: #{0}" |> IO.puts()
    # out: "num: 0"
  end
end

Main.start()
