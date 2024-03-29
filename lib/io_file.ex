# IO defaults to stdout, can change to stderr
IO.puts(:stderr, "printing to stderr")

# files are opened in binary mode by default
{:ok, file} = File.open("static/hello.txt", [:write])
IO.binwrite(file, "hello ciel")
File.close(file)

# `elem(1)` destructures the 2nd tuple val
File.read("static/hello.txt") |> elem(1) |> IO.puts()
# out: hello ciel

# trailing bang variants return output instead of tuple {:ok, output}
File.read!("static/hello.txt") |> IO.puts()
# out: hello ciel

# file functions are named after UNIX equivalents:
# rm, mkdir, mkdir_p, cp_r, rm_rf, etc.

# pattern matching with tuple returns
case File.read("static/hello.txt") do
  {:ok, body} -> IO.puts("pattern match body: #{body}")
  {:error, err} -> IO.puts(err)
end

# PATHS

Path.join("hello", "ciel") |> IO.puts()
# out: hello/ciel
Path.expand("~/code") |> IO.puts()
# out: /home/drew/code

# PROCESSES

# IO modules works with processes, files are processes
# so writing to a closed file means a message is being sent to a terminated process
# pid = spawn(fn -> receive do: (msg -> IO.inspect(msg)) end)
# IO.write(pid, "hello")

# iodata / chardata
name = "ciel"
IO.puts("hello " <> name <> "!")
# out: hello ciel!
# ^expensive since it creates copies, can pass list instead
IO.puts(["hello ", name, "!"])
# out: hello ciel!

Enum.join(["apple", "banana", "lemon"], ",") |> IO.puts()
# out: apple,banana,lemon

Enum.intersperse(["apple", "banana", "lemon"], ",") |> IO.inspect()
# out: ["apple", ",", "banana", ",", "lemon"]

# ?, = integer representing comma (44)
IO.puts(["apple", ?,, "banana", ?,, "lemon"])
# out: apple,banana,lemon

# iodata: integers represent bytes
# chardata: integers represent unicode codepoints
#
# default IO device works with chardata
#
# if file is opened without encoding (raw mode), IO functions starting with bin* must be used (iodata args)
# if file is opened with :utf8 encoding, remaining IO functions can be used (chardata args)

# charlist: special case of chardata
IO.inspect(~c"hello")
# out: 'hello'
IO.inspect([?a, ?b, ?c])
# out: 'abc'
