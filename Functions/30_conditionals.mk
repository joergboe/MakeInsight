# Functions for Conditionals

# Usage: make -f 30_conditionals.mk

# See: https://www.gnu.org/software/make/manual/html_node/Conditional-Functions.html

# There are four functions that provide conditional expansion. A key aspect of these functions is that not all of the
# arguments are expanded initially. Only those arguments which need to be expanded, will be expanded.

$(info $$(if condition,then-part[,else-part]))
# The first argument, condition, first has all preceding and trailing whitespace stripped, then is expanded. If it
# expands to any non-empty string, then the condition is considered to be true. If it expands to an empty string, the
# condition is considered to be false.

empty:=
space:= $(empty) $(empty)

$(info $$(if $$(empty),true,false) = $(if $(empty),true,false))
$(info $$(if   $$(empty)   ,true,false) = $(if   $(empty)   ,true,false))
$(if $(empty),\
	$(info true)\
,\
	$(info false)\
)
$(info $$(if $$(space),true,false) = $(if $(space),true,false))

$(info $$(or condition1[,condition2[,condition3…]]))
# The or function provides a “short-circuiting” OR operation.
$(info $$(and condition1[,condition2[,condition3…]]))
# The and function provides a “short-circuiting” AND operation.
$(info $$(intcmp lhs,rhs[,lt-part[,eq-part[,gt-part]]]))

$(info compare equal)
# call eq,param1,param2
# Expands to 'true' if param1 and param2 are equal or to the empty string otherwise
eq = $(if $(subst $(2),,$(1)),,true)
$(info eq 1 2 = $(call eq,1,2))
$(info eq 1 1 = $(call eq,1,1))
$(info eq -- -- = $(call eq,--,--))
$(info eq -- - - = $(call eq,--,- -))

$(info compare not equal)
# call neq,param1,param2
# Expands to 'true' if param1 and param2 are not equal or to the empty string otherwise
neq = $(if $(subst $(2),,$(1)),true)
$(info neq 1 2 = $(call neq,1,2))
$(info neq 1 1 = $(call neq,1,1))
$(info neq -- -- = $(call neq,--,--))
$(info neq -- - - = $(call neq,--,- -))
