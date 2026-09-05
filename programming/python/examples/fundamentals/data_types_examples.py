"""Runnable examples for the Data Types topic."""


def demonstrate_types() -> dict:
    return {
        "int": type(1).__name__,
        "float": type(1.0).__name__,
        "bool": type(True).__name__,
        "str": type("text").__name__,
        "none": type(None).__name__,
    }


if __name__ == "__main__":
    for name, kind in demonstrate_types().items():
        print(f"{name}: {kind}")