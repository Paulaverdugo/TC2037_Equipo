def main():
    # Variables 1
    quantity =  5
    message = "Hello, world!"
    list= [1, 2, 3, 4, 5]

    # Function with parameter 3
    def greet(name):
        print(f"Greetings, {name}!")
        

    greet("John")

    # Arithmetic operations 2
    result =  10  +  3
    price =  15  -  4
    total =  6  *  4
    average =  20  /  4

    # Comparison operators
    if result > price:
        print("Result is greater than price")

    if total < average:
        print("Total is less than average")

    # Logical operators
    if result > 0 and price > 0:
        print("Both result and price are positive")

    if total > 0 or average > 0:
        print("At least one of total or average is positive")

    # Looping statements
    for i in range( 4 ):
        print(f"Count: {i}")

    while quantity > 0:
        print(f"Remaining quantity: {quantity}")
        quantity -= 1

    # Class definition
    class Person:
        def __init__(self, name, age):
            self.name = name
            self.age = age

        def greet(self):
            print(f"Hello! My name is {self.name}, and I am {self.age} years old.")

    person = Person("Bob", 25)
    person.greet()

# Boolean variables
    is_true = True
    is_false = False

    # Conditional statements
    if is_true:
        print("This statement is true.")
    else:
        print("This statement is false.")

    if not is_false:
        print('This statement is true.')
    else:
        print('This statement is false.')


class Rectangle:
    def __init__(self, width, height):
        self.width = width
        self.height = height
    
    def get_area(self):
        return self.width * self.height
    
    def get_perimeter(self):
        return 2 * (self.width + self.height)

