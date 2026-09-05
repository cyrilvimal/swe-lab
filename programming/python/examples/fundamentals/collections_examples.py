"""Runnable examples for the Collections topic."""


def build_collections() -> tuple:
    items_list = [1, 2, 2, 3]
    items_tuple = (1, 2, 3)
    items_set = {1, 2, 2, 3}
    items_dict = {"a": 1, "b": 2}
    return items_list, items_tuple, items_set, items_dict


if __name__ == "__main__":
    print(build_collections())