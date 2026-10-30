# Processing of continuation lines in make syntax

# usage: make -f 10_long_line.mk

# see: https://www.gnu.org/software/make/manual/html_node/Splitting-Lines.html

# Outside of recipe lines, backslash/newlines are converted into a single space character. Once that is done, all
# whitespace around the backslash/newline is condensed into a single space: this includes all whitespace preceding the
# backslash, all whitespace at the beginning of the line after the backslash/newline, and any consecutive
# backslash/newline combinations.

var1 = aa bb\
cc dd

var2 = aa bb      	\
cc dd

var3 = aa bb\
    cc dd

var4 = aa bb\
\
\
cc dd

$(info Spaces, tabs and newlines are joined to a single space character.)
$(info var1='$(var1)')
$(info var2='$(var2)')
$(info var3='$(var3)')
$(info var4='$(var4)')

var5 = aa bb\\
var6 = aa bb\\\\
var7 = aa bb\\\
cc dd
var8 = aa b \\\\\
cc dd

$(info A backslash can escape the special meaning of a backslash.)
$(info Note: The number of backslashes is not cut into halve!)
$(info var5='$(var5)')
$(info var6='$(var6)')

$(info NOTE: The number of backslashes before a continuation is cut into halve!)
$(info var7='$(var7)')
$(info var8='$(var8)')

var5a = aa bb\\# This is a comment

$(info NOTE: The number of backslashes before a hashmark is cut into halve!)
$(info var5a='$(var5a)')

var6a = aa bb\\\\ 
var6b = aa bb\\\\	
$(info NOTE: In assignements spaces and tabs have no special meaning and preceding slashes go unmolested!)
$(info var6a='$(var6a)')
$(info var6b='$(var6b)')

$(info Splitting Without Adding Whitespace)
var9 := one$\
        word
# NOTE: The condensed line one$ word undergoes expansion and the variable with name ' ' (space) is empty.
$(info var9 = '$(var9)')

# A comment \
is continued with bs/newline
var10 = 10 # This comment is also continued... \\\
More comment here.
$(info var10='$(var10)')

var11 = 11 # A even number of backslashes does not introduce a continuation line.\\
$(info Make interprets this a new valid line.)
$(info var11 = '$(var11)')
$(info END)
