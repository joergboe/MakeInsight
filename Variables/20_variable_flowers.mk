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

$(info Recursively Expanded Variables)
x = foo
y = $(x) bar
$(info expansion of x - $(x))
$(info expansion of y - $(y))

x = later
$(info expansion of x - $(x))
$(info expansion of y - $(y))

# Multiline variable definition (or define y =):

x = foo
define ym
    $(x)
    bar
endef
$(info expansion of x - $(x))
$(info expansion of multiline ym)
$(info $(ym))

x = later
$(info expansion of x - $(x))
$(info expansion of multiline ym)
$(info $(ym))
$(info )

# Simply Expanded Variable Assignment
# Simply expanded variables are defined by lines using ‘:=’ or ‘::=’. Both forms are equivalent in GNU make; however
# only the ‘::=’ form is described by the POSIX standard.
# The value of a simply expanded variable is scanned once, expanding any references to other variables and functions,
# when the variable is defined. Once that expansion is complete the value of the variable is never expanded again: when
# the variable is used the value is copied verbatim as the expansion. If the value contained variable references the
# result of the expansion will contain their values as of the time this variable was defined.
# See: https://www.gnu.org/software/make/manual/html_node/Simple-Assignment.html

$(info Simply Expanded Variables)
xs := foo
ys := $(xs) bar
$(info expansion of xs - $(xs))
$(info expansion of ys - $(ys))

xs ::= later
$(info expansion of xs - $(xs))
$(info expansion of ys - $(ys))

# Multiline variable definition of a simply expanded variable:
xs ::= foo
define ysm ::=
    $(xs)
    bar
endef
$(info expansion of xs - $(xs))
$(info expansion of multiline ysm)
$(info $(ysm))
$(info )
xs ::= later
$(info expansion of xs - $(xs))
$(info expansion of multiline ysm)
$(info $(ysm))
$(info )

# Immediately Expanded Variable Assignment
# Another form of assignment allows for immediate expansion, but unlike simple assignment the resulting variable is
# recursive: it will be re-expanded again on every use. In order to avoid unexpected results, after the value is
# immediately expanded it will automatically be quoted: all instances of $ in the value after expansion will be
# converted into $$. This type of assignment uses the ‘:::=’ operator.
# See: https://www.gnu.org/software/make/manual/html_node/Immediate-Assignment.html

$(info Immediately Expanded Variables are immediately expanded)
xi :::= first
yi :::= $(xi)
$(info expansion of xi - $(xi))
$(info expansion of yi - $(yi))
xi :::= second
$(info expansion of xi - $(xi))
$(info expansion of yi - $(yi))

$(info Immediately Expanded Variables are automatically quoted)
xi :::= one$$two
yi :::= foo$$bar $(xi)
$(info expansion of xi - $(xi))
$(info expansion of yi - $(yi))
xi :::= three$$four
$(info expansion of xi - $(xi))
$(info expansion of yi - $(yi))
$(info )

# Multiline variable definition of a immediately expanded variable:
xi :::= one$$two
define yim :::=
    $(xi)
    foo$$bar
endef
$(info expansion of xi - $(xi))
$(info expansion of multiline yim)
$(info $(yim))

xi :::= three$$four
$(info expansion of xi - $(xi))
$(info expansion of multiline yim)
$(info $(yim))
$(info )
$(info The assignement operator :::= leads to a direct expansion of the right hand side and creates a recursive variable flower.)
$(info )

# With the operator :::= it is not possible to assign a variable reference or a function reference to the immediately
# expanded variable. Such references are escaped immediately. Thus during expansion, it won’t expand any variables or
# run any functions.
a = bar
b = $(a)
c :::= foo $(b)
$(info expansion of a = $(a))
$(info expansion of c = $(c))
$(info )
a = new bar
$(info expansion of a = $(a))
$(info expansion of c = $(c))
$(info )

# The function flavor it tells you the flavor of a variable.
# See: https://www.gnu.org/software/make/manual/html_node/Flavor-Function.html

$(info flavors - y=$(flavor y) ys=$(flavor ys) yi=$(flavor yi) z=$(flavor z))

# The value function provides a way for you to use the value of a variable without having it expanded.
# Please note that this does not undo expansions which have already occurred; Note that variable is the name of a
# variable, not a reference to that variable. Therefore you would not normally use a ‘$’ or parentheses when writing it.
# (You can, however, use a variable reference in the name if you want the name not to be a constant.)
# See: https://www.gnu.org/software/make/manual/html_node/Value-Function.html

$(info values - y=$(value y) ys=$(value ys) yi=$(value yi))
$(info )

# Recursively Expanded Variables and Immediately Expanded Variables are automatically quoted during assignment
# Simply Expanded Variable are not.
# Recursively Expanded Variables and Immediately Expanded Variables are expanded if used Simply Expanded Variable are
# used verbatim.

v = one$$two
vs ::= three$$four
vi :::= five$$six
$(info expansion v=$(v) value v=$(value v))
$(info expansion vs=$(vs) value vs=$(value vs))
$(info expansion vi=$(vi) value vi=$(value vi))
$(info )

# The operators '?=' and '+=' preserve the flavor of the variable, if it exists, and creates a recursively expanded
# variable if the variable not exists.

x ?= new
xs ?= new
xi ?= new
z ?= new

$(info Conditional assignement 'new')
$(info expansions - x=$(x) xs=$(xs) xi=$(xi) z=$(z))
$(info flavors - x=$(flavor x) xs=$(flavor xs) xi=$(flavor xi) z=$(flavor z))
$(info )

$(info Append '$$(z)')
y += $(z)
ys += $(z)
yi += $(z)
$(info expansions - y=$(y) ys=$(ys) yi=$(yi) z=$(z))
$(info flavors - y=$(flavor y) ys=$(flavor ys) yi=$(flavor yi))
$(info )
$(info The flavor of the variables is maintained!)
z = newest
$(info expansion of z = $(z))
$(info expansions - y=$(y) ys=$(ys) yi=$(yi) z=$(z))
$(info Note: Variable yi is considered a recursive variable; when you append to it with ‘+=’ the value on the)
$(info right-hand side is not expanded immediately!)
$(info )

# A disadvantage of recursively expanded variables is that any functions referenced in the definition will be
# executed every time the variable is expanded. This makes make run slower; worse, it causes the wildcard and shell
# functions to give unpredictable results because you cannot easily control when they are called, or even how many times.

$(info For a recursively expanded variable the shell runs every time the variable is expanded!)
recursive_var = $(shell echo Run the shell >&2; date; sleep 2)
$(info recursive_var = $(recursive_var))
$(info recursive_var = $(recursive_var))
$(info )
$(info For a simply expanded variable the shell runs once when the variable is assigned to.)
simple_var := $(shell echo Run the shell >&2; date; sleep 2)
$(info simple_var = $(simple_var))
$(info simple_var = $(simple_var))

# Care must be taken if content is added to a variable
# This works fine for a simple variable.
vars := foo
vars := $(var) bar
$(info vars = $(vars))

# But produces a infinite loop for recursively expanded variables.
var = foo
var = $(var) bar
$(info var = $(var))
