from collections import defaultdict

NUMBER_STRING = ""
with open("2.txt") as f:
    NUMBER_STRING = f.readline()

TAPE = [int(x) for x in NUMBER_STRING.split(",")]
POINTER = 0


def add(n1p, n2p, destp):
    TAPE[destp] = TAPE[n1p] + TAPE[n2p]


def mult(n1p, n2p, destp):
    TAPE[destp] = TAPE[n1p] * TAPE[n2p]


OPMAP = defaultdict(lambda: False)
OPMAP[1] = add
OPMAP[2] = mult

# Restore computer to state before 1202 error
TAPE[1] = 12
TAPE[2] = 2

while (op := TAPE[POINTER]) != 99:
    ACTION = OPMAP[op]
    if not ACTION:
        raise RuntimeError("Operation not found: %s: %s" % (POINTER, op))
    ACTION(TAPE[POINTER + 1], TAPE[POINTER + 2], TAPE[POINTER + 3])
    POINTER += 4

print("Advent of Code 2019: 2-1")
print(TAPE)
