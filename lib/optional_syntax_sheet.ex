# do-end blocks
if true do
  :this
else
  :that
end

# keyword lists
if true, do: :this, else: :that
if true, do: {:this, :that}, else: :other
if true, do: :this, else: :this
if true, [{:do, :this}, {:else, :this}]
if(true, [{:do, :this}, {:else, :this}])

# module example
defmodule OptionalSyntax do
  def add(a, b) do
    a + b
  end
end

# ^ equivalent to
defmodule(OptionalSyntax2, [
  {:do, def(add(a, b), [{:do, a + b}])}
])
