# The origin of variables
# Usage: make -f 60_origin.mk ARG1=abc ARG2:=11

.POSIX:

# See: https://www.gnu.org/software/make/manual/html_node/Origin-Function.html#index-origin-of-variable

# Some variables have a default definition, as is usual with CC and so on.
# See: https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html
# Note: that if you have redefined a default variable, the origin function will return the origin of the later definition.

$(info The Default Variables - origin = default)
$(foreach var,$(sort $(.VARIABLES)),\
	$(if $(subst default,,$(origin $(var))),\
		,\
		$(info $(var) = $($(var))      flavor = $(flavor $(var)))\
	)\
)
$(info )

variable1 = 1
variable2 ::= 2
variable3 :::= 3
$(info Variables defined in this makefile - origin = file)
$(foreach var,$(sort $(.VARIABLES)),\
	$(if $(subst file,,$(origin $(var))),\
		,\
		$(info $(var) = $($(var))      flavor = $(flavor $(var)))\
	)\
)
$(info )

$(info Variables from the command line - origin = command line’)
$(foreach var,$(sort $(.VARIABLES)),\
	$(if $(subst command line,,$(origin $(var))),\
		,\
		$(info $(var) = $($(var))      flavor = $(flavor $(var)))\
	)\
)
$(info )

# See: https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html#index-automatic-variables

$(info Automatic variables - origin = automatic)
$(foreach var,$(sort $(.VARIABLES)),\
	$(if $(subst automatic,,$(origin $(var))),\
		,\
		$(info $(var) = $($(var))      flavor = $(flavor $(var)))\
	)\
)
$(info )

# See: https://www.gnu.org/software/make/manual/html_node/Environment.html#index-environment

$(info Variables inherited from the environment - origin = environment)
$(foreach var,$(sort $(.VARIABLES)),\
	$(if $(subst environment,,$(origin $(var))),\
		,\
		$(info $(var) = $($(var))      flavor = $(flavor $(var)))\
	)\
)
$(info )

$(info Other variables)
$(foreach var,$(sort $(.VARIABLES)),\
	$(if $(or $(subst default,,$(origin $(var))),$(subst file,,$(origin $(var))),$(subst command line,,$(origin $(var))),$(subst environment,,$(origin $(var)))),\
		,\
		$(info $(var) = $($(var))      flavor = $(flavor $(var)))\
	)\
)
$(info )
$(info END)
