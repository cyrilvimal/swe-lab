import copy


def run() -> None:
    original = [1, [2, 3]]
    shared = original
    shallow = copy.copy(original)
    deep = copy.deepcopy(original)

    shared.append(4)
    shallow[1].append(99)

    print("original:", original, id(original))
    print("shared:  ", shared, id(shared))
    print("shallow: ", shallow, id(shallow))
    print("deep:    ", deep, id(deep))


if __name__ == "__main__":
    run()