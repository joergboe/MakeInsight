# Pattern Rules - Implicit Rules

# Last resort rules like %: are not considered in chains of implicit rules.

# A non-terminal match-anything rule cannot apply to a prerequisite of an implicit rule, or to a file name that
# indicates a specific type of data.

# See: https://www.gnu.org/software/make/manual/html_node/Match_002dAnything-Rules.html

# Usage:   make -f 57_2_pattern_rules_last_resort.mk
# Expect:  Successfully build of target
# Cleanup: make -f 57_2_pattern_rules_last_resort.mk clean

# Usage:   make -f 57_2_pattern_rules_last_resort.mk LAST_RESSORT=1
# Expect:  Fails to build target: make: *** No rule to make target 'f1.o', needed by 'target'.  Stop.

sources ::= f1.src f2.src
objects ::= f1.o f2.o

ifdef LAST_RESSORT
  source_file_pattern ::= %
else
  source_file_pattern ::= %.src
endif

$(info sources = '$(sources)')
$(info objects = '$(objects)')
$(info source_file_pattern = '$(source_file_pattern)')
$(info )

# build the final target
target: $(objects)
	@echo "--- run final rule $@ : $^ ---"
	touch $@
	@echo

# NOTE: The pattern search for rules is done after variable expansion.
# Create the 'object' files
%.o : $(source_file_pattern) conf
	@echo "--- run 'object' rule $@ : $^ ---"
	@echo "pattern stem \$$* : $*"
	touch $@
	@echo

# Create the 'source' files
$(source_file_pattern) :
	@echo "--- run 'source' rule $@ ---"
	@echo "pattern stem \$$* : $*"
	touch $@
	@echo

conf:
	@echo "--- run rule $@ ---"
	touch $@
	@echo

# cleanup all artifacts
clean:
	@echo "--- run rule $@ ---"
	rm -rfv target $(sources) $(objects) conf
	@echo
.PHONY: clean

57_2_pattern_rules_last_resort.mk:;
# NOTE: This target is added to prevent make to search for a rule to update the makefile 57_2_pattern_rules_last_resort.mk
# NOTE: This rule must have at least an empty recipe!
