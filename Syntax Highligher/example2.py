# Variables and Arithmetic operations
a = 10
b = 5

# Addition
c = a + b
print("Addition:", c)

# Subtraction
d = a - b
print("Subtraction:", d)

# Multiplication
e = a * b
print("Multiplication:", e)

# Division
f = a / b
print("Division:", f)

# Comparison operators
x = 7
y = 3

# Equal to
print("Equal to:", x == y)

# Not equal to
print("Not equal to:", x != y)

# Greater than
print("Greater than:", x > y)

# Less than
print("Less than:", x < y)

# Classes
class Rectangle:
    def __init__(self, length, width):
        self.length = length
        self.width = width
    
    def calculate_area(self):
        return self.length * self.width

# Creating an instance of the Rectangle class
rect = Rectangle(5, 4)
area = rect.calculate_area()
print("Area of the rectangle:", area)

# Loops
# While loop
i = 0
while i < 5:
    print("While loop iteration:", i)
    i += 1

# For loop
fruits = ["apple", "banana", "orange"]
for fruit in fruits:
    print("Fruit:", fruit)

# Boolean variables
is_raining = True
is_sunny = False

print("Is it raining?", is_raining)
print("Is it sunny?", is_sunny)
