"""Runnable example demonstrating module import and __main__ guard."""

from . import __init__ as package_init  # noqa: F401 (demonstrates package import)


if __name__ == "__main__":
    print("Run directly: this module is the entry point.")