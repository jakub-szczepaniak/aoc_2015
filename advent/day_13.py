
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

def parse_arrangement_data(data):
    happiness_data = {}
    for line in data:
        parts = line.split()
        guest = parts[0]
        neighbour = parts[-1].rstrip('.')
        happiness_uints = int(parts[3])

        if parts[2] == 'lose':
            happiness_uints = -happiness_uints

        if guest not in happiness_data:
            happiness_data[guest] = {}

        happiness_data[guest][neighbour] = happiness_uints
    return happiness_data
    
def main():
    with open('inputs/day_13.txt', '+r') as f:
        data = f.readlines()
    parsed = parse_arrangement_data(data)
    result = optimal_happiness(parsed)
    print("Part 1: ", result)
if __name__ == '__main__':
    main()