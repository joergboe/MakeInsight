# Functions That Control Make

#Usage: 50_functions_to_control_make.mk

# see: https://www.gnu.org/software/make/manual/html_node/Make-Control-Functions.html

$(info -§1- Info function - $$(info text))
$(info This function does nothing more than print its (expanded) argument to standard output.)
$(info The result of the expansion of this function is the empty string.)

#NOTE: $(info) without space is the expansion of variable info
info = content of variable info
#$(info) # *** missing separator.  Stop.

#NOTE $(info ) with space prints an empty line
$(info )

$(info -§2- Warning function - $$(warning text))
# Print its (expanded) argument to standard error.
#The result of the expansion of this function is the empty string.
$(warning Warning message!)

$(info -§2a- So, if you put it inside a recipe or on the right side of a recursive variable assignment,)
$(info it won’t be evaluated until later.)

not_yet_defined_function = $(warning This function is not defined!)
$(call not_yet_defined_function)

$(info -§3- Error function - $$(error text))
$(info Generates a fatal error where the message is text. )

ERR = $(error The error target!)
error_target:; $(ERR)
