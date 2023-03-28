import pytest

import day_13

def test_optimal_happiness():
    happiness_data = {
        "Alice": {"Bob": 54, "Carol": -79, "David": -2},
        "Bob": {"Alice": 83, "Carol": -7, "David": -63},
        "Carol": {"Alice": -62, "Bob": 60, "David": 55},
        "David": {"Alice": 46, "Bob": -7, "Carol": 41}
    }
    
    assert day_13.optimal_happiness(happiness_data) == 330

