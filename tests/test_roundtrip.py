import unittest

import io

from meta import Machine, munge_asm


def load(path):
    with open(path, "r") as fh:
        it = fh.read()
    if it.startswith("#!"):
        it = it.split('\n', 1)[1]
    return it


CODE = load("meta.asm")
DESC = load("meta.g")


class TestRoundtrip(unittest.TestCase):
    def test_roundtrip(self):
        output = io.StringIO()
        code = munge_asm(CODE)
        m = Machine(code, DESC, file=output)
        m.run()
        result = output.getvalue()
        self.assertEqual(CODE, result)
