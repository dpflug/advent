from collections import defaultdict
from itertools import product

number_string = ""
with open("2.txt") as f:
    number_string = f.readline()


def add(n1p, n2p, destp):
    tape[destp] = tape[n1p] + tape[n2p]


def mult(n1p, n2p, destp):
    tape[destp] = tape[n1p] * tape[n2p]

opmap = defaultdict(lambda: False)
opmap[1] = add
opmap[2] = mult


for in1, in2 in product(range(100), repeat=2):
    pointer = 0
    tape = [int(x) for x in number_string.split(",")]
    tape[1] = in1
    tape[2] = in2

    while (op := tape[pointer]) != 99:
        action = opmap[op]
        if not action:
            raise RuntimeError("Operation not found: %s: %s" % (pointer, op))
        action(tape[pointer + 1], tape[pointer + 2], tape[pointer + 3])
        pointer += 4

    if tape[0] == 19690720:
        print(in1, in2)
