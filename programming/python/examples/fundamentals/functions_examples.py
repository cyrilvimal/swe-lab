"""Runnable examples for the Functions topic."""


def greet(name: str, greeting: str = "Hello") -> str:
    return f"{greeting}, {name}!"


if __name__ == "__main__":
    print(greet("World"))
    print(greet("Python", greeting="Hi"))