from collections import defaultdict
from itertools import product

NUMBER_STRING = ""
with open("2.txt") as f:
    NUMBER_STRING = f.readline()


def add(n1p, n2p, destp):
    TAPE[destp] = TAPE[n1p] + TAPE[n2p]


def mult(n1p, n2p, destp):
    TAPE[destp] = TAPE[n1p] * TAPE[n2p]


OPMAP = defaultdict(lambda: False)
OPMAP[1] = add
OPMAP[2] = mult


for in1, in2 in product(range(100), repeat=2):
    pointer = 0
    TAPE = [int(x) for x in NUMBER_STRING.split(",")]
    TAPE[1] = in1
    TAPE[2] = in2

    while (op := TAPE[pointer]) != 99:
        ACTION = OPMAP[op]
        if not ACTION:
            raise RuntimeError("Operation not found: %s: %s" % (pointer, op))
        ACTION(TAPE[pointer + 1], TAPE[pointer + 2], TAPE[pointer + 3])
        pointer += 4

    if TAPE[0] == 19690720:
        print("Advent of Code 2019: 2-2")
        print(in1, in2)
