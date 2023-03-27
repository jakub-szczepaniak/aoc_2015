import json

def part_1(data):
    pass

def part_2(data):
    pass

def main():
    with open('inputs/day_12.json', '+r') as f:
        data = json.load(f)
    
    print("Part 1: ", part_1(data))
    print("Part 2: ", part_2(data))
    print(data)
    print(len(data))

if __name__ == '__main__':
    main()