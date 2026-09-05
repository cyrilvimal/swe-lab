# Modules

## Problem

Large programs need to be split into organized, reusable units.

## What Is It?

A module is a `.py` file; a package is a directory of modules with an `__init__.py`.

## Why Does It Matter?

Modules enable code reuse, namespacing, and separation of concerns across files.

## How It Works

`import` loads a module once per process and caches it in `sys.modules`; `__name__ == "__main__"` distinguishes direct execution from import.

## Example

See [modules_examples](../../examples/fundamentals/modules_examples/usage.py).

## Exercises

See [Fundamentals Exercises](../../exercises/fundamentals/README.md#modules).

## Common Mistakes

- Circular imports between two modules.
- Relying on import side effects.

## Related Concepts

- [Functions](../functions/README.md)

## Further Reading

- [Modules](https://docs.python.org/3/tutorial/modules.html)