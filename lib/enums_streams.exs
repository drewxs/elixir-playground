# enum functions are eager

odd? = &(rem(&1, 2) != 0)
x = Enum.filter(1..4, odd?)
IO.puts(x)
# out: [1, 3]

Enum.sum(Enum.filter(Enum.map(1..100_000, &(&1 * 3)), odd?))
# ^rewritten with "|>" operator
x = 1..100_000 |> Enum.map(&(&1 * 3)) |> Enum.filter(odd?) |> Enum.sum()
IO.puts(x)
# out: 7500000000

# streams support lazy ops
# useful for large (infinite?) datasets

x = 1..100_000 |> Stream.map(&(&1 * 3)) |> Stream.filter(odd?) |> Enum.sum()
IO.puts(x)
# out: 7500000000

stream = Stream.cycle([1, 2, 3])
Enum.take(stream, 10)
# out: [1, 2, 3, 1, 2, 3, 1, 2, 3, 1]

# generate values from given init val
stream = Stream.unfold("ciel", &String.next_codepoint/1)
x = Enum.take(stream, 3)
IO.puts(x)
# out: ["c", "i", "e"]
