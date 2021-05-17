import unittest

import io

from meta import Machine


def load(path):
    with open(path, "r") as fh:
        it = fh.read()
    if it.lstrip().startswith("#"):
        it = it.split('\n', 1)[1]
    return it


CODE = load("meta.asm")
DESC = load("meta.g")


class TestRoundtrip(unittest.TestCase):
    def test_roundtrip(self):
        output = io.StringIO()
        m = Machine(CODE, DESC, file=output)
        m.run()
        result = output.getvalue()
        self.assertEqual(CODE, result)
