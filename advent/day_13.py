
from itertools import permutations


def optimal_happiness(happiness_data):
    guests = list(happiness_data.keys())

    def calculate_happiness(arrangement):
        happiness = 0
        for i, guest in enumerate(arrangement):
            left_neighbour = arrangement[i - 1]
            right_neighbour = arrangement[(i + 1) % len(arrangement)]
            happiness += happiness_data[guest][left_neighbour] + happiness_data[guest][right_neighbour] 
        return happiness
    
    max_happiness = float('-inf')
    for arrangement in permutations(guests):
        happiness = calculate_happiness(arrangement)
        max_happiness = max(max_happiness, happiness)
    return max_happiness

def main():
    with open('inputs/day_13.txt', '+r') as f:
        data = f.readlines()

    print("Part 1: ", data)
if __name__ == '__main__':
    main()