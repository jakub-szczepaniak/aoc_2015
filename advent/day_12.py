import json

def sum_numbers(data, skip=None):
    if isinstance(data, int):
        return data
    elif isinstance(data, list):
        return sum(sum_numbers(x, skip) for x in data)
    elif isinstance(data, dict):
        if skip is not None and skip in data.values():
            return 0
        return sum(sum_numbers(x, skip) for x in data.values())
    else:
        return 0

def part_1(data):
    return sum_numbers(data)

def part_2(data):
    return sum_numbers(data, 'red')

def main():
    with open('inputs/day_12.json', '+r') as f:
        data = json.load(f)
    
    print("Part 1: ", part_1(data))
    print("Part 2: ", part_2(data))

if __name__ == '__main__':
    main()