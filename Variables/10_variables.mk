# Basics of variable usage.

# Usage:
# make -f 10_variables.mk

# A variable is a name defined in a makefile to represent a string of text, called the variable’s value. These values
# are substituted by explicit request into targets, prerequisites, recipes, and other parts of the makefile.
# See: https://www.gnu.org/software/make/manual/html_node/Using-Variables.html

# A variable name may be any sequence of characters not containing ‘:’, ‘#’, ‘=’, or whitespace. However, variable names
# containing characters other than letters, numbers, and underscores should be considered carefully
# Variable names are case-sensitive.

# It is traditional to use upper case letters in variable names, but we recommend using lower case letters for variable
# names that serve internal purposes in the makefile, and reserving upper case for parameters that control implicit
# rules or for parameters that the user should override with command options.

# A few variables have names that are a single punctuation character or just a few characters. These are the automatic
# variables, and they have particular specialized uses.

# There are different ways that a variable in GNU make can get a value; we call them the flavors of variables. The
# flavors are distinguished in how they handle the values they are assigned in the makefile, and in how those values are
# managed when the variable is later used and expanded.
# See: https://www.gnu.org/software/make/manual/html_node/Flavors.html

# To set a variable from the makefile, write a line starting with the variable name followed by one of the assignment
# operators ‘=’, ‘:=’, ‘::=’, or ‘:::=’. Whatever follows the operator and any initial whitespace on the line becomes
# the value. Whitespace around the variable name and immediately after the ‘=’ is ignored.
# The variable name may contain function and variable references, which are expanded when the directive is read to find
# the actual variable name to use.
# See: https://www.gnu.org/software/make/manual/html_node/Setting.html

sources = main.c foo.c bar.c utils.c
objects = main.o foo.o bar.o utils.o

# To substitute a variable’s value, write a dollar sign followed by the name of the variable in parentheses or braces:
# either ‘$(foo)’ or ‘${foo}’ is a valid reference to the variable foo.
# This special significance of ‘$’ is why you must write ‘$$’ to have the effect of a single dollar sign in a file name
# or recipe.

$(info The info function prints a text to the terminal.)
$(info Variable objects contains - $(objects))
$(info $${sources} = ${sources})

# A dollar sign followed by a character other than a dollar sign, open-parenthesis or open-brace treats that single
# character as the variable name. Thus, you could reference the variable x with ‘$x’. However, this practice can lead
# to confusion (e.g., ‘$foo’ refers to the variable f followed by the string oo) so we recommend using parentheses or
# braces around all variables, even single-letter variables, unless omitting them gives significant readability
# improvements. One place where readability is often improved is automatic variables
# See: https://www.gnu.org/software/make/manual/html_node/Reference.html

# A substitution reference substitutes the value of a variable with alterations that you specify.
# It has the form ‘$(var:a=b)’ (or ‘${var:a=b}’) and its meaning is to take the value of the variable var,
# replace every a at the end of a word with b in that value, and substitute the resulting string.
# When we say “at the end of a word”, we mean that a must appear either followed by whitespace or at the end of the
# value in order to be replaced; other occurrences of a in the value are unaltered.
# See: https://www.gnu.org/software/make/manual/html_node/Substitution-Refs.html

$(info Substitution reference I:)
$(info Objects from sources are $(sources:.c=.o))

# A substitution reference is shorthand for the patsubst expansion function

# Another type of substitution reference lets you use the full power of the patsubst function. It has the same form
# ‘$(var:a=b)’ described above, except that now a must contain a single ‘%’ character.

$(info Substitution reference II:)
$(info Objects from sources are $(sources:%.c=%.o))

$(info Function patsubst:)
$(info Objects from sources are $(patsubst %.c,%.o,$(sources)))

$(info )
$(info Comments.)
var1 = foo bar # A single hash mark after a variable assignment introduces a comment.
$(info $$(var1) = $(var1))
var2 = You can place a hash mark in a variable by preceding it with a backslash. \#
$(info $$(var2) = $(var2))
var3 = For the combination backslash followed by a hash mark you must use "N+1 backslashes before hash mark: \\\# \\\\\#
$(info $$(var3) = $(var3))
var4 = An 2N backslashes before a hash mark means N backslashes and the start of a comment! \\# This is comment.
$(info $$(var4) = $(var4))


$(info )
# You can assign arbitrary characters to a Variable except the new line character. Dollar symbols must be escaped by
# another dollar symbol. A hash mark must be preceded by a backslash. A backslash before new line introduces\
a continuation line.
$(info Special chars in variabes.)
var5 = 8 ( . ; : § $$ = 	* + ~ ' " æ ß ? ! & \#\
END
$(info $$(var5) = $(var5))

# Backslashes before characters except the hash mark represent itself.
var6 = 8 \( \. \; \: \§ \$$ \= \	\* \+ \~ \' \" \æ \ß \? \! \& \ END
$(info $$(var6) = $(var6))

var7r = NOTE: A single dollar at line end does not introduce an expansion! $
$(info $$(var7r) = $(var7r))
$(info value $$(var7r) = $(value var7r))

var7s ::= NOTE: A single dollar at line end does not introduce an expansion! $
$(info $$(var7s) = $(var7s))
$(info value $$(var7s) = $(value var7s))

var7i :::= NOTE: A single dollar at line end is escaped! $
$(info $$(var7i) = $(var7i))
$(info value $$(var7i) = $(value var7i))

var8r = NOTE: A single dollar before hash mark references a variable with name \#! $# This is comment
$(info $$(var8r) = $(var8r))
$(info value $$(var8r) = $(value var8r))

var8s ::= NOTE: A single dollar before hash mark references a variable with name \#! $# This is comment
$(info $$(var8s) = $(var8s))
$(info value $$(var8s) = $(value var8s))

var8i :::= NOTE: A single dollar before hash mark references a variable with name \#! $# This is comment
$(info $$(var8i) = $(var8i))
$(info value $$(var8i) = $(value var8i))

# To define multi-line variables you can use the define directive. Aside from this difference in syntax, define works
# just like any other variable definition.
# The variable name may contain function and variable references, which are expanded when the directive is read to find
# the actual variable name to use.
# The final newline before the endef is not included in the value; if you want your value to contain a trailing newline
# you must include a blank line.
# See: https://www.gnu.org/software/make/manual/html_node/Multi_002dLine.html

$(info )
$(info Multi line variables)
define two-lines
    Line one
    Line two
endef
$(info $(two-lines) END)
# NOTE: the last newline of the define is not part of the variable.

# NOTE: a single newline variable requires 2 empty lines!
define nl


endef
$(info Use variable nl:$(nl)line1$(nl)line2)

# A hash mark in a multi line define does not introduce a comment!
define two-lines
    Line one # NOTE: A hash mark in a multi line define does not introduce a comment!
    Line two
endef
$(info $(two-lines) END)

all:
