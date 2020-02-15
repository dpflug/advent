import math
import functools


def memoize(obj):
    cache = obj.cache = {}

    @functools.wraps(obj)
    def memoizer(*args, **kwargs):
        key = str(args) + str(kwargs)
        if key not in cache:
            cache[key] = obj(*args, **kwargs)
        return cache[key]

    return memoizer


@memoize
def fuel(n, acc):
    new = math.floor(n / 3) - 2

    if new <= 0:
        return acc

    return fuel(new, acc + new)


with open("1.txt") as f:
    SUM = 0
    for l in f:
        SUM += fuel(int(l), 0)

print("Advent of Code 2019: 1-2")
print(SUM)
