#!/usr/bin/env python3
import re

TOKEN = re.compile(r"('[^']*'|\S+)")


def tokenize(src):
    return TOKEN.findall(src)


class Machine:
    def __init__(self, code, src, file=None):
        self.code = code
        self.src = tokenize(src)
        self.file = file

        self.i = 0
        self.switch = False
        self.token = ""
        self.gensym = 0
        self.output = "    "

        self.labels = {
            line[1]: i
            for i, line in enumerate(code)
            if line[0] == "LABEL"
        }

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
        self.stack.extend([None, None, self.pc])
        self.pc = self.lookup(arg)

    def r(self):
        self.pc = self.stack[-1]
        self.stack[-3:] = []

    def set(self):
        self.switch = True

    def b(self, arg):
        self.pc = self.lookup(arg)

    def bt(self, arg):
        if self.switch:
            self.pc = self.lookup(arg)

    def bf(self, arg):
        if not self.switch:
            self.pc = self.lookup(arg)

    def be(self):
        if not self.switch:
            self.error()

    def cl(self, arg):
        self.output += arg[1:-1]

    def ci(self):
        self.output += self.token

    def gn1(self):
        if not self.stack[-3]:
            self.gensym = self.gensym + 1
            self.stack[-3] = self.gensym
        self.output += "L{}".format(self.stack[-3])

    def gn2(self):
        if not self.stack[-2]:
            self.gensym = self.gensym + 1
            self.stack[-2] = self.gensym
        self.output += "L{}".format(self.stack[-2])

    def lb(self):
        self.output = self.output.lstrip()

    def out(self):
        print(self.output, file=self.file)
        self.output = "    "

    def label(self, _arg):
        pass

    def adr(self, arg):
        if arg.isnumeric():
            self.pc = int(arg)
        else:
            self.pc = self.lookup(arg)

    def end(self):
        return True

    def lookup(self, arg):
        return self.labels[arg]

    def run(self):
        while 0 <= self.pc < len(self.code):
            line = self.code[self.pc]
            # print(f'(self.pc, line) = {(self.pc, line)!r}')
            self.pc += 1
            getattr(self, line[0].lower())(*line[1:])


def munge_asm(asm):
    return [
        tokenize(line) if line[0].isspace() else ['LABEL', line]
        for line in asm.split("\n")
        if line and not line.lstrip().startswith("#")
    ]


def main(args):
    try:
        with open(args[1], "r") as fh:
            code = munge_asm(fh.read())
        src = "meta.g" if len(args) < 3 else args[2]
        with open(src, "r") as fh:
            src = fh.read()
            if src.startswith("#!"):
                src = src.split('\n', 1)[1]
    except IOError:
        print("""\
        Usage: python3 meta.py <order code file> <compiler-description>
        """)
        return 5

    cs = Machine(code, src)
    cs.run()


if __name__ == '__main__':
    import sys
    sys.exit(main(tuple(sys.argv)) or 0)
