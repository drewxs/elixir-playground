pid = spawn(fn -> 1 + 2 end)
# PID<0.x.0>
x = Process.alive?(pid)
IO.puts(x)

# retrieve current process pid
x = Process.alive?(self())
IO.puts(x)

# send message to process
send(self(), {:ciel, "alice"})
# {:ciel, "alice"}
receive do
  {:ciel, msg} -> IO.puts(msg)
  _ -> IO.puts("no msg")
end

# timeouts
receive do
  {:ciel, msg} -> IO.puts(msg)
after
  1000 -> IO.puts("no match")
end

parent = self()
spawn(fn -> send(parent, {:ciel, self()}) end)

receive do
  {:ciel, pid} -> inspect(pid)
end

# inspect/1: returns a string containing a printable version of a data structure
# flush/0: flushes and prints all messages in mailbox

# Task.start/1 returns {:ok, pid} | {:error, reason} whereas spawn/1 only returns pid
# use Task for better error reporting
