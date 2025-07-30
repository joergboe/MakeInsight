# Look into the kinds of variable/macro definitions, their flavors and origin
# in recursive make executions.

# Usage: 
# unset MAGIC
# ENVIRONMENT_VAR=environment_var\$\(MAGIC\) make -r -f variable_flavors_2.mk ARGUMENT_VAR=argument_var\$\(MAGIC\)

$(info MAKEFLAGS=$(MAKEFLAGS))

$(info *** Define some variables.)
MAGIC = -------------
VAR = var
$(info *** Define and export some variables.)
export RECURSIVE_VAR = recursive_var$(MAGIC)
export SIMPLE_VAR := simple_var$(MAGIC)

$(info *** The value function provides a way to use the value of a variable without having it expanded.)
$(info *** This does not undo expansions which have already occurred (simple variables).)
$(info VAR:              origin=$(origin VAR) flavor=$(flavor VAR) value=$(VAR) unexpanded=$(value VAR))
$(info RECURSIVE_VAR:    origin=$(origin RECURSIVE_VAR) flavor=$(flavor RECURSIVE_VAR) value=$(RECURSIVE_VAR) unexpanded=$(value RECURSIVE_VAR))
$(info SIMPLE_VAR:       origin=$(origin SIMPLE_VAR) flavor=$(flavor SIMPLE_VAR) value=$(SIMPLE_VAR) unexpanded=$(value SIMPLE_VAR))
$(info ENVIRONMENT_VAR:  origin=$(origin ENVIRONMENT_VAR) flavor=$(flavor ENVIRONMENT_VAR) value=$(ENVIRONMENT_VAR) unexpanded=$(value ENVIRONMENT_VAR))
$(info ARGUMENT_VAR:     origin=$(origin ARGUMENT_VAR) flavor=$(flavor ARGUMENT_VAR) value=$(ARGUMENT_VAR) unexpanded=$(value ARGUMENT_VAR))
$(info )

all:
	@$(MAKE) -f variable_flavors_2_rk.mk

$(info *** Change the values.)
RECURSIVE_VAR += addendum
SIMPLE_VAR += addendum
ENVIRONMENT_VAR += addendum
override ARGUMENT_VAR += addendum
#override ARGUMENT_VAR2 = prefix $(ARGUMENT_VAR2)
$(info *** Export ARGUMENT_VAR)
export ARGUMENT_VAR

$(info RECURSIVE_VAR:    origin=$(origin RECURSIVE_VAR) flavor=$(flavor RECURSIVE_VAR) value=$(RECURSIVE_VAR) unexpanded=$(value RECURSIVE_VAR))
$(info SIMPLE_VAR:       origin=$(origin SIMPLE_VAR) flavor=$(flavor SIMPLE_VAR) value=$(SIMPLE_VAR) unexpanded=$(value SIMPLE_VAR))
$(info ENVIRONMENT_VAR:  origin=$(origin ENVIRONMENT_VAR) flavor=$(flavor ENVIRONMENT_VAR) value=$(ENVIRONMENT_VAR) unexpanded=$(value ENVIRONMENT_VAR))
$(info ARGUMENT_VAR :    origin=$(origin ARGUMENT_VAR) flavor=$(flavor ARGUMENT_VAR) value=$(ARGUMENT_VAR) unexpanded=$(value ARGUMENT_VAR))
$(info *** Note: exported are - RECURSIVE_VAR SIMPLE_VAR ARGUMENT_VAR)
$(info )
