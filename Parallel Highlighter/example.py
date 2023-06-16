import random
import matplotlib.pyplot as plt

def midpoint(point1, point2):
    # Calculate the midpoint between two points
    x = (point1[0] + point2[0]) / 2
    y = (point1[1] + point2[1]) / 2
    return x, y

def chaos_game(vertices, num_points):
    # Initialize the starting point randomly within the polygon
    current_point = random.choice(vertices)

    # Store the points visited during the chaos game
    points = [current_point]

    # Generate the fractal pattern
    for _ in range(num_points):
        # Randomly select a vertex
        vertex = random.choice(vertices)

        # Calculate the midpoint between the current point and the selected vertex
        current_point = midpoint(current_point, vertex)

        # Add the new point to the list of visited points
        points.append(current_point)

    return points

def plot_fractal(points):
    # Separate x and y coordinates of the points
    x = [point[0] for point in points]
    y = [point[1] for point in points]

    # Plot the fractal pattern
    plt.scatter(x, y, s=1, c='blue')
    plt.title("Chaos Game Fractal")
    plt.xlabel("X")
    plt.ylabel("Y")
    plt.show()

# Define the vertices of the polygon
vertices = [(0, 0), (1, 0), (0.5, 0.866)]

# Specify the number of points to generate
num_points = 5000

# Generate the chaos game fractal
fractal_points = chaos_game(vertices, num_points)

# Plot the fractal pattern
plot_fractal(fractal_points)
