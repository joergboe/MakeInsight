# Double-Colon Rules without Recipes or Prerequisites

# see: https://www.gnu.org/software/make/manual/make.html#Double_002dColon
# Each double-colon rule’s recipe is executed if the target is older than any prerequisites of that rule.
# If there are no prerequisites for that rule, its recipe is always executed (even if the target already exists).
# This can result in executing none, any, or all of the double-colon rules.
# This implies that all targets depending on this one will always have their recipe run.

# Usage: make -f 51_double_colon_rules_no_prerequisite.mk # receipt target_51 runs
#        make -f 51_double_colon_rules_no_prerequisite.mk # receipt target_51 runs every time
# Cleanup: make -f 51_double_colon_rules_no_prerequisite.mk clean

# target_51 may exist!
target_51 ::
	@echo '--- run receipt $@ ---'
	touch $@

.PHONY: clean
clean:
	rm -fv target_51
