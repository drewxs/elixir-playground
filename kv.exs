# key-value store using Task
defmodule KV do
  def start_link do
    Task.start_link(fn -> loop(%{}) end)
  end

  defp loop(map) do
    receive do
      {:get, key, caller} ->
        send(caller, Map.get(map, key))
        loop(map)

      {:put, key, value} ->
        loop(Map.put(map, key, value))
    end
  end
end

{:ok, pid} = KV.start_link()
send(pid, {:put, :ciel, :alice})
send(pid, {:get, :ciel, self()})

# :alice, nil, "no match" (:alice)
receive do
  {:ciel, value} -> value
  x -> IO.puts(inspect(x))
after
  1000 -> IO.puts("no match")
end

# register processes with name (:cat)
Process.register(pid, :cat)
send(:cat, {:get, :ciel, self()})

# :alice, nil, "no match" (:alice)
receive do
  {:ciel, value} -> value
  x -> IO.puts(inspect(x))
after
  1000 -> IO.puts("no match")
end
