# self application curry
curry_sa = fn r ->
  fn args ->
    fn f ->
      if length(args) < :erlang.fun_info(f)[:arity] do
        fn arg -> r.(r).([arg | args]).(f) end
      else
        apply(f, Enum.reverse(args))
      end
    end
  end
end

# curry with default empty list
curry = curry_sa.(curry_sa).([])

# usage with anonymous sub function
sub = fn a, b -> a - b end
result = curry.(sub).(4).(3)
IO.puts(result)
# out: 1
