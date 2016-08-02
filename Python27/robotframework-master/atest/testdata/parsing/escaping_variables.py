sp = ' '
tab = '\t'
hash = '#'
nl = '\n'
not_nl = '\\n'
cr = '\r'
not_cr = '\\r'
x00 = '\x00'
xE4 = u'\xE4'
xFF = u'\xFF'
u2603 = u'\u2603'  # SNOWMAN
uFFFF = u'\uFFFF'
try:
    U00010905 = unichr(int('00010905', 16))  # PHOENICIAN LETTER WAU
except ValueError:  # occurs on "narrow" Python builds
    U00010905 = 'U00010905'
bs = '\\'
var = '${non_existing}'
pipe = '|'
