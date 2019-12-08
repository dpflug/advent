from collections import defaultdict

number_string = ""
with open("2.txt") as f:
    number_string = f.readline()

tape = [int(x) for x in number_string.split(",")]
pointer = 0


def add(n1p, n2p, destp):
    tape[destp] = tape[n1p] + tape[n2p]


def mult(n1p, n2p, destp):
    print("Updating %s" % destp)
    tape[destp] = tape[n1p] * tape[n2p]
    print(tape)


opmap = defaultdict(lambda: False)
opmap[1] = add
opmap[2] = mult

# Restore computer to state before 1202 error
tape[1] = 12
tape[2] = 2

while (op := tape[pointer]) != 99:
    print(
        tape[:pointer],
        "*",
        tape[pointer],
        "*",
        "(",
        tape[pointer + 1 : pointer + 4],
        ")",
        tape[pointer + 4 :],
    )
    print("======")
    action = opmap[op]
    if not action:
        raise RuntimeError("Operation not found: %s: %s" % (pointer, op))
    action(tape[pointer + 1], tape[pointer + 2], tape[pointer + 3])
    pointer += 4

print(tape)
