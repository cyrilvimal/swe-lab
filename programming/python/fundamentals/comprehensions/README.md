# Comprehensions

## Problem

Building a collection from another collection with an explicit loop is verbose.

## What Is It?

Concise syntax for constructing lists, sets, and dicts from an iterable, optionally filtered.

## Why Does It Matter?

Comprehensions are idiomatic and often faster than an equivalent manual loop.

## How It Works

`[expr for item in iterable if condition]` evaluates `expr` for each `item` that passes `condition`.

## Example

See [comprehensions_examples.py](../../examples/fundamentals/comprehensions_examples.py).

## Exercises

See [Fundamentals Exercises](../../exercises/fundamentals/README.md#comprehensions).

## Trade-offs

### Advantages

- Concise and often faster than manual loops.

### Disadvantages

- Deeply nested comprehensions hurt readability.

## Common Mistakes

- Nesting comprehensions beyond one level for the sake of brevity.

## Related Concepts

- [Collections](../collections/README.md)

## Further Reading

- [List Comprehensions](https://docs.python.org/3/tutorial/datastructures.html#list-comprehensions)