# Processing of continuation lines in make syntax POSIX compliant

# usage: make -f 12_long_line_posix.mk

# see: https://www.gnu.org/software/make/manual/html_node/Splitting-Lines.html

# If the .POSIX special target is defined then backslash/newline handling is modified slightly to conform to POSIX.2:
# first, whitespace preceding a backslash is not removed and second, consecutive backslash/newlines are not condensed.

.POSIX:

var1 = aa bb\
cc dd

var2 = aa bb      \
cc dd

var3 = aa bb\
    cc dd

var4 = aa bb\
\
\
cc dd

$(info var1='$(var1)')
$(info var2='$(var2)')
$(info var3='$(var3)')
$(info var4='$(var4)')

var5 = aa bb\\
var6 = aa bb\\\\
var7 = aa bb	\\\
cc dd
var8 = aa b            \\\\\
cc dd

$(info A backslash can escape the special meaning of a backslash)
$(info Note: the number of backslashes is not cut into halve)
$(info var5='$(var5)')
$(info var6='$(var6)')

$(info The number of backslashes before a continuation is cut into halve.)
$(info var7='$(var7)')
$(info var8='$(var8)')

$(info Splitting Without Adding Whitespace)
var9 := one$\
        word
# NOTE: The condensed line one$ word undergoes expansion and the variable $( ) is empty.
$(info var9 = '$(var9)')
