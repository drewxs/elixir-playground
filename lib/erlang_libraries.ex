# BINARY

String.to_charlist("Ø")
# out: [216]

:binary.bin_to_list("Ø")
# out: [195, 152]

# FORMATTED TEXT OUTPUT

:io.format("pi:~10.3f~n", [:math.pi()])
# out: pi:     3.142
to_string(:io_lib.format("pi:~10.3f~n", [:math.pi()]))
# out: "pi:     3.142\n"

# CRYPTO

Base.encode16(:crypto.hash(:sha256, "hello"))
# out: "2CF24DBA5FB0A30E26E83B2AC5B9E29E1B161E5C1FA7425E73043362938B9824"

# including additional applications in project
# edit `mix.exs`:
# def application do
#   [extra_applications: [:crypto]]
# end

# DIAGRAPH

digraph = :digraph.new()
coords = [{0.0, 0.0}, {1.0, 1.0}, {2.0, 0.0}]
[v0, v1, v2] = for c <- coords, do: :digraph.add_vertex(digraph, c)
:digraph.add_edge(digraph, v0, v1)
:digraph.add_edge(digraph, v1, v2)
:digraph.get_short_path(digraph, v0, v2)
# [{0.0, 0.0}, {1.0, 0.0}, [2.0, 2.0]]

# ERLANG TERM STORAGE

# `ets` and `dts` handle large data structure storage (mem or disk)
table = :ets.new(:ets_test, [])
:ets.insert(table, {"China", 1_374_000_000})
:ets.insert(table, {"India", 1_284_000_000})
:ets.insert(table, {"USA", 322_000_000})
# :ets.i(table)
# out: <1   > {<<"India">>,1284000000}
# out: <2   > {<<"USA">>,322000000}
# out: <3   > {<<"China">>,1374000000}

# MATH

angle_45_deg = :math.pi() * 45.0 / 180.0
:math.sin(angle_45_deg) |> IO.puts()
# out: 0.7071067811865475
:math.exp(55.0) |> IO.puts()
# out: 7.694785265142018e23
:math.log(7.694_785_265_142_018e23) |> IO.puts()
# out: 55.0

# QUEUE

q = :queue.new()
q = :queue.in("A", q)
q = :queue.in("B", q)
{value, _} = :queue.out(q)
value |> IO.inspect()
# out: {:value, "A"}
{value, _} = :queue.out(q)
value |> IO.inspect()
# out: {:value, "B"}
{value, _} = :queue.out(q)
value |> IO.inspect()
# out: :empty

# RAND

:rand.uniform()
# out: 0.8175669086010815
_ = :rand.seed(:exs1024, {123, 123_534, 345_345})
:rand.uniform()
# out: 0.5820506340260994
:rand.uniform(6)
# out: 6

# ZIP / ZLIB

:zip.foldl(fn _, _, _, acc -> acc + 1 end, 0, :binary.bin_to_list("file.zip"))
# out: {:ok, 633}

song = "
Mary had a little lamb,
His fleece was white as snow,
And everywhere that Mary went,
The lamb was sure to go."
compressed = :zlib.compress(song)
_ = byte_size(song)
# out:
# <<120, 156, 37, 140, 187, 13, 195, 48, 12, 5, 123, 77, 241, 6, 16, 188, 67, 186,
#   52, 233, 188, 0, 109, 189, 132, 2, 100, 9, 144, 152, 16, 222, 62, 254, 116,
#   87, 220, 93, 120, 73, 223, 161, 146, 32, 40, 217, 172, 16, 69, 182, ...>>
_ = byte_size(compressed)
# out: 99
:zlib.uncompress(compressed)
# out: "\nMary had a little lamb,\nHis fleece was white as snow,
# \nAnd everywhere that Mary went,\nThe lamb was sure to go."
