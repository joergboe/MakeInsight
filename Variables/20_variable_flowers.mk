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

$(info Recursively Expanded Variables - assign with =)
xr = bar
yr = foo $(xr)
$(info expansion of xr - $(xr))
$(info expansion of yr - $(yr))

xr = later
$(info expansion of xr - $(xr))
$(info expansion of yr - $(yr))
$(info )

# Simply Expanded Variable Assignment
# Simply expanded variables are defined by lines using ‘:=’ or ‘::=’. Both forms are equivalent in GNU make; however
# only the ‘::=’ form is described by the POSIX standard.
# The value of a simply expanded variable is scanned once, expanding any references to other variables and functions,
# when the variable is defined. Once that expansion is complete the value of the variable is never expanded again: when
# the variable is used the value is copied verbatim as the expansion. If the value contained variable references the
# result of the expansion will contain their values as of the time this variable was defined.
# See: https://www.gnu.org/software/make/manual/html_node/Simple-Assignment.html

$(info Simply Expanded Variables - assign with := or ::=)
xs := bar
ys := foo $(xs)
$(info expansion of xs - $(xs))
$(info expansion of ys - $(ys))

xs ::= later
$(info expansion of xs - $(xs))
$(info expansion of ys - $(ys))
$(info )

# Immediately Expanded Variable Assignment
# Another form of assignment allows for immediate expansion, but unlike simple assignment the resulting variable is
# recursive: it will be re-expanded again on every use. In order to avoid unexpected results, after the value is
# immediately expanded it will automatically be quoted: all instances of $ in the value after expansion will be
# converted into $$. This type of assignment uses the ‘:::=’ operator.
# See: https://www.gnu.org/software/make/manual/html_node/Immediate-Assignment.html

$(info Immediately Expanded Variables are immediately expanded - assign with :::=)
xi :::= bar
yi :::= foo $(xi)
$(info expansion of xi - $(xi))
$(info expansion of yi - $(yi))

xi :::= later
$(info expansion of xi - $(xi))
$(info expansion of yi - $(yi))

# With the operator :::= it is not possible to assign a variable reference or a function reference to the immediately
# expanded variable. Such references are escaped immediately. Thus during expansion, it won’t expand any variables or
# run any functions.
a = bar
b = $(a)
c :::= foo $(b)
$(info expansion of a = $(a))
$(info expansion of c = $(c))
a = new bar
$(info expansion of a = $(a))
$(info expansion of c = $(c))
$(info )

$(info Functions 'flavor' and 'value')
# The function flavor it tells you the flavor of a variable.
# See: https://www.gnu.org/software/make/manual/html_node/Flavor-Function.html

$(info flavors - yr=$(flavor yr) ys=$(flavor ys) yi=$(flavor yi) z=$(flavor z))

# The value function provides a way for you to use the value of a variable without having it expanded.
# Please note that this does not undo expansions which have already occurred; Note that variable is the name of a
# variable, not a reference to that variable. Therefore you would not normally use a ‘$’ or parentheses when writing it.
# (You can, however, use a variable reference in the name if you want the name not to be a constant.)
# See: https://www.gnu.org/software/make/manual/html_node/Value-Function.html

$(info values - yr=$(value yr) ys=$(value ys) yi=$(value yi))
$(info )

# Recursively Expanded Variables and Immediately Expanded Variables are automatically quoted during assignment
# Simply Expanded Variable are not.
# Recursively Expanded Variables and Immediately Expanded Variables are expanded if used
# Simply Expanded Variable are used verbatim.

vr = one$$two
vs ::= one$$two
vi :::= one$$two
$(info expansion vr=$(vr) value vr=$(value vr))
$(info expansion vs=$(vs) value vs=$(value vs))
$(info expansion vi=$(vi) value vi=$(value vi))
$(info )

# Quoting means dollar symbol is escaped. Hash mark is not affected.
vr = one$$two \# This is not a comment.
vs ::= one$$two \\\# This is not a comment.
vi :::= one$$two \\\\\# This is not a comment.
$(info expansion vr=$(vr) value vr=$(value vr))
$(info expansion vs=$(vs) value vs=$(value vs))
$(info expansion vi=$(vi) value vi=$(value vi))
$(info )

all:
