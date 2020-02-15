import math

SUM = 0
with open("1.txt") as f:
    for line in f:
        SUM += math.floor(int(line) / 3) - 2

print("Advent of Code 2019: 1-1")
print(SUM)
