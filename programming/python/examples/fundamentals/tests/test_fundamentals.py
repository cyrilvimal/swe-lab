import pytest

from ..exercise_01_syntax import is_equal
from ..exercise_02_data_types import is_close
from ..exercise_03_collections import deduplicate
from ..exercise_04_functions import append_item
from ..exercise_05_comprehensions import square_odds


def test_is_equal():
    assert is_equal(1, 1)
    assert not is_equal(1, 2)


def test_is_close():
    assert is_close(0.1 + 0.2, 0.3)
    assert not is_close(0.1, 0.2)


def test_deduplicate():
    assert deduplicate([3, 1, 3, 2, 1]) == [3, 1, 2]


def test_append_item_no_shared_state():
    first = append_item(1)
    second = append_item(2)
    assert first == [1]
    assert second == [2]


def test_square_odds():
    assert square_odds([1, 2, 3, 4, 5]) == [1, 9, 25]