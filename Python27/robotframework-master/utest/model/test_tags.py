import unittest

from robot.utils.asserts import assert_equal, assert_true, assert_false
from robot import utils
from robot.model.tags import *


class TestTags(unittest.TestCase):

    def test_empty_init(self):
        assert_equal(list(Tags()), [])

    def test_init_with_string(self):
        assert_equal(list(Tags('string')), ['string'])

    def test_init_with_iterable_and_normalization_and_sorting(self):
        for inp in [['T 1', 't2', 't_3'],
                    ('t2', 'T 1', 't_3'),
                    ('t2', 'T 2', '__T__2__', 'T 1', 't1', 't_1', 't_3', 't3'),
                    ('', 'T 1', '', 't2', 't_3', 'NONE')]:
            assert_equal(list(Tags(inp)), ['T 1', 't2', 't_3'])

    def test_init_with_none(self):
        assert_equal(list(Tags(None)), [])

    def test_add_string(self):
        tags = Tags(['Y'])
        tags.add('x')
        assert_equal(list(tags), ['x', 'Y'])

    def test_add_iterable(self):
        tags = Tags(['A'])
        tags.add(('b b', '', 'a', 'NONE'))
        tags.add(Tags(['BB', 'C']))
        assert_equal(list(tags), ['A', 'b b', 'C'])

    def test_remove_string(self):
        tags = Tags(['a', 'B B'])
        tags.remove('a')
        assert_equal(list(tags), ['B B'])
        tags.remove('bb')
        assert_equal(list(tags), [])

    def test_remove_non_existing(self):
        tags = Tags(['a'])
        tags.remove('nonex')
        assert_equal(list(tags), ['a'])

    def test_remove_iterable(self):
        tags = Tags(['a', 'B B'])
        tags.remove(['nonex', '', 'A'])
        tags.remove(Tags('__B_B__'))
        assert_equal(list(tags), [])

    def test_remove_using_pattern(self):
        tags = Tags(['t1', 't2', '1', '1more'])
        tags.remove('?2')
        assert_equal(list(tags), ['1', '1more', 't1'])
        tags.remove('*1*')
        assert_equal(list(tags), [])

    def test_add_and_remove_none(self):
        tags = Tags(['t'])
        tags.add(None)
        tags.remove(None)
        assert_equal(list(tags), ['t'])

    def test_contains(self):
        assert_true('a' in Tags(['a', 'b']))
        assert_true('c' not in Tags(['a', 'b']))
        assert_true('AA' in Tags(['a_a', 'b']))

    def test_contains_pattern(self):
        assert_true('a*' in Tags(['a', 'b']))
        assert_true('a*' in Tags(['u2', 'abba']))
        assert_true('a?' not in Tags(['a', 'abba']))

    def test_length(self):
        assert_equal(len(Tags()), 0)
        assert_equal(len(Tags(['a', 'b'])), 2)

    def test_truth(self):
        assert_true(not Tags())
        assert_true(not Tags('NONE'))
        assert_true(Tags(['a']))

    def test_unicode(self):
        assert_equal(unicode(Tags()), '[]')
        assert_equal(unicode(Tags(['y', "X'X", 'Y'])), "[X'X, y]")
        assert_equal(unicode(Tags([u'\xe4', 'a'])), u'[a, \xe4]')

    def test_str(self):
        assert_equal(str(Tags()), '[]')
        assert_equal(str(Tags(['y', "X'X"])), "[X'X, y]")
        assert_equal(str(Tags([u'\xe4', 'a'])), '[a, \xc3\xa4]')

    def test_repr(self):
        for tags in ([], ['y', "X'X"], [u'\xe4', 'a']):
            assert_equal(repr(Tags(tags)), repr(sorted(tags)))

    def test__add__list(self):
        tags = Tags(['xx', 'yy'])
        new_tags = tags + ['zz', 'ee', 'XX']
        assert_true(isinstance(new_tags, Tags))
        assert_equal(list(tags), ['xx', 'yy'])
        assert_equal(list(new_tags), ['ee', 'xx', 'yy', 'zz'])

    def test__add__tags(self):
        tags1 = Tags(['xx', 'yy'])
        tags2 = Tags(['zz', 'ee', 'XX'])
        new_tags = tags1 + tags2
        assert_true(isinstance(new_tags, Tags))
        assert_equal(list(tags1), ['xx', 'yy'])
        assert_equal(list(tags2), ['ee', 'XX', 'zz'])
        assert_equal(list(new_tags), ['ee', 'xx', 'yy', 'zz'])

    def test__add__list(self):
        tags = Tags(['xx', 'yy'])
        new_tags = tags + None
        assert_true(isinstance(new_tags, Tags))
        assert_equal(list(tags), ['xx', 'yy'])
        assert_equal(list(new_tags), list(tags))
        assert_true(new_tags is not tags)

    def test_getitem_with_index(self):
        tags = Tags(['2', '0', '1'])
        assert_equal(tags[0], '0')
        assert_equal(tags[1], '1')
        assert_equal(tags[2], '2')

    def test_getitem_with_slice(self):
        tags = Tags(['2', '0', '1'])
        self._verify_slice(tags[:], ['0', '1', '2'])
        self._verify_slice(tags[1:], ['1', '2'])
        self._verify_slice(tags[1:-1], ['1'])
        self._verify_slice(tags[1:-2], [])
        self._verify_slice(tags[::2], ['0', '2'])

    def _verify_slice(self, sliced, expected):
        assert_true(isinstance(sliced, Tags))
        assert_equal(list(sliced), expected)


