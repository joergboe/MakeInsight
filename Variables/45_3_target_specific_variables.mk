# Target-specific Variable Values in Grouped Target Rules

# usage: make -f 45_3_target_specific_variables.mk
#        make -f 45_3_target_specific_variables.mk target2
#        make -f 45_3_target_specific_variables.mk target2 target1

target1: target_var1 = Variable for target1
target2: target_var2 = Variable for target1
target1 target2&: common_var = For a common variable use the &: syntax!

target1 target2&:
	@echo "*** Rule - $@ ***"
	@echo "target_var1 = $(target_var1)"
	@echo "target_var2 = $(target_var2)"
	@echo "common_var = $(common_var)"
	@echo
