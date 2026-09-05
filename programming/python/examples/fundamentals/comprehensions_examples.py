"""Runnable examples for the Comprehensions topic."""


def even_squares(limit: int) -> list:
    return [n * n for n in range(limit) if n % 2 == 0]


if __name__ == "__main__":
    print(even_squares(10))