class TestNormalizing(unittest.TestCase):

    def test_empty(self):
        self._verify([], [])

    def test_case_and_space(self):
        for inp in ['lower'], ['MiXeD', 'UPPER'], ['a few', 'spaces here']:
            self._verify(inp, inp)

    def test_underscore(self):
        self._verify(['a_tag', 'a tag', 'ATag'], ['a_tag'])
        self._verify(['tag', '_t_a_g_'], ['tag'])

    def test_remove_empty_and_none(self):
        for inp in ['', 'X', '', '  ', '\n'], ['none', 'N O N E', 'X', '', '_']:
            self._verify(inp, ['X'])

    def test_remove_dupes(self):
        for inp in ['dupe', 'DUPE', ' d u p e '], ['d U', 'du', 'DU', 'Du']:
            self._verify(inp, [inp[0]])

    def test_sorting(self):
        for inp, exp in [(['SORT','1','B','2','a'], ['1','2','a','B','SORT']),
                         (['all', 'A L L', 'NONE', '10', '1', 'A', 'a', ''],
                           ['1', '10', 'A', 'all'])]:
            self._verify(inp, exp)

    def _verify(self, tags, expected):
        assert_equal(list(Tags(tags)), expected)


class TestTagPatterns(unittest.TestCase):

    def test_match(self):
        patterns = TagPatterns(['x', 'y', 'z*'])
        assert_false(patterns.match([]))
        assert_false(patterns.match(['no', 'match']))
        assert_true(patterns.match(['x']))
        assert_true(patterns.match(['xxx', 'zzz']))

    def test_match_with_and(self):
        patterns = TagPatterns(['xANDy', '???ANDz'])
        assert_false(patterns.match([]))
        assert_false(patterns.match(['x']))
        assert_true(patterns.match(['x', 'y', 'z']))
        assert_true(patterns.match(['123', 'y', 'z']))

    def test_match_with_not(self):
        patterns = TagPatterns(['xNOTy', '???NOT?'])
        assert_false(patterns.match([]))
        assert_false(patterns.match(['x', 'y']))
        assert_false(patterns.match(['123', 'y', 'z']))
        assert_true(patterns.match(['x']))
        assert_true(patterns.match(['123', 'xx']))

    def test_match_with_not_and_and(self):
        patterns = TagPatterns(['xNOTyANDz', 'aANDbNOTc',
                                '1 AND 2? AND 3?? NOT 4* AND 5* AND 6*'])
        assert_false(patterns.match([]))
        assert_false(patterns.match(['x', 'y', 'z']))
        assert_true(patterns.match(['x', 'y']))
        assert_true(patterns.match(['x']))
        assert_false(patterns.match(['a', 'b', 'c']))
        assert_false(patterns.match(['a']))
        assert_false(patterns.match(['b']))
        assert_true(patterns.match(['a', 'b']))
        assert_true(patterns.match(['a', 'b', 'xxxx']))
        assert_false(patterns.match(['1', '22', '33']))
        assert_false(patterns.match(['1', '22', '333', '4', '5', '6']))
        assert_true(patterns.match(['1', '22', '333']))
        assert_true(patterns.match(['1', '22', '333', '4', '5', '7']))

    def test_match_with_multiple_nots(self):
        patterns = TagPatterns(['xNOTyNOTz', '1 NOT 2 NOT 3 NOT 4'])
        assert_true(patterns.match(['x']))
        assert_false(patterns.match(['x', 'y']))
        assert_false(patterns.match(['x', 'z']))
        assert_false(patterns.match(['x', 'y', 'z']))
        assert_false(patterns.match(['xxx']))
        assert_true(patterns.match(['1']))
        assert_false(patterns.match(['1', '3', '4']))
        assert_false(patterns.match(['1', '2', '3']))
        assert_false(patterns.match(['1', '2', '3', '4']))

    def test_match_with_multiple_nots_with_ands(self):
        patterns = TagPatterns('a AND b NOT c AND d NOT e AND f')
        assert_true(patterns.match(['a', 'b']))
        assert_true(patterns.match(['a', 'b', 'c']))
        assert_true(patterns.match(['a', 'b', 'c', 'e']))
        assert_false(patterns.match(['a', 'b', 'c', 'd']))
        assert_false(patterns.match(['a', 'b', 'e', 'f']))
        assert_false(patterns.match(['a', 'b', 'c', 'd', 'e', 'f']))
        assert_false(patterns.match(['a', 'b', 'c', 'd', 'e']))

    def test_seq2str(self):
        patterns = TagPatterns([u'is\xe4', u'\xe4iti'])
        assert_equal(utils.seq2str(patterns), u"'is\xe4' and '\xe4iti'")


if __name__ == '__main__':
    unittest.main()
