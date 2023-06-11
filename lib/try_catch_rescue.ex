# ERRORS

# raise/1. raise/2
# raise "error"
# raise ArgumentError, message: "invalid argument foo"

defmodule MyError do
  defexception message: "default message"
end

# raise MyError
# raise MyError, message: "custom message"

try do
  raise "error"
rescue
  # out: error
  e in RuntimeError -> IO.puts(e.message)
  # out: error!
  RuntimeError -> "error!"
end

# rust-like results for error handling
case File.read("file.txt") do
  {:ok, body} -> IO.puts("Success: #{body}")
  {:error, reason} -> IO.puts("Error: #{reason}")
end

# expect a file to exist (unhanded error)
# File.read!("file.txt")

# RERAISE
# try do
#   ... some code ...
# rescue
#   e ->
#     # rescue exception, log it, then reraise it
#     Logger.error(Exception.format(:error, e, __STACKTRACE__))
#     reraise e, __STACKTRACE__
# end

# THROWS
# used for early returns, no stack traces
try do
  throw(:foo)
  IO.puts("unreachable")
catch
  :foo -> IO.puts("got :foo")
end

# EXITS
# can be caught using try/catch
# spawn_link(fn -> exit(1) end)
# ** (EXIT from #PID<x>) 1
try do
  exit("exiting...")
catch
  :exit, reason -> IO.puts("reason: #{reason}")
end

# try/catch & try/rescue are uncommon
# supervisors are the preferred way to handle errors

# AFTER
# cleanup after actions that can raise errors
# executed regardless of whether tried block succeeds
{:ok, file} = File.open("file.txt", [:utf8, :write])

try do
  IO.write(file, "hello")
  raise "something went wrong"
rescue
  e -> IO.puts("error: #{e.message}")
after
  File.close(file)
end

# functions bodies are auto-wrapped in `try` whenever after/rescue/catch is used
defmodule RunAfter do
  def no_try do
    raise "something went wrong"
  rescue
    e -> IO.puts("error: #{e.message}")
  after
    IO.puts("cleaning up...")
  end
end

RunAfter.no_try()
# out: error: something went wrong
# out: cleaning up...

# ELSE
# matches on results of `try` block when it finishes without throw/exit
x = 2

try do
  1 / x
rescue
  ArithmeticError -> "error"
else
  y when y < 1 and y > -1 -> IO.puts(:small)
  _ -> IO.puts(:large)
end

# `else` block exceptions are not caught
# exception is raised if no pattern matches
# not caught by current try/catch/rescue/after block

# VARIABLE SCOPES
# try/catch/rescue/after blocks create closures
# can return value of try expressions
result =
  try do
    raise "fail"
    :no_raise
  rescue
    _ -> :rescued
  end

IO.puts(result)
# out: rescued
