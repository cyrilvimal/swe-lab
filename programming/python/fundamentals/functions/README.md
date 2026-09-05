# Functions

## Problem

Repeated logic needs a reusable, testable unit of behavior.

## What Is It?

Named blocks of code defined with `def`, supporting parameters, defaults, and return values.

## Why Does It Matter?

Functions are the primary unit of reuse and testing in Python.

## How It Works

Arguments bind to parameters positionally or by keyword; scope follows the LEGB rule (Local, Enclosing, Global, Built-in).

## Example

See [functions_examples.py](../../examples/fundamentals/functions_examples.py).

## Exercises

See [Fundamentals Exercises](../../exercises/fundamentals/README.md#functions).

## Common Mistakes

- Using a mutable default argument (e.g. `def f(items=[])`).
- Shadowing a built-in name.

## Related Concepts

- [Comprehensions](../comprehensions/README.md)

## Further Reading

- [Defining Functions](https://docs.python.org/3/tutorial/controlflow.html#defining-functions)