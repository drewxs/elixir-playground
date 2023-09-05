# DEFINING CUSTOM TYPES

defmodule PersonA do
  @typedoc """
  A 4 digit year, e.g. 1970
  """
  @type year :: integer

  @spec current_age(year) :: integer
  def current_age(birth_year), do: birth_year
end

defmodule CompoundCustomType do
  @type error_map :: %{message: String.t(), line_number: integer}
end

defmodule LousyCalculator do
  @typedoc """
  Just a number followed by a string.
  """

  @type number_with_remark :: {number, String.t()}

  @spec add(number, number) :: number_with_remark
  def add(x, y), do: {x + y, "You need a calculator do to that?!"}

  @spec multiply(number, number) :: number_with_remark
  def multiply(x, y), do: {x + y, "Jeez, come on!"}
end

defmodule QuietCalculator do
  @spec add(number, number) :: number
  def add(x, y), do: make_quiet(LousyCalculator.add(x, y))

  @spec make_quiet(LousyCalculator.number_with_remark()) :: number
  defp make_quiet({num, _remark}), do: num
end

# BEHAVIOURS

# modules adhering to a behaviour must implement all callbacks
defmodule Parser do
  @doc """
  Parses a string.
  """
  @callback parse(String.t()) :: {:ok, term} | {:error, atom}
  # term: any type

  @doc """
  Lists all supported file extensions.
  """
  @callback extensions :: [String.t()]
end

# IMPLEMENTING BEHAVIOURS

defmodule JsonParser do
  @behaviour Parser

  @impl Parser
  def parse(str), do: {:ok, "some json " <> str}

  @impl Parser
  def extensions, do: [".json"]
end

defmodule CSVParser do
  @behaviour Parser

  @impl Parser
  def parse(str), do: {:ok, "some csv " <> str}

  @impl Parser
  def extensions, do: [".csv"]
end

# use impl to ensure correct callback implementations
# this throws a compile-time warning:
# got "@impl Parser" for function parse/0 but this behaviour does not specify such callback.

# defmodule BADParser do
#   @behaviour Parser
#
#   @impl Parser
#   def parse, do: {:ok, "something bad"}
#
#   @impl Parser
#   def extensions, do: ["bad"]
# end

# USING BEHAVIOURS

# allows passing modules as args and call any function defined in the behaviour

defmodule UsingBehaviours do
  @spec parse_path(Path.t(), [module()]) :: {:ok, term} | {:error, atom}
  def parse_path(filename, parsers) do
    with {:ok, ext} <- parse_extension(filename),
         {:ok, parser} <- find_parser(ext, parsers),
         {:ok, contents} <- File.read(filename) do
      parser.parse(contents)
    end
  end

  defp parse_extension(filename) do
    ext = Path.extname(filename)
    {:ok, ext}
  end

  defp find_parser(ext, parsers) do
    if parser = Enum.find(parsers, fn parser -> ext in parser.extensions() end) do
      {:ok, parser}
    else
      {:error, :no_matching_parser}
    end
  end
end
