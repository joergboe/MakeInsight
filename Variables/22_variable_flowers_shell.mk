# The flowers of variables and use.

# Usage:
# make -f 22_variable_flowers_shell.mk
# Expected: Error: *** Recursive variable 'var' references itself (eventually).  Stop.

# A disadvantage of recursively expanded variables is that any functions referenced in the definition will be
# executed every time the variable is expanded. This makes make run slower; worse, it causes the wildcard and shell
# functions to give unpredictable results because you cannot easily control when they are called, or even how many times.

$(info Recursively Expanded Variables - Function/Variable references in the definition will be executed every time the \
variable is expanded.)
xr = foo $(info expansion xr)
$(info xr = $(xr))
$(info xr = $(xr))
$(info )

$(info Simply Expanded Variables - Function/Variable references are scanned at the point of definition.)
xs ::= bar $(info definition xs)
$(info xs = $(xs))
$(info xs = $(xs))
$(info )

$(info Immediately Expanded Variables - Function/Variable references are scanned at the point of definition.)
xi :::= baz $(info definition xi)
$(info xi = $(xi))
$(info xi = $(xi))
$(info )

$(info values - xr=$(value xr) xs=$(value xs) xi=$(value xi))
$(info )

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
vars ::= foo
vars ::= $(vars) bar
$(info vars = $(vars))

# But produces a infinite loop for recursively expanded variables.
varr = foo
varr = $(varr) bar
$(info Infinite loop for recursively expanded variables during expansion.)
$(info $(varr))
