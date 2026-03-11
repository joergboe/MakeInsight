# Pattern Rules - Implicit Rules - Terminal

# When a rule is terminal, it does not apply unless its prerequisites actually exist. Prerequisites that could be made
# with other implicit rules are not good enough. In other words, no further chaining is allowed beyond a terminal rule.

# See: https://www.gnu.org/software/make/manual/html_node/Match_002dAnything-Rules.html


# If the pattern rule %.o : % conf ... is used, the target is successfully built.
# Usage:   make -f 57_3_pattern_rules_terminal.mk
# Expect:  Target is build successfully.
# Cleanup  make -f 57_3_pattern_rules_terminal.mk clean

# The object rule is now a terminal rule %.o :: % conf
# Usage:   make -f 57_3_pattern_rules_terminal.mk TERMINAL_RULE=1
# Expect:  make: *** No rule to make target 'f1.src.o', needed by 'target'.  Stop.

# If the prerequisites f1.src f2.src exists, the target is built.
# Usage:   make -f 57_3_pattern_rules_terminal.mk TERMINAL_RULE=1 TOUCH_SRC=1
# Expect:  Target is build successfully.
# Cleanup  make -f 57_3_pattern_rules_terminal.mk clean

sources ::= f1.src f2.src
objects ::= f1.src.o f2.src.o

ifdef TOUCH_SRC
  $(shell touch $(sources))
  $(info touch $(sources))
endif

# build the final target
target: $(objects)
	@echo "--- run final rule $@ : $^ ---"
	touch $@
	@echo

# Create the 'object' files
ifdef TERMINAL_RULE
$(info Use a terminal rule %.o :: % conf)
%.o :: % conf
else
%.o : % conf
endif
	@echo "--- run 'object' rule $@ : $^ ---"
	@echo "pattern stem \$$* : $*"
	touch $@
	@echo

# Create the 'source' files
%.src :
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

57_3_pattern_rules_terminal.mk:;
# NOTE: This target is added to prevent make to search for a rule to update the makefile 57_3_pattern_rules_terminal.mk
# NOTE: This rule must have at least an empty recipe!
