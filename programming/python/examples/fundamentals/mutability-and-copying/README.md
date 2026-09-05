# Mutability and Copying

## Question

Does assigning a list to a new variable copy it, or share it?

## Hypothesis

Assignment shares the same object; only explicit copying creates an independent list.

## Setup

See [experiment.py](experiment.py).

## Experiment

Assign a list to a second variable, mutate one, and compare identity and contents. Repeat using `copy.copy` and `copy.deepcopy`.

## Observation

Run `python experiment.py` and record the printed identities and values.

## Result

Plain assignment shares the same object; `copy.copy` creates a shallow copy; `copy.deepcopy` creates a fully independent copy.

## Conclusion

Use `copy.deepcopy` only when nested mutable structures must be fully independent; prefer plain reference sharing when independence is not required.

## Lessons Learned

Document any surprises found while running the experiment.

## Related

- [Data Types](../../../../programming/python/fundamentals/data-types/README.md)
- [Collections](../../../../programming/python/fundamentals/collections/README.md)