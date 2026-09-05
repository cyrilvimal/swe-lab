# Collections

## Problem

Different tasks require different trade-offs between ordering, uniqueness, and mutability.

## What Is It?

Python's built-in containers: `list`, `tuple`, `set`, and `dict`.

## Why Does It Matter?

Choosing the right container affects correctness and performance.

## How It Works

Lists and dicts are mutable; tuples are immutable; sets enforce uniqueness and are unordered.

## Example

See [collections_examples.py](../../examples/fundamentals/collections_examples.py).

## Exercises

See [Fundamentals Exercises](../../exercises/fundamentals/README.md#collections).

## Trade-offs

| Container | Ordered | Mutable | Duplicates |
|---|---|---|---|
| `list` | Yes | Yes | Yes |
| `tuple` | Yes | No | Yes |
| `set` | No | Yes | No |
| `dict` | Yes | Yes | Keys: No |

## Common Mistakes

- Using a `list` for membership tests instead of a `set`.
- Mutating a list while iterating over it.

## Related Concepts

- [Comprehensions](../comprehensions/README.md)

## Further Reading

- [Data Structures](https://docs.python.org/3/tutorial/datastructures.html)