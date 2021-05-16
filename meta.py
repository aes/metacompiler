
class Machine:
    def __init__(self, code, src):
        self.code = code
        self.src = src.split()

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
        print(self.output.replace("_", " "))
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
        line.strip().split() if line[0].isspace() else ['LABEL', line]
        for line in asm.split("\n")
        if line
    ]


asm = """
    ADR PROGRAM
OUT1
    TST '*1'
    BF L1
    CL 'GN1'
    OUT
L1
    BT L2
    TST '*2'
    BF L3
    CL 'GN2'
    OUT
L3
    BT L2
    TST '*'
    BF L4
    CL 'CI'
    OUT
L4
    BT L2
    SR
    BF L5
    CL 'CL_'
    CI
    OUT
L5
L2
    R
OUTPUT
    TST '.OUT'
    BF L6
    TST '('
    BE
L7
    CLL OUT1
    BT L7
    SET
    BE
    TST ')'
    BE
L6
    BT L8
    TST '.LABEL'
    BF L9
    CL 'LB'
    OUT
    CLL OUT1
    BE
L9
L8
    BF L10
    CL 'OUT'
    OUT
L10
L11
    R
EX3
    ID
    BF L12
    CL 'CLL_'
    CI
    OUT
L12
    BT L13
    SR
    BF L14
    CL 'TST_'
    CI
    OUT
L14
    BT L13
    TST '.ID'
    BF L15
    CL 'ID'
    OUT
L15
    BT L13
    TST '.NUMBER'
    BF L16
    CL 'NUM'
    OUT
L16
    BT L13
    TST '.STRING'
    BF L17
    CL 'SR'
    OUT
L17
    BT L13
    TST '('
    BF L18
    CLL EX1
    BE
    TST ')'
    BE
L18
    BT L13
    TST '.EMPTY'
    BF L19
    CL 'SET'
    OUT
L19
    BT L13
    TST '$'
    BF L20
    LB
    GN1
    OUT
    CLL EX3
    BE
    CL 'BT_'
    GN1
    OUT
    CL 'SET'
    OUT
L20
L13
    R
EX2
    CLL EX3
    BF L21
    CL 'BF_'
    GN1
    OUT
L21
    BT L22
    CLL OUTPUT
    BF L23
L23
L22
    BF L24
L25
    CLL EX3
    BF L26
    CL 'BE'
    OUT
L26
    BT L27
    CLL OUTPUT
    BF L28
L28
L27
    BT L25
    SET
    BE
    LB
    GN1
    OUT
L24
L29
    R
EX1
    CLL EX2
    BF L30
L31
    TST '/'
    BF L32
    CL 'BT_'
    GN1
    OUT
    CLL EX2
    BE
L32
L33
    BT L31
    SET
    BE
    LB
    GN1
    OUT
L30
L34
    R
ST
    ID
    BF L35
    LB
    CI
    OUT
    TST '='
    BE
    CLL EX1
    BE
    TST '.,'
    BE
    CL 'R'
    OUT
L35
L36
    R
PROGRAM
    TST '.SYNTAX'
    BF L37
    ID
    BE
    CL 'ADR_'
    CI
    OUT
L38
    CLL ST
    BT L38
    SET
    BE
    TST '.END'
    BE
    CL 'END'
    OUT
L37
L39
    R
    END
"""

code = munge_asm(asm)

src = """
.SYNTAX PROGRAM

PROGRAM = '.SYNTAX' .ID .OUT ( 'ADR_' * )
          $ ST
          '.END' .OUT ( 'END' ) .,

ST = .ID .LABEL * '=' EX1 '.,' .OUT ( 'R' ) .,

EX1 = EX2 $ ( '/' .OUT ( 'BT_' *1 ) EX2 )
      .LABEL *1 .,

EX2 = ( EX3 .OUT ( 'BF_' *1 ) / OUTPUT )
      $ ( EX3 .OUT ( 'BE' ) / OUTPUT )
      .LABEL *1 .,

EX3 = .ID       .OUT ( 'CLL_' * )
    / .STRING   .OUT ( 'TST_' * )
    / '.ID'     .OUT ( 'ID' )
    / '.NUMBER' .OUT ( 'NUM' )
    / '.STRING' .OUT ( 'SR' )
    / '(' EX1 ')'
    / '.EMPTY'  .OUT ( 'SET' )
    / '$' .LABEL *1 EX3 .OUT ( 'BT_' *1 ) .OUT ( 'SET' ) .,

OUTPUT =
  (
      '.OUT' '(' $ OUT1 ')'
    / '.LABEL' .OUT ( 'LB' ) OUT1
  )
  .OUT ( 'OUT' ) .,

OUT1 = '*1'    .OUT ( 'GN1' )
     / '*2'    .OUT ( 'GN2' )
     / '*'     .OUT ( 'CI' )
     / .STRING .OUT ( 'CL_' * )
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
