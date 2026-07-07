# Target-specific Variable Values in Double-Colon Rules

# usage: make -f 45_2_target_specific_variables.mk

target:: target_var1 = Colon or Double-Colon makes no difference.
target: target_var2 = This is also seen in target.

target::
	@echo "*** Rule - $@ ***"
	@echo "target_var1 = $(target_var1)"
	@echo "target_var2 = $(target_var2)"
	@echo
