# Double-Colon Rules without Recipes or Prerequisites

# see: https://www.gnu.org/software/make/manual/make.html#Double_002dColon
# Each double-colon rule’s recipe is executed if the target is older than any prerequisites of that rule.
# If there are no prerequisites for that rule, its recipe is always executed (even if the target already exists).
# This implies that all targets depending on this one will always have their recipe run.
# This is similar to PHONY targets.

# NOTE: An Order Only Prerequisites is counted as prerequisite!

# NOTE: Pattern rules with double-colons have an entirely different meaning.
# see Match-Anything Pattern Rules https://www.gnu.org/software/make/manual/make.html#Match_002dAnything-Rules

# Usage: make -f 51_double_colon_rules_no_prerequisite.mk # receipt foo runs
#        make -f 51_double_colon_rules_no_prerequisite.mk # receipt foo runs, even if foo exists

#        make -f 51_double_colon_rules_no_prerequisite.mk bar # receipt bar runs
#        make -f 51_double_colon_rules_no_prerequisite.mk bar # receipt bar does not run

#        make -f 51_double_colon_rules_no_prerequisite.mk foobar # receipt foobar runs
#        make -f 51_double_colon_rules_no_prerequisite.mk foobar # receipt foobar does not run

# Cleanup: make -f 51_double_colon_rules_no_prerequisite.mk clean

# foo may exist!
foo ::
	@echo '--- run receipt $@ :: ---'
	touch $@

bar :
	@echo '--- run receipt $@ : ---'
	touch $@

foobar :: | f1
	@echo '--- run receipt $@ :: ---'
	touch $@

f1:
	@echo '--- run receipt $@ :: ---'
	touch $@

.PHONY: clean
clean:
	rm -fv foo bar foobar f1