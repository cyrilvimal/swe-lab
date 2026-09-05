"""Runnable examples for the Syntax topic."""


def describe_indentation() -> str:
    if True:
        result = "indentation defines this block"
    return result


if __name__ == "__main__":
    print(describe_indentation())