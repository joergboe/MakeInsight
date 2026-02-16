# Conditional expansion in functions

# Usage: make -f 30_conditional_expansion.mk

# See: https://www.gnu.org/software/make/manual/html_node/Conditional-Functions.html

empty:=
space:= $(empty) $(empty)

echo_and_return_arg = $(info arg1 = $1)$1

# There are four functions that provide conditional expansion. A key aspect of these functions is that not all of the
# arguments are expanded initially. Only those arguments which need to be expanded, will be expanded.

$(info -§1- $$(if condition,then-part[,else-part]))
# The first argument, condition, first has all preceding and trailing whitespace stripped, then is expanded. If it
# expands to any non-empty string, then the condition is considered to be true. If it expands to an empty string, the
# condition is considered to be false.

# The empty condition yields false
$(info -§1a- $$(if $$(empty),true,false) = '$(if $(empty),true,false)')
# The non empty condition yields true
$(info -§1b- $$(if 1,true,false) = '$(if 1,true,false)')
# NOTE: Spaces around condition are skipped
$(info -§1c- $$(if   $$(empty)   ,true,false) = '$(if   $(empty)   ,true,false)')
# Expansion of a space yields true
$(info -§1d- $$(if $$(space),true,false) = '$(if $(space),true,false)')
# Formatting introduces extra spaces after expansion
$(info -§1e- Formatting \
  '$(if $(empty),\
    true\
  ,\
    false\
  )'\
)

# The or function provides a “short-circuiting” OR operation.
$(info -§2- $$(or condition1[,condition2[,condition3…]]))
$(info -§2a- (or ,) '$(if $(or $(call echo_and_return_arg,,),$(call echo_and_return_arg,,)),true,false)')
$(info -§2b- (or 1,) '$(if $(or $(call echo_and_return_arg,1,),$(call echo_and_return_arg,,)),true,false)')

# The and function provides a “short-circuiting” AND operation.
$(info -§3- $$(and condition1[,condition2[,condition3…]]))
$(info -§3a- (and 1,1) '$(if $(and $(call echo_and_return_arg,1),$(call echo_and_return_arg,1)),true,false)')
$(info -§3b- (and ,1) '$(if $(and $(call echo_and_return_arg,),$(call echo_and_return_arg,1)),true,false)')

# The intcmp function provides support for numerical comparison of integers.
$(info -§4- $$(intcmp lhs,rhs[,lt-part[,eq-part[,gt-part]]]))
$(info less than    '$(intcmp 1,2,lt,eq,gt)')
$(info equal       '$(intcmp 33,33,lt,eq,gt)')
$(info greatet than '$(intcmp 2,1,lt,eq,gt)')

target:
