# alias
# lexically scoped

# alias Math.List, as: List
# alias Math.List
# ^ both are equivalent

defmodule Stats do
  def plus(a, b) do
    alias Math.List
  end

  def minus(a, b) do
    # List is not available here
  end
end

# Aliases are converted to atoms at compile time
# Since Erlang modules are always represented as atoms
# List and :"Elixir.List" are equivalent

# require

# Allow module macro usage
# lexically scoped

# Integer.is_odd(7)
# error: undefined or private

require Integer
Integer.is_odd(7)
# out: true

# import

# Import all functions from Foo, allowing them to be called without the module prefix
# Note: prefer alias over import, as it is more explicit
# lexically scoped

import List, only: [duplicate: 2]
duplicate(:ok, 3) |> IO.inspect()
# out: [:ok, :ok, :ok]

# use

# Invoke code defined in module

# Example: writing tests using ExUnit
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

# Module nesting

# Nested module are intependent so they can be defined in any order
defmodule Foo.Bar do
  defmodule Baz do
  end
end

defmodule Foo do
  alias Foo.Bar.Baz
  # Calling Baz here is fine
  # Bar is not available
end

# Multi aliaes
defmodule App do
  defmodule Foo do
  end

  defmodule Bar do
  end

  defmodule Baz do
  end
end

alias App.{Foo, Bar, Baz}
