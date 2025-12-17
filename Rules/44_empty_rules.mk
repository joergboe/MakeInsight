# Rules without Recipes or Prerequisites

# If a rule has no prerequisites or recipe, and the target of the rule is a nonexistent file, then make imagines this
# target to have been updated whenever its rule is run. 
# This implies that all targets depending on this one will always have their recipe run.

# Usage: make -f 44_empty_rules.mk     -> receipt target_44 runs
#        make -f 44_empty_rules.mk     -> receipt target_44 runs again
#        touch FORCE_44
#        make -f 44_empty_rules.mk     -> receipt target_44 runs because FORCE_44 is newer than target_44
#        make -f 44_empty_rules.mk     -> no recipt runs: 'target_44' is up to date.
# Cleanup: make -f 44_empty_rules.mk clean

# target_44 may exist!
target_44 : FORCE_44
	@echo '--- run receipt $@ ---'
	touch $@


# Single colon: FORCE_44 must not exist, otherwise the rule does not run
FORCE_44 :;
# The column can be omitted.

# There is nothing special about the name FORCE_44 - nearly the same as .PHONY: clean
.PHONY: clean
clean:
	$(RM) target_44 FORCE_44
