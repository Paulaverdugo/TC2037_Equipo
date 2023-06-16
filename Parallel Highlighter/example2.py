def prime_factors(n):
    # Find the prime factors of a number
    factors = []
    i = 2
    while i * i <= n:
        if n % i:
            i += 1
        else:
            n //= i
            factors.append(i)
    if n > 1:
        factors.append(n)
    return factors

def insertion_sort(arr):
    # Sort a list using the insertion sort algorithm
    for i in range(1, len(arr)):
        key = arr[i]
        j = i - 1
        while j >= 0 and arr[j] > key:
            arr[j + 1] = arr[j]
            j -= 1
        arr[j + 1] = key
    return arr

def fibonacci_sequence(n):
    # Generate the Fibonacci sequence up to a given number
    sequence = [0, 1]
    while sequence[-1] + sequence[-2] <= n:
        next_num = sequence[-1] + sequence[-2]
        sequence.append(next_num)
    return sequence

# Test the prime factors function
num = int(input("Enter a number to find its prime factors: "))
factors = prime_factors(num)
print("The prime factors of", num, "are:", factors)

# Test the insertion sort function
unsorted_list = [9, 5, 1, 3, 8, 2, 7, 6, 4]
sorted_list = insertion_sort(unsorted_list)
print("Sorted list:", sorted_list)

# Test the Fibonacci sequence function
limit = int(input("Enter a limit for the Fibonacci sequence: "))
fib_sequence = fibonacci_sequence(limit)
print("Fibonacci sequence up to", limit, "is:", fib_sequence)