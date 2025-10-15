# The flowers of variables.

# Usage:
# make -f 20_variable_flowers.mk

# There are different ways that a variable in GNU make can get a value; we call them the flavors of variables. The
# flavors are distinguished in how they handle the values they are assigned in the makefile, and in how those values are
# managed when the variable is later used and expanded.
# See: https://www.gnu.org/software/make/manual/html_node/Flavors.html

# To set a variable from the makefile, write a line starting with the variable name followed by one of the assignment
# operators ‘=’, ‘:=’, ‘::=’, or ‘:::=’. 

# Recursively Expanded Variable Assignment
# The first flavor of variable is a recursively expanded variable. Variables of this sort are defined by lines using ‘=’
# or by the define directive. The value you specify is installed verbatim; if it contains references to other variables,
# these references are expanded whenever this variable is substituted (in the course of expanding some other string).
# When this happens, it is called recursive expansion.

x = foo
y = $(x) bar
$(info value of x - $(x))
$(info value of y - $(y))

x ::= later
$(info value of x - $(x))
$(info value of y - $(y))

# Multiline variable definition (or define y =):

define y
    $(x)
    new bar
endef
$(info new value of y:)
$(info $(y))

# Simply Expanded Variable Assignment
# Simply expanded variables are defined by lines using ‘:=’ or ‘::=’. Both forms are equivalent in GNU make; however
# only the ‘::=’ form is described by the POSIX standard.
# The value of a simply expanded variable is scanned once, expanding any references to other variables and functions,
# when the variable is defined. Once that expansion is complete the value of the variable is never expanded again: when
# the variable is used the value is copied verbatim as the expansion. If the value contained variable references the
# result of the expansion will contain their values as of the time this variable was defined.
# See: https://www.gnu.org/software/make/manual/html_node/Simple-Assignment.html

xs := foo
ys := $(xs) bar
$(info value of xs - $(xs))
$(info value of ys - $(ys))

xs ::= later
$(info value of xs - $(xs))
$(info value of ys - $(ys))

# Multiline variable definition of a simply expanded variable:
define ys :=
    $(xs)
    new bar
endef
$(info new value of ys:)
$(info $(ys))

# Immediately Expanded Variable Assignment
# Another form of assignment allows for immediate expansion, but unlike simple assignment the resulting variable is
# recursive: it will be re-expanded again on every use. In order to avoid unexpected results, after the value is
# immediately expanded it will automatically be quoted: all instances of $ in the value after expansion will be
# converted into $$. This type of assignment uses the ‘:::=’ operator.
# See: https://www.gnu.org/software/make/manual/html_node/Immediate-Assignment.html

xi = first
yi :::= $(xi)
xi = second
$(info value of xi - $(xi))
$(info value of yi - $(yi))

xi = one$$two
yi :::= $(xi)
xi = three$$four
$(info value of xi - $(xi))
$(info value of yi - $(yi))

# Multiline variable definition of a immediately expanded variable:
define yi :::=
    $(xi)
    new bar
endef
$(info new value of yi:)
$(info $(yi))

# The operators '?=' and '=+' preserve the flavor of the variable, if it exists, and creates a recursively expanded
# variable if the variable not exists.

x ?= new
xs ?= new
xi ?= new

z ?= new
$(info x=$(x) xs=$(xs) xi=$(xi) z=$(z))

# The function flavor it tells you the flavor of a variable.
# See: https://www.gnu.org/software/make/manual/html_node/Flavor-Function.html

$(info x $(flavor x) xs $(flavor xs) xi $(flavor xi) z $(flavor z))

# A disadvantage of recursively expanded variables is that any functions referenced in the definition will be
# executed every time the variable is expanded. This makes make run slower; worse, it causes the wildcard and shell
# functions to give unpredictable results because you cannot easily control when they are called, or even how many times.

$(info shell runs twice!)
recursive_var = $(shell echo Run the shell >&2; date; sleep 2)
$(info recursive_var=$(recursive_var))
$(info recursive_var=$(recursive_var))

$(info shell runs once)
simple_var := $(shell echo Run the shell >&2; date; sleep 2)
$(info simple_var=$(simple_var))
$(info simple_var=$(simple_var))

# Care must be taken if content is added to a variable
# This works fine for a simple variable.
vars := foo
vars := $(var) bar
$(info $(vars))

# But produces a infinite loop for recursively expanded variables.
var = foo
var = $(var) bar
$(info $(var))
