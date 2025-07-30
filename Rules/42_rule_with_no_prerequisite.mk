# Rule with no prerequisite

# If a rule has no prerequisite and the target does not exist, the recipe is executed.
# If a rule has no prerequisite and the target exist, the recipe is not executed.

# Usage: make -f 42_rule_with_no_prerequisite.mk # rule target42 runs
#        make -f 42_rule_with_no_prerequisite.mk # rule target42 does not run
# Cleanup:make -f 42_rule_with_no_prerequisite.mk clean

target42:
	@echo "--- run rule $@ ---"
	touch $@

clean:
	@echo "--- run rule $@ ---"
	$(RM) target42
