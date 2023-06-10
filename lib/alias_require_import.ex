# ALIAS
# lexically scoped

# alias Math.List, as: List
# alias Math.List
# ^ both are equivalent

defmodule Stats do
  def plus(_a, _b) do
    alias Math.List
    List
  end

  def minus(_a, _b) do
    # List is not available here
  end
end

# aliases are converted to atoms at compile time
# since Erlang modules are always represented as atoms
# List and :"Elixir.List" are equivalent

# REQUIRE

# allow module macro usage
# lexically scoped

# Integer.is_odd(7)
# error: undefined or private

require Integer
Integer.is_odd(7) |> IO.puts()
# out: true

# IMPORT

# import all functions from Foo, allowing them to be called without the module prefix
# note: prefer alias over import, as it is more explicit
# lexically scoped

import List, only: [duplicate: 2]
duplicate(:ok, 3) |> IO.inspect()
# out: [:ok, :ok, :ok]

# USE

# invoke code defined in module

# example: writing tests using ExUnit
# defmodule Test do
#   use ExUnit.Case, async: true
#
#   test "pass" do
#     assert true
#   end
# end

# use requires the module, and invokes the __using__/1 callback on it
# defmodule Example do
#   use Feature, option: :value
# end
# ^ compiles to:
# defmodule Example do
#  require Feature
#  Feature.__using__(option: :value)
# end

# MODULE NESTING

# nested module are intependent so they can be defined in any order
defmodule Foo.Bar do
  defmodule Baz do
  end
end

defmodule Foo do
  alias Foo.Bar.Baz
  Baz
  # Calling Baz here is fine
  # Bar is not available
end

# multi aliaes
defmodule App do
  defmodule Foo do
  end

  defmodule Bar do
  end

  defmodule Baz do
  end
end

alias App.{Foo, Bar, Baz}
Foo
Bar
