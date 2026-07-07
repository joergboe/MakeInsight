# Target-specific Variable Values in prerequisites list

# A target variables is not visible in prerequisites list even with secondary expansion enabled.

# usage: make -f 45_1_target_specific_variables.mk


.SECONDEXPANSION:

target: target_var = A target variables is not visible in prerequisites list.

target: object $(info Prerequisites list target: target_var = '$(target_var)')
	@echo "*** Rule - $@ ***"
	@echo "target_var = $(target_var)"
	@echo

object: $(info Prerequisites list object: target_var = '$(target_var)')
	@echo "*** Rule - $@ ***"
	@echo "target_var = $(target_var)"
	@echo
