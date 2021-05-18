#!/usr/bin/env python3
import pathlib
import re

TOKEN = re.compile(r"('[^']*'|\*[12]?|[()$]|[^()*' \n]+)")

OPS = (
    "adr b be bf bt cll ci cl end gn id lb num r set sr tst "
    "nl tb lmi lmd"
    "".split())


def tokenize(src):
    if src.startswith("#"):
        src = src.split("\n", 1)[1]
    return TOKEN.findall(src)


def assemble(asm):
    labels = {}
    code = []
    i = 0
    for line in asm.split("\n"):
        if not line.lstrip() or line.lstrip().startswith("#"):
            continue
        if not line[:1].isspace():
            labels[line] = i
        else:
            line = tokenize(line)
            code.append(line)
            i += 1

    for line in code:
        if line[0] in ("ADR", "B", "BT", "BF", "CLL"):
            line[1] = labels.get(line[1])

        line[0] = OPS.index(line[0].lower())

    return tuple(tuple(line) for line in code)


# noinspection PyUnusedFunction
class Machine:
    def __init__(self, code, src, file=None):
        self.code = assemble(code)
        self.src = tokenize(src)
        self.file = file

        self.i = 0
        self.switch = False
        self.token = ""
        self.gensym = 0
        self.margin = 0
        self.output = "  " * self.margin

        self.pc = 0
        self.stack = [None, None, -1]

    def _check(self, pred):
        self.switch = pred(self.src[self.i])
        if self.switch:
            self.token = self.src[self.i]
            self.i += 1

    def tst(self, arg):
        self.switch = self.src[self.i] == arg[1:-1]
        if self.switch:
            self.i += 1

    def id(self):
        self._check(lambda s: s and s[0].isalpha())

    def num(self):
        self._check(lambda s: s.isnumeric())

    def sr(self):
        self._check(lambda s: len(s) > 1 and s[0] == "'" and s[-1] == "'")

    def cll(self, arg):
        self.stack.extend([None, self.pc])
        self.pc = arg

    def r(self):
        self.pc = self.stack[-1]
        self.stack[-2:] = []

    def set(self):
        self.switch = True

    def b(self, arg):
        self.pc = arg

    def bt(self, arg):
        if self.switch:
            self.pc = arg

    def bf(self, arg):
        if not self.switch:
            self.pc = arg

    def be(self):
        if not self.switch:
            self.error()

    def cl(self, arg):
        self.output += arg[1:-1]

    def ci(self):
        self.output += self.token

    def gn(self):
        if not self.stack[-2]:
            self.gensym = self.gensym + 1
            self.stack[-2] = self.gensym
        self.output += "{}".format(self.stack[-2])

    def lb(self):
        self.output = self.output.lstrip()

    def adr(self, arg):
        self.pc = arg

    def end(self):
        return True

    def nl(self):
        print(self.output, file=self.file)
        self.output = "  " * self.margin

    def tb(self):
        self.output = "  " + self.output

    def lmi(self):
        self.margin += 1

    def lmd(self):
        self.margin -= 1

    def run(self):
        ops = {i: getattr(self, o) for i, o in enumerate(OPS)}
        while 0 <= self.pc < len(self.code):
            line = self.code[self.pc]
            # print(f'(self.pc, line) = {(self.pc, line)!r}')
            self.pc += 1
            ops[line[0]](*line[1:])


def main(args):
    try:
        code = pathlib.Path(args[1]).read_text()
        src = pathlib.Path("meta.g" if len(args) < 3 else args[2]).read_text()
    except IOError:
        print(
            """\
        Usage: python3 meta.py <order code file> <compiler-description>
        """
        )
        return 5

    cs = Machine(code, src)
    cs.run()


if __name__ == "__main__":
    import sys

    sys.exit(main(tuple(sys.argv)) or 0)
