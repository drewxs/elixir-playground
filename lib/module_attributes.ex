defmodule Cat do
  @moduledoc """
  Meow?

  ## Examples

      iex> Cat.meow()
      "meow"

  """

  @doc """
  Meows.
  """
  def meow, do: "meow"
end

# $ elixirc lib/module_attributes.ex
# $ iex
# iex> h Cat # Access the docs for the module Cat
# iex> h Cat.meow # Access the docs for the meow function

# ExDoc can generate HTML from docs.math
# Attributes are also used to define typespecs

# As "constants"

defmodule Server do
  @initial_state %{host: "127.0.0.1", port: 3456}
  IO.inspect(@initial_state)

  @data_ciel :ciel
  def first_data, do: @data_ciel
  @data_ciel_age 3
  def second_data, do: @data_ciel_age

  # Calling functions when defining module attributes
  # Called at compile time, return value substituted
  # Don't use for runtime evaluation
  defmodule Status do
    @service URI.parse("https://example.com")
    def status(_email) do
      # SomeHttpClient.get(@service)
    end
  end
end

Server.first_data() |> IO.puts()
# out: ciel
Server.second_data() |> IO.puts()
# out: 3

# If the same attribute is read multiple times inside multiple functions,
# prefer moving attributes to shared functions for improved performance
defmodule Multiple do
  @baz 0

  def do_foo(_) do
  end

  def do_bar(_) do
  end

  def foo, do: do_foo(baz())
  def bar, do: do_bar(baz())
  defp baz, do: @baz
end

# Accumulating attributes

defmodule Accumulate do
  Module.register_attribute(__MODULE__, :param, accumulate: true)

  @param :ciel
  @param :alice
  # @param == [:foo, :alice]
end
