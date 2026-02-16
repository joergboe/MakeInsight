# Function syntax

# Usage: make -f 00_functions.mk

# General function syntax you can read here:
# https://www.gnu.org/software/make/manual/html_node/Syntax-of-Functions.html

define text
-§1- Function Call Syntax:
Can use parantheses $$(function argument)
Can use braces      $${function argument}

Arguments are separated from the function name by one or more spaces or tabs.
If there are more than one argument, then tey are separated by comma.
$$(function    arg1,arg2,arg3)

The delimiters which you use to surround the function call, whether parentheses or braces,
can appear in an argument only in matching pairs; the other kind of delimiters may appear singly.

When using characters that are special to make as function arguments, you may need to hide them.
Characters you may need to hide:
	* Commas
	* Initial whitespace in the first argument
	* Unmatched open parenthesis or brace
	* An open parenthesis or brace if you don’t want it to start a matched pair

endef

# The info function does nothing more than print its (expanded) argument(s) to standard output.
# The result of the expansion of this function is the empty string. Thus this function can be used everywhere in a makefile
$(info $(text)|)

# Define variables to hide special characters in function calls
comma := ,
empty :=
space := $(empty) $(empty)

spaces := $(empty)        $(empty)
# NOTE: The last newline is removed - a single newline variable requires 2 empty lines!
define nl :=


endef

$(info -§1a- Spaces before the first argument are removed)
$(info          This text starts at column 1)
$(info -§1b- Hide special characters:)
$(info $(spaces)This text starts at column 8$(nl))

foo := a b c
bar := $(subst $(space),$(comma),$(foo))
$(info bar is now '$(bar)'$(nl))

$(info -§2- Call function: $$(call variable,param,param,…))
# The call function is unique in that it can be used to create new parameterized functions. You can write a complex
# expression as the value of a variable, then use call to expand it with different values.
# See: https://www.gnu.org/software/make/manual/html_node/Call-Function.html

# Reverse two arguments
# call reverse arg1,arg2
reverse = $(2) $(1)
$(info $$(call reverse,11,22) = $(call reverse,11,22)$(nl))

$(info -§3- Function parameters)
# Caution: be careful when adding whitespace to the arguments to call. As with other functions, any whitespace contained
# in the second and subsequent arguments is kept.
# It’s generally safest to remove all extraneous whitespace when providing parameters to call.

# Print 3 input parameters
print_param = '$(1)' '$(2)' '$(3)'

$(info -§3a- Spaces in subsequent arguments are kept$(nl)\
$$(call print_param , a , b    , c  ) = $(call print_param , a , b    , c  ))
# Continuation line (no POSIXS mode) yields one space, preceding and trailing spaces are condensed to one space.
$(info -§3b- Continuation line (no POSIXS mode) yields one space$(nl)\
$$(call print_param,\na,\n    b,   \nc) = $(call print_param,\
a,\
    b,   \
c))
pb = b
pc = c
# Spaces in second and subsequent arguments are kept.
$(info -§3a- $$(call print_param, , $$(pb) , $$(pc) ) = $(call print_param, , $(pb) , $(pc) ))
$(info -§3b- $$(call print_param,\n,$$(pb),\n$$(pc)\n) = $(call print_param,\
,$(pb),\
$(pc)\
))
# Hide a comma in a variable
$(info -§3c- Hide a comma in a variable$(nl)\
$$(call print_param,$$(comma),b) = $(call print_param,$(comma),b))
# Can use multiline variables - The newline is hidden
define multiline
line 1
line 2
endef
$(info -§3d- multiline$(nl)$$(call print_param,a,b$$(multiline)b,   c) = $(call print_param,a,b$(multiline)b,   c))

# paranteses must be a matched pair
$(info -§3e- $$(call print_param,x(x)x,y(y)y, ) = $(call print_param,x(x)x,y(y)y, ))
# braces may be unmatched
$(info -§3f- $$(call print_param,x{xx,yy}y, ) = $(call print_param,x{xx,yy}y, ))
# or use braces - paranteses may be unmatches
${info -§3g- $${call print_param,x(xx,yyy, } = ${call print_param,x(xx,yyy, }}

# NOTE: If a function expands to the empty string, one can use a function in makefile
print = $(info '$1') $(info '$2')
$(info -§4--)
$(call print,aa,bb)

# NOTE: Paramaeter 0 is the Function/Macro/Variable name
$(info -§5--)
print = $(info '$0' '$1' '$2')
$(call print,aa,bb)

# Type of parameter variable is simlple expanded variable
# A parameter variable may be undefined
$(info -§6--)
type_info = $(info type $$1 = $(flavor 1) type $$2 = $(flavor 2) type $$3 = $(flavor 3)\
$(info value $$1 = '$(value 1)' value $$2 = '$(value 2)' value $$3 = '$(value 3)'))
$(call type_info,a,$(comma))

# NOTE: Assignements are not possible in functions.
define assignement
$(info $0)
VAR = $1
$(info end)
endef
$(info -§7-)
#$(call assignement,1234)  # *** missing separator.  Stop.

# Must use eval in such cases
$(eval $(call assignement,1234))
$(info -§8- VAR=$(VAR))

target:
