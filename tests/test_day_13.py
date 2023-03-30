import pytest

import day_13

happiness_data_1 = {
        "Alice": {"Bob": 54, "Carol": -79, "David": -2},
        "Bob": {"Alice": 83, "Carol": -7, "David": -63},
        "Carol": {"Alice": -62, "Bob": 60, "David": 55},
        "David": {"Alice": 46, "Bob": -7, "Carol": 41}
    }

happiness_data_2 = {
        "A": {"B": 10, "C": 20},
        "B": {"A": 30, "C": 40},
        "C": {"A": 50, "B": 60}
    }

happiness_data_3 = {
        "X": {"Y": 5, "Z": -10},
        "Y": {"X": 15, "Z": 20},
        "Z": {"X": -5, "Y": 25}
    }

@pytest.fixture(params=[(happiness_data_1, 330), (happiness_data_2, 210), (happiness_data_3, 50)])
def happiness_data(request):
    return request.param

def test_optimal_happiness(happiness_data):
    input, expected = happiness_data
    assert day_13.optimal_happiness(input) == expected

def test_parse_arrangement_data():
    data = [
        "Alice would gain 54 happiness units by sitting next to Bob.",
        "Alice would lose 79 happiness units by sitting next to Carol.",
        "Alice would lose 2 happiness units by sitting next to David.",
        "Bob would gain 83 happiness units by sitting next to Alice.",
        "Bob would lose 7 happiness units by sitting next to Carol.",
        "Bob would lose 63 happiness units by sitting next to David.",
        "Carol would lose 62 happiness units by sitting next to Alice.",
        "Carol would gain 60 happiness units by sitting next to Bob.",
        "Carol would gain 55 happiness units by sitting next to David.",
        "David would gain 46 happiness units by sitting next to Alice.",
        "David would lose 7 happiness units by sitting next to Bob.",
        "David would gain 41 happiness units by sitting next to Carol."
    ]
    expected = {
        "Alice": {"Bob": 54, "Carol": -79, "David": -2},
        "Bob": {"Alice": 83, "Carol": -7, "David": -63},
        "Carol": {"Alice": -62, "Bob": 60, "David": 55},
        "David": {"Alice": 46, "Bob": -7, "Carol": 41}
    }
    assert day_13.parse_arrangement_data(data) == expected
