# to run iex actividad52.exs

defmodule Hw.Primes do
  def sum_primes(stop) do
    Enum.reduce(1..stop, 0, fn num, acc ->
      if is_prime(num) do
        acc + num
      else
        acc
      end
    end)
  end

  defp is_prime(num) when num < 2, do: false
  defp is_prime(2), do: true
  defp is_prime(num) do
    factors = Enum.filter(2..(num - 1), fn x -> rem(num, x) == 0 end)
    Enum.empty?(factors)
  end
end

# Example usage:
IO.inspect(Hw.Primes.sum_primes(10))  # Output: 17
IO.inspect(Hw.Primes.sum_primes(100))  # Output: 1060


# Example usage:
# input_number = 10
# result = Hw.Primes.sum_primes(input_number)
# IO.puts(result)  # Output: 17

# IO.Hw.Primes.sum_primes(100)  # Output: 1060

# input_number = 100
# result = Hw.Primes.sum_primes(input_number)
# IO.puts(result)  # Output: 1060

#IO.inspect(Hw.Primes.sum_primes(10))
