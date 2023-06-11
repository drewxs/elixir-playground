# REGULAR EXPRESSIONS

("ciel" =~ ~r/ciel|alice/) |> IO.inspect()
# out: true
("cie" =~ ~r/ciel|alice/) |> IO.inspect()
# out: false
Regex.match?(~r/ciel/i, "CIEL") |> IO.inspect()
# out: true

# delimiters: /|"'([{<
# ~r(^https?://) vs ~r/^https?:\/\//

# STRINGS / CHAR LISTS / WORLD LISTS SIGILS

# STRINGS
~s(string "sigil") |> IO.puts()
# out: string "sigil"

# CHAR LISTS
~c(char 'lists') |> IO.puts()
# out: char 'lists'

# WORLD LISTS
# modifiers: c (char lists), s (strings), a (atoms)
~w(foo bar bat) |> IO.inspect()
# out: ["foo", "bar", "bat"]
~w(foo bar bat)a |> IO.inspect()
# out: [:foo, :bar, :bat]

# INTERPOLATION & ESCAPING IN STRING SIGILS
# ~s allows escape codes / interpolation, ~S does not
name = "ciel"
~s(hello #{name} \x26 alice) |> IO.puts()
# out: hello ciel & alice
~S(hello #{name} \x26 alice) |> IO.puts()
# out: hello #{name} \x26 alice

# CALENDAR SIGILS

# Date
~D[2020-01-01] |> IO.inspect()
# out: ~D[2020-01-01]

# Time
~T[12:00:00] |> IO.inspect()
# out: ~T[12:00:00]
~T[12:00:17].second |> IO.inspect()
# out: 17

# NaiveDateTime (no timezone info)
~N[2020-01-01 12:00:00] |> IO.inspect()
# out: ~N[2020-01-01 12:00:00]

# UTCDateTime
~U[2020-01-01 12:00:00Z] |> IO.inspect()
# out: ~U[2020-01-01 12:00:00Z]

# CUSTOM SIGILS

sigil_r(<<"foo">>, 'i') |> IO.inspect()
~r"foo"i |> IO.inspect()
# out: ~r/foo/i

defmodule Sigils do
  def sigil_i(string, []), do: String.to_integer(string)
  def sigil_i(string, [?n]), do: -String.to_integer(string)
end

defmodule Main do
  import Sigils

  ~i(7) |> IO.inspect()
  # out: 7

  ~i(7)n |> IO.inspect()
  # out: -7
end
