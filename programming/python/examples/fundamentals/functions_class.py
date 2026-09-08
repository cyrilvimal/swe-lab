"""Runnable examples for the Functions and Classes topic."""

class Greeter:
    def __init__(self, name: str, greeting: str = "Hello") -> None:
        self.name = name
        self.greeting = greeting

    def greet(self) -> str:
        return f"{self.greeting}, {self.name}!"

if __name__ == "__main__":
    greeter = Greeter("World")
    print(greeter.greet())
    greeter = Greeter("Python", greeting="Hi")
    print(greeter.greet())