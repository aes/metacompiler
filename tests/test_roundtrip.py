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


def run(code, desc):
    output = io.StringIO()
    m = Machine(code, desc, file=output)
    m.run()
    return output.getvalue()


class TestRoundtrip(unittest.TestCase):
    def test_roundtrip(self):
        result = run(CODE, DESC)
        self.assertEqual(CODE, result)

    def test_second_roundtrip(self):
        new_code = run(CODE, DESC)
        result = run(new_code, DESC)
        self.assertEqual(new_code, result)
