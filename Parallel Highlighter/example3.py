class MathProblemSolver:
    def __init__(self, num1, num2):
        self.num1 = num1
        self.num2 = num2

    def solve_problem(self):
        # Arithmetic operations
        addition = self.num1 + self.num2
        subtraction = self.num1 - self.num2
        multiplication = self.num1 * self.num2
        division = self.num1 / self.num2

        # Comparison operators
        greater_than = self.num1 > self.num2
        less_than = self.num1 < self.num2
        equal_to = self.num1 == self.num2
        not_equal_to = self.num1 != self.num2

        # Loop
        for i in range(self.num1):
            print("Iteration:", i)

        # Boolean variable
        is_positive = self.num1 > 0

        # Print results
        print("Addition:", addition)
        print("Subtraction:", subtraction)
        print("Multiplication:", multiplication)
        print("Division:", division)
        print("Greater than:", greater_than)
        print("Less than:", less_than)
        print("Equal to:", equal_to)
        print("Not equal to:", not_equal_to)
        print("Is positive?", is_positive)


# Create an instance of the MathProblemSolver class
problem_solver = MathProblemSolver(10, 5)
problem_solver.solve_problem()
