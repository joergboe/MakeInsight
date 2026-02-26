# Conditional parts of Makefiles

# Usage:
# > make -f 40_conditionals.mk

# see: https://www.gnu.org/software/make/manual/html_node/Conditionals.html

# Syntax of a simple conditional:
#	conditional-directive
#	text-if-true
#	endif

# Syntax of a complete conditional:
#	conditional-directive
#	text-if-true
#	else
#	text-if-false
#	endif

# Conditional can be concatenated:
#	conditional-directive-one
#	text-if-one-is-true
#	else conditional-directive-two
#	text-if-two-is-true
#	else
#	text-if-one-and-two-are-false
#	endif
# The final else part is optionally here.

$(info -§1- Conditional Directive - ifeq (arg1, arg2))
# Expand all variable references in arg1 and arg2 and compare them.If they are identical,
# the text-if-true is effective; otherwise, the text-if-false, if any, is effective.
# These forms are supported:
#	ifeq (arg1, arg2)
#	ifeq 'arg1' 'arg2'
#	ifeq "arg1" "arg2"
#	ifeq "arg1" 'arg2'
#	ifeq 'arg1' "arg2"
empty ::=
space ::= $(empty) $(empty)

foo ::= string
bar = $(baz)
baz = string

ifeq ($(foo), $(bar))
  $(info The expanded value of bar equals the expanded value of bar: '$(bar)')
endif

ifeq ( $(space) , $(space) )
  $(info -§1a- In syntax (arg1, arg2) spaces are allowed between parentheses, arguments and comma!)
endif
# NOTE: In syntax (arg1, arg2) spaces are allowed between parentheses, arguments and comma!

ifeq "$(space)" " "
  $(info -§1b- Variable space expands to a single space character.)
endif
# NOTE: Use the syntax with quotation marks to compare space characters.

foo = $(empty)
$(info -§1c- To test for an empty value, use ifeq ($$(foo),))
ifeq ($(foo),)
  $(info foo has the empty value.)
endif

# Often you want to test if a variable has a non-empty value. When the value results from complex expansions of
# variables and functions, expansions you would consider empty may actually contain whitespace characters and thus are
# not seen as empty. However, you can use the strip function to avoid interpreting whitespace as a non-empty value.
foo = $(space)
$(info -§1d- to avoid interpreting whitespace as a non-empty value, use ifeq ($$(strip $$(foo)),))
ifeq ($(strip $(foo)),)
  $(info foo has either the empty value or contains whitespaces only.)
endif

$(info -§2- Conditional Directive - ifneq (arg1, arg2))
# Expand all variable references in arg1 and arg2 and compare them. If they are different,
# the text-if-true is effective; otherwise, the text-if-false, if any, is effective.
# These forms are supported:
#	ifneq (arg1, arg2)
#	ifneq 'arg1' 'arg2'
#	ifneq "arg1" "arg2"
#	ifneq "arg1" 'arg2'
#	ifneq 'arg1' "arg2"

foo ::= string
$(info -§2a- Extra spaces and comments are allowed in all 4 Conditionals.)
target:
  ifneq '$(foo)' '$(bar)'		# Conditional with indention
    $(error This must not happen!)
  else			# Comment
    $(info The expanded value of bar equals the expanded value of bar)
  endif			# Comment
# NOTE: Extra spaces are allowed and ignored at the beginning of the conditional directive line,
#       but a tab is not allowed. (If the line begins with a tab, it will be considered part of a recipe for a rule.)
#       Aside from this, extra spaces or tabs may be inserted with no effect anywhere except within the directive name
#       or within an argument.
#       A comment starting with ‘#’ may appear at the end of the line.

$(info -§3- Conditional Directive ifdef variable-name)
# The ifdef form takes the name of a variable as its argument, not a reference to a
# variable. If the value of that variable has a non-empty value, the text-if-true is effective; otherwise,
# the text-if-false, if any, is effective.

ifdef foo
  $(info foo is defined)
endif

foo = $(empty)
ifdef foo
  $(info -§3a- foo is defined, the value is '$(value foo)' ifdef/ifndef does not expand the variable)
endif
# NOTE: ifdef only tests whether a variable has a value. It does not expand the variable to see if that value
#       is nonempty.

# But
ifdef empty # Tests using ifdef return true for all definitions except those like foo =
    $(error This must not happen!)
  else			# Comment
  $(info -§3b- empty is not defined, the value is '$(value empty)')
endif

$(info -§3d- The text variable-name is expanded, so it could be a variable or function that expands to the name of a variable.)
foo = space
ifdef $(foo)
  $(info The variable $(foo) is defined)
endif

foo = empty
ifdef $(foo)
    $(error This must not happen!)
  else
  $(info The variable $(foo) is not defined)
endif

$(info -§4- Conditional Directive ifndef variable-name)
# If the variable variable-name has an empty value, the text-if-true is effective; otherwise, the text-if-false, if any,
# is effective. The rules for expansion and testing of variable-name are identical to the ifdef directive.

ifndef undefiend_variable
  $(info -§4a- undefiend_variable is not defined. A undefined variable yields an empty value.)
endif

ifndef empty
  $(info -§4b- Variable empty has the empty value.)
endif

ifndef $(foo)
  $(info -§4c- The text variable-name is expanded. Variable $(foo) has the empty value.)
endif

# NOTE: make evaluates conditionals when it reads a makefile. Consequently, you cannot use automatic variables in the
#       tests of conditionals because they are not defined until recipes are run.
