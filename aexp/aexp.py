#!/usr/bin/env python3

INST = "psh lea lod sto neg add sub mul div exp".split()


def munge_line(op, a=None, syms=None):
    i = INST.index(op)
    if i == 0:
        return i + (int(a) << 4)
    elif i < 3:
        return i + (syms.setdefault(a, len(syms)) << 4)
    else:
        return i


def assemble(asm):
    syms = {}
    mem = (
        munge_line(*line.strip().split(), syms=syms)
        for line in asm.split("\n")
        if line and not line.lstrip().startswith("#")
    )
    return tuple(i for i in mem if i is not None), syms


# noinspection PyUnusedFunction,PyUnusedName
class Machine:
    def __init__(self, asm):
        code, syms = assemble(asm)
        size = len(syms)
        self.mem = [0] * size + list(code)
        self.segs = (size, size + len(code))
        self.syms = syms

    def dis(self):
        for i, n in sorted((v, k) for k, v in self.syms.items()):
            print(f"{i:3} {self.mem[i]}\t\t# {n}")
        for i, mc in enumerate(self.mem[self.segs[0] : self.segs[1]]):
            op, a = mc & 0xF, (mc >> 4)
            print(f"{i:3} {INST[op]} {a if op < 2 else ''}")

    def psh(self, arg):
        self.mem.append(arg)

    lea = psh

    def lod(self, arg):
        self.mem.append(self.mem[arg])

    def sto(self, _=None):
        self.mem[self.mem.pop()] = self.mem.pop()

    def neg(self, _=None):
        self.mem.append(-self.mem.pop())

    def add(self, _=None):
        self.mem.append(self.mem.pop() + self.mem.pop())

    def sub(self, _=None):
        self.mem.append(self.mem.pop(-2) - self.mem.pop())

    def mul(self, _=None):
        self.mem.append(self.mem.pop() * self.mem.pop())

    def div(self, _=None):
        self.mem.append(self.mem.pop(-2) // self.mem.pop())

    def exp(self, _=None):
        self.mem.append(self.mem.pop(-2) ** self.mem.pop())

    def run(self):
        ii = tuple(getattr(self, inst, None) for inst in INST)
        ip = self.segs[0]
        while 0 <= ip < len(self.mem):
            ii[self.mem[ip] & 0xF](self.mem[ip] >> 4)
            ip += 1


if __name__ == "__main__":
    import sys
    from pathlib import Path

    m = Machine(Path(sys.argv[1]).read_text())
    m.run()
    m.dis()
