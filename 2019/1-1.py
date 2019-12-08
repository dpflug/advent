import math

sum = 0
with open("1.txt") as f:
    for line in f:
        sum += math.floor(int(line) / 3) - 2

print(sum)
