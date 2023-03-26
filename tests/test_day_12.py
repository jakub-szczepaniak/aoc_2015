import pytest
import sys

print(sys.path)
import day_12 

def test_day_12():
    assert day_12.main() == None