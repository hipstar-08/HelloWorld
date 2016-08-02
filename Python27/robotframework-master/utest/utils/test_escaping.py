import unittest


from robot.utils.asserts import assert_equals
from robot.utils.escaping import escape, unescape


def assert_unescape(inp, exp):
    assert_equals(unescape(inp), exp, repr(inp))


class TestUnEscape(unittest.TestCase):

    def test_no_unescape(self):
        for inp in ['no escapes', '']:
            assert_unescape(inp, inp)

    def test_single_backslash(self):
        for inp, exp in [('\\', ''),
                         ('\\ ', ' '),
                         ('\\ ', ' '),
                         ('a\\', 'a'),
                         ('\\a', 'a'),
                         ('a\\b\\c\\d', 'abcd')]:
            assert_unescape(inp, exp)

    def test_multiple_backslash(self):
        for inp, exp in [('\\\\', '\\'),
                         ('\\\\\\', '\\'),
                         ('\\\\\\\\', '\\\\'),
                         ('\\\\\\\\\\', '\\\\'),
                         ('x\\\\x', 'x\\x'),
                         ('x\\\\\\x', 'x\\x'),
                         ('x\\\\\\\\x', 'x\\\\x')]:
            assert_unescape(inp, exp)

    def test_newline(self):
        for inp, exp in [('\\n', '\n'),
                         ('\\\\n', '\\n'),
                         ('\\\\\\n', '\\\n'),
                         ('\\n ', '\n'),
                         ('\\\\n ', '\\n '),
                         ('\\\\\\n ', '\\\n'),
                         ('\\nx', '\nx'),
                         ('\\\\nx', '\\nx'),
                         ('\\\\\\nx', '\\\nx'),
                         ('\\n x', '\nx'),
                         ('\\\\n x', '\\n x'),
                         ('\\\\\\n x', '\\\nx')]:
            assert_unescape(inp, exp)

    def test_carriage_return(self):
        for inp, exp in [('\\r', '\r'),
                         ('\\\\r', '\\r'),
                         ('\\\\\\r', '\\\r'),
                         ('\\r ', '\r '),
                         ('\\\\r ', '\\r '),
                         ('\\\\\\r ', '\\\r '),
                         ('\\rx', '\rx'),
                         ('\\\\rx', '\\rx'),
                         ('\\\\\\rx', '\\\rx'),
                         ('\\r x', '\r x'),
                         ('\\\\r x', '\\r x'),
                         ('\\\\\\r x', '\\\r x')]:
            assert_unescape(inp, exp)

    def test_tab(self):
        for inp, exp in [('\\t', '\t'),
                         ('\\\\t', '\\t'),
                         ('\\\\\\t', '\\\t'),
                         ('\\t ', '\t '),
                         ('\\\\t ', '\\t '),
                         ('\\\\\\t ', '\\\t '),
                         ('\\tx', '\tx'),
                         ('\\\\tx', '\\tx'),
                         ('\\\\\\tx', '\\\tx'),
                         ('\\t x', '\t x'),
                         ('\\\\t x', '\\t x'),
                         ('\\\\\\t x', '\\\t x')]:
            assert_unescape(inp, exp)

    def test_invalid_x(self):
        for inp in r'\x \xxx xx\xxx \x0 \x0g \X00'.split():
            assert_unescape(inp, inp.replace('\\', ''))

    def test_valid_x(self):
        for inp, exp in [(r'\x00', u'\x00'),
                         (r'\xab\xBA', u'\xab\xba'),
                         (r'\xe4iti', u'\xe4iti')]:
            assert_unescape(inp, exp)

    def test_invalid_u(self):
        for inp in r'\u \ukekkonen b\uu \u0 \u123 \u123x'.split():
            assert_unescape(inp, inp.replace('\\', ''))

    def test_valid_u(self):
        for inp, exp in [(r'\u0000', u'\x00'),
                         (r'\uABba', u'\uabba'),
                         (r'\u00e4iti', u'\xe4iti')]:
            assert_unescape(inp, exp)

    def test_invalid_U(self):
        for inp in r'\U \Ukekkonen b\Uu \U0 \U1234567 \U1234567x'.split():
            assert_unescape(inp, inp.replace('\\', ''))

    def test_valid_U(self):
        try:
            u00010905 = unichr(int('00010905', 16))  # PHOENICIAN LETTER WAU
        except ValueError:  # occurs on "narrow" Python builds
            u00010905 = 'U00010905'
        for inp, exp in [(r'\U00000000', u'\x00'),
                         (r'\U0000ABba', u'\uabba'),
                         (r'\U00010905', u00010905),
                         (r'\U000000e4iti', u'\xe4iti')]:
            assert_unescape(inp, exp)

    def test_U_above_valid_range(self):
        assert_unescape(r'\U12345678', 'U12345678')
        assert_unescape(r'\UffffFFFF', 'UffffFFFF')


class TestEscape(unittest.TestCase):

    def test_escape(self):
        for inp, exp in [('nothing to escape', 'nothing to escape'),
                         ('still nothing $ @', 'still nothing $ @' ),
                         ('1 backslash to 2: \\', '1 backslash to 2: \\\\'),
                         ('3 bs to 6: \\\\\\', '3 bs to 6: \\\\\\\\\\\\'),
                         ('\\' * 1000, '\\' * 2000 ),
                         ('${notvar}', '\\${notvar}'),
                         ('@{notvar}', '\\@{notvar}'),
                         ('${nv} ${nv} @{nv}', '\\${nv} \\${nv} \\@{nv}'),
                         ('\\${already esc}', '\\\\\\${already esc}'),
                         ('\\${ae} \\\\@{ae} \\\\\\@{ae}',
                          '\\\\\\${ae} \\\\\\\\\\@{ae} \\\\\\\\\\\\\\@{ae}'),
                         ('%{reserved}', '\\%{reserved}'),
                         ('&{reserved}', '\\&{reserved}'),
                         ('*{reserved}', '\\*{reserved}'),
                         ('x{notreserved}', 'x{notreserved}'),
                         ('named=arg', 'named\\=arg')]:
            assert_equals(escape(inp), exp, inp)


if __name__ == '__main__':
    unittest.main()
