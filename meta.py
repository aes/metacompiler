import re

TOKEN = re.compile(r"('[^']*'|\S+)")


def tokenize(src):
    return TOKEN.findall(src)


class Machine:
    def __init__(self, code, src):
        self.code = code
        self.src = tokenize(src)

        self.i = 0
        self.switch = False
        self.token = ""
        self.gensym = 0
        self.output = "\t"

        self.labels = {
            line[1]: i
            for i, line in enumerate(code)
            if line[0] == "LABEL"
        }

        self.pc = 0
        self.stack = [None, None, -1]

    def _check(self, pred):
        self.switch = self.i < len(self.src) and pred(self.src[self.i])
        if self.switch:
            self.token = self.src[self.i]
            self.i += 1

    def tst(self, arg):
        self.switch = self.i < len(self.src) and self.src[self.i] == arg[1:-1]
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
        self.gensym = self.gensym + 1
        if not self.stack[-3]:
            self.stack[-3] = self.gensym
        self.output += "L{}".format(self.gensym)

    def gn2(self):
        self.gensym = self.gensym + 1
        if not self.stack[-2]:
            self.stack[-2] = self.gensym
        self.output += "L{}".format(self.gensym)

    def lb(self):
        self.output = self.output.lstrip()

    def out(self):
        print(self.output)
        self.output = "\t"

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
        if line
    ]


src = """
.SYNTAX PROGRAM

PROGRAM = '.SYNTAX' .ID .OUT ( 'ADR ' * )
          $ ST
          '.END' .OUT ( 'END' ) .,

ST = .ID .LABEL * '=' EX1 '.,' .OUT ( 'R' ) .,

EX1 = EX2 $ ( '/' .OUT ( 'BT ' *1 ) EX2 )
      .LABEL *1 .,

EX2 = ( EX3 .OUT ( 'BF ' *1 ) / OUTPUT )
      $ ( EX3 .OUT ( 'BE' ) / OUTPUT )
      .LABEL *1 .,

EX3 = .ID       .OUT ( 'CLL ' * )
    / .STRING   .OUT ( 'TST ' * )
    / '.ID'     .OUT ( 'ID' )
    / '.NUMBER' .OUT ( 'NUM' )
    / '.STRING' .OUT ( 'SR' )
    / '(' EX1 ')'
    / '.EMPTY'  .OUT ( 'SET' )
    / '$' .LABEL *1 EX3 .OUT ( 'BT ' *1 ) .OUT ( 'SET' ) .,

OUTPUT =
  (
      '.OUT' '(' $ OUT1 ')'
    / '.LABEL' .OUT ( 'LB' ) OUT1
  )
  .OUT ( 'OUT' ) .,

OUT1 = '*1'    .OUT ( 'GN1' )
     / '*2'    .OUT ( 'GN2' )
     / '*'     .OUT ( 'CI' )
     / .STRING .OUT ( 'CL ' * )
     .,

.END
"""


def main():
    with open("meta.asm", "r") as fh:
        code = munge_asm(fh.read())

    cs = Machine(code, src)
    cs.run()


if __name__ == '__main__':
    main()
