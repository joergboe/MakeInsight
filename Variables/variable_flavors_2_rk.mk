# Makefile called from variable_flavors_2.mk

$(info Executing variable_flavors_2_rk.mk)

MAGIC = +++++++++++++++

$(info MAKEFLAGS=$(MAKEFLAGS))

# new line required 2 lines!
define nl :=


endef

$(info *** Not exported variables are undefined.)
$(info VAR:              origin=$(origin VAR) flavor=$(flavor VAR) value=$(VAR))

$(info $(nl)*** Exported recursive variables are defined but are expanded during export.)
$(info RECURSIVE_VAR:    origin=$(origin RECURSIVE_VAR) flavor=$(flavor RECURSIVE_VAR) value=$(RECURSIVE_VAR) unexpanded=$(value RECURSIVE_VAR))

$(info $(nl)*** Exported simple variables are defined and are expanded anyway.)
$(info *** The flavor has changed to recursive!)
$(info SIMPLE_VAR:       origin=$(origin SIMPLE_VAR) flavor=$(flavor SIMPLE_VAR) value=$(SIMPLE_VAR) unexpanded=$(value SIMPLE_VAR))

$(info $(nl)*** Recursive environment variables are defined but are expanded during export.)
$(info *** Changes in the calling make file are passed through.)
$(info ENVIRONMENT_VAR:  origin=$(origin ENVIRONMENT_VAR) flavor=$(flavor ENVIRONMENT_VAR) value=$(ENVIRONMENT_VAR) unexpanded=$(value ENVIRONMENT_VAR))

$(info $(nl)*** Argument variables are passed via MAKEFLAGS and the origin is preserved even if overwritten and exported in calling make.)
$(info *** The expansion is done with the new value of MAGIC)
$(info ARGUMENT_VAR:    origin=$(origin ARGUMENT_VAR) flavor=$(flavor ARGUMENT_VAR) value=$(ARGUMENT_VAR) unexpanded=$(value ARGUMENT_VAR))
$(info )

all: