# The flowers of variables.

# Usage:
# make -f 25_more_variable_assignements.mk

xr = foo
xs ::= bar
xi :::= baz

$(info Conditional assignement - operator ?=)
# The operators '?=' and '+=' preserve the flavor of the variable, if it exists, and creates a recursively expanded
# variable if the variable not exists.
xr ?= new
xs ?= new
xi ?= new
z ?= new

$(info expansions - xr=$(xr) xs=$(xs) xi=$(xi) z=$(z))
$(info flavors - xr=$(flavor xr) xs=$(flavor xs) xi=$(flavor xi) z=$(flavor z))
$(info )

$(info Conditional assignement to an empty var)
# The operator '?=' is a shorthand for:
# ifeq ($(origin FOO), undefined)
# FOO = bar
# endif
FOO =
FOO ?= new
$(info If FOO was empty but defined after assignment FOO ?= bar is '$(FOO)')
$(info )

$(info Append - operator +=)
xr += $(z)
xs += $(z)
xi += $(z)
zz += $(z)
$(info flavors - xr=$(flavor xr) xs=$(flavor xs) xi=$(flavor xi) zz=$(flavor zz))
$(info expansions - xr='$(xr)' xs='$(xs)' xi='$(xi)' zz='$(zz)')
z = newest
$(info z = $(z))
$(info expansions - xr='$(xr)' xs='$(xs)' xi='$(xi)' zz='$(zz)')
$(info values     - xr='$(value xr)' xs='$(value xs)' xi='$(value xi)' zz='$(value zz)')
$(info NOTE: Variable xi is considered a recursive variable; when you append to it with ‘+=’ the value on the)
$(info right-hand side is not expanded immediately!)
$(info )

$(info Append to an empty var)
FOO =
FOO += bar
$(info If FOO was empty but defined after assignment FOO ?= bar is '$(FOO)')
empty ::=
space ::= $(empty) $(empty)
FOO = $(space)
FOO += bar
$(info If FOO was a single space after assignment FOO ?= bar is '$(FOO)')
$(info )

$(info The assignment from shell output !=)
# see: https://www.gnu.org/software/make/manual/html_node/Setting.html
# The shell assignment operator ‘!=’ can be used to execute a shell script and set a variable to its output.
# This operator first evaluates the right-hand side, then passes that result to the shell for execution.
# If the result of the execution ends in a newline, that one newline is removed; all other newlines are replaced
# by spaces. The resulting string is then placed into the named recursively-expanded variable.
from_shell != echo -e 'item1\nitem2\nitem3'
$(info from_shell = '$(from_shell)')
$(info flavor = '$(flavor from_shell)')

# If the result of the execution could produce a $, and you don’t intend what follows that to be interpreted as a
# make variable or function reference, then you must replace every $ with $$ as part of the execution.
# Alternatively, you can set a simply expanded variable to the result of running a program using the shell function call.
magic = ***********
cmd = printf '\044(magic)'
from_shell != $(cmd)
$(info from_shell = '$(from_shell)')
$(info value = '$(value from_shell)')

cmd = printf '$$(magic)'
from_shell != $(cmd)
$(info from_shell = '$(from_shell)')
$(info value = '$(value from_shell)')

all:
