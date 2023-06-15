#Actividad 5.2 Programación paralela y concurrente
#Lucía Barrenechea & Paula Verdugo
#Program that finds prime numbers using parrallel programming and non-parallel programming.
#This programs sums only prime number from a given range.

defmodule Hw.Primes do

  def sum_primes(ranges) do
    ranges
    |> Enum.map(&Task.async(fn -> range_sum(&1) end))
    |> Enum.map(&Task.await(&1))
    |> Enum.sum()
  end

  def range_sum({start, finish}) do
    start..finish
    |> Enum.filter(&is_prime/1)
    |> Enum.sum()
  end

  defp is_prime(num) when num < 2, do: false
  defp is_prime(2), do: true
  defp is_prime(num) do
    factors = Enum.filter(2..(num - 1), fn x -> rem(num, x) == 0 end)
    Enum.empty?(factors)
  end

  #The parrallel way to solve this problem starts here.
  def sum_primes_parallel(start, finish, concur) do
    total= finish-start
    gap = div(total, concur)
    sobra = rem(total, concur)
    forloop(start, concur, gap, sobra, [], concur)
  end

  #Creates number of threads as variable concur indicates.
  defp forloop(_start,  0, _gap, _sobra, list, _first) do
    Enum.reverse(list)
    |>Enum.map(&Task.async(fn -> range_sump(&1)end))
    |> IO.inspect()
    |> Enum.map(&Task.await(&1))
    |>IO.inspect()
    IO.puts("FINISHED MAIN THREAD")
  end

  defp forloop(start,  1, gap, sobra, list, first), do: forloop(start+gap,  0, gap, sobra, [{start+1, start + gap + sobra}|list], first)
  defp forloop(start, concur, gap, sobra, list, first) when concur==first, do: forloop(start+gap, concur-1, gap, sobra, [{start, start + gap}|list], first)
  defp forloop(start, concur, gap, sobra, list, first), do: forloop(start+gap, concur-1, gap, sobra, [{start+1, start + gap}|list], first)


#Checks if a number is prime and then adds ti.
  def range_sump({start, finish}) do
    start..finish
    |> Enum.filter(&is_primep/1)
    |> Enum.sum()
    |> IO.inspect()
  end

  #Function to check if number is prime
  defp is_primep(num) when num < 2, do: false
  defp is_primep(2), do: true
  defp is_primep(num) do
    factors = Enum.filter(2..(num - 1), fn x -> rem(num, x) == 0 end)
    Enum.empty?(factors)
  end
end

IO.puts("Excercise 1 examples")
IO.inspect(Hw.Primes.sum_primes([{100, 200}, {201, 300}, {301, 400}, {401, 500}])) # Output: 2944 (sum of prime numbers within the specified ranges)
IO.inspect(Hw.Primes.sum_primes([{1, 10}]))       # Output: 17 (sum of prime numbers from 1 to 10)
IO.inspect(Hw.Primes.sum_primes([{1, 100}]))      # Output: 1060 (sum of prime numbers from 1 to 100)
IO.inspect(Hw.Primes.sum_primes([{1, 1000}]))     # Output: 76127 (sum of prime numbers from 1 to 1000)
IO.inspect(Hw.Primes.sum_primes([{1, 10000}]))    # Output: 5736396 (sum of prime numbers from 1 to 10000)
IO.inspect(Hw.Primes.sum_primes([{100, 500}]))    # Output: 20476 (sum of prime numbers from 100 to 500)

IO.puts("Excercise 2 examples")
IO.inspect(Hw.Primes.sum_primes_parallel(100,200,4))
IO.inspect(Hw.Primes.sum_primes_parallel(1,2000,8))
IO.inspect(Hw.Primes.sum_primes_parallel(4,53,3))
IO.inspect(Hw.Primes.sum_primes_parallel(8,15,2))
