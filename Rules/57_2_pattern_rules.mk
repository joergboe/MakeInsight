# Pattern Rules - Implicit Rules

# Usage:   make -f 57_2_pattern_rules.mk
# Expect:  Successfully build of target
# Cleanup: make -f 57_2_pattern_rules.mk clean

# NOTE: Last ressort rules like %: are not considered in chains of implicit rules.
# Usage:   make -f 57_2_pattern_rules.mk LAST_RESSORT=1
# Expect:  Fails to build target: make: *** No rule to make target 'f1.o', needed by 'target'.  Stop.
# Cleanup: make -f 57_2_pattern_rules.mk clean

sources ::= f1.src f2.src f3.src .src
objects ::= f1.o f2.o f3.o


# build the final target
target: $(objects)
	@echo -e "\n--- run rule $@ : $^ ---"
	cat $^ > $@

ifdef LAST_RESSORT
  source_file_pattern ::= %
else
  source_file_pattern ::= %.src
endif
# NOTE: The pattern search for rules is done after variable expansion.

# Create the 'object' files
%.o : $(source_file_pattern) conf
	@echo -e "\n--- run rule $@ : $^ ---"
	@echo "pattern stem \$$* : $*"
	cat $^ > $@

# Create the 'source' files
$(source_file_pattern) :
	@echo -e "\n--- run rule $@ ---"
	@echo "pattern stem \$$* : $*"
	echo "Text $@" > $@

conf:
	@echo -e "\n--- run rule $@ ---"
	echo "Configuration" > $@

# cleanup all artifacts
clean:
	@echo "--- run rule $@ ---"
	rm -rfv target $(sources) $(objects) conf
.PHONY: clean

57_2_pattern_rules.mk:;
# NOTE: This target is added to prevent make to search for a rule to update the makefile 57_2_pattern_rules.mk
# NOTE: This rule must have at least an empty recipe!
