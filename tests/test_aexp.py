import unittest

import io

from aexp.aexp import assemble, Machine as AEMachine
from meta import Machine


def load(path):
    with open(path, "r") as fh:
        it = fh.read()
    if it.lstrip().startswith("#"):
        it = it.split("\n", 1)[1]
    return it


META = load("meta.asm")
GRAM = load("aexp/aexp.g")
CASE = load("aexp/case1.aexp")


def run(code, desc):
    output = io.StringIO()
    m = Machine(code, desc, file=output)
    m.run()
    return output.getvalue()


class TestRoundtrip(unittest.TestCase):
    def test_make_aexp_compiler(self):
        result = run(META, GRAM)
        print(f"result = {result!r}")
        self.assertRegex(result, r"^  ADR AEXP\n")

    def test_compile_aexp(self):
        aexp_compiler = run(META, GRAM)
        ae_code = run(aexp_compiler, CASE)
        print(f"ae_code = {ae_code}")
        for w in "#! mul add fern gamma":
            self.assertRegex(ae_code, w)

    def test_run_machine(self):
        aexp_compiler = run(META, GRAM)
        ae_code = run(aexp_compiler, CASE)
        m = AEMachine(ae_code)
        m.run()
        self.assertEqual(m.mem[m.syms["fern"]], 11)
        self.assertEqual(m.mem[m.syms["ace"]], 55)
        self.assertEqual(m.mem[m.syms["beta"]], 0)
