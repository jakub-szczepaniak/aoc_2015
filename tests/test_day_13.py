import pytest

import day_13

@pytest.fixture
def single_line():
    return 'Alice would gain 54 happiness units by sitting next to Bob.'



def test_single_line_to_dict(single_line):
    assert day_13.parse_line(single_line) == {
        'Alice': {
            'Bob': 54
        }
    }