# Basics for automatic variables

# usage: make -f automatic_variables.mk

v1 := Target :
simple_variable := $(v1) $@
recursive_variable  = $(v1) $@

$(info $(simple_variable))
$(info $(recursive_variable) -- Automatic variables are empty in this context.)

.PHONY: all
all:
	@echo executing rule $@
	@echo '$(simple_variable) -- simple expansion does not work'
	@echo '$(recursive_variable) -- The target name is propperly expanded with recursive variable flavor'
 