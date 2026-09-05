# Data Types

## Problem

Choosing the wrong data type leads to incorrect results or unnecessary conversions.

## What Is It?

Python's built-in scalar types: `int`, `float`, `bool`, `str`, and `NoneType`.

## Why Does It Matter?

Understanding mutability, truthiness, and numeric behavior avoids subtle bugs.

## How It Works

Every value has a type determined at runtime; variables are references to objects, not typed containers.

## Example

See [data_types_examples.py](../../examples/fundamentals/data_types_examples.py).

## Exercises

See [Fundamentals Exercises](../../exercises/fundamentals/README.md#data-types).

## Trade-offs

### Advantages

- Dynamic typing speeds up prototyping.

### Disadvantages

- Type errors surface at runtime instead of compile time.

## Common Mistakes

- Comparing floats with `==` instead of a tolerance.
- Confusing `is` with `==`.

## Related Concepts

- [Collections](../collections/README.md)

## Further Reading

- [Built-in Types](https://docs.python.org/3/library/stdtypes.html)