# Pattern Rules - Implicit Rules

# Usage:   make -f 57_1_pattern_rules.mk
# Expect:  Successfully build of target
# Cleanup: make -f 57_1_pattern_rules.mk clean

# NOTE: The stem of the pattern must not be empty!
# Usage:   make -f 57_1_pattern_rules.mk ZERO_STEM=1
# Expect:  Fails to build target
# Cleanup: make -f 57_1_pattern_rules.mk ZERO_STEM=1 clean

sources ::= f1.src f2.src f3.src .src
objects ::= f1.o f2.o f3.o

ifdef ZERO_STEM
sources += .src
objects += .o
endif


# build the final target
target: $(objects)
	@echo -e "\n--- run rule $@ : $^ ---"
	cat $^ > $@

# Create the 'object' files

%.o : %.src conf
	@echo -e "\n--- run rule $@ : $^ ---"
	@echo "pattern stem \$$* : $*"
	cat $^ > $@

# Create the 'source' files
%.src :
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

57_1_pattern_rules.mk:;
# NOTE: This target is added to prevent make to search for a rule to update the makefile 57_1_pattern_rules.mk
# NOTE: This rule must have at least an empty recipe!
# If this rule is not here make tries:
# Trying pattern rule '%: %.o' with stem '57_1_pattern_rules.mk'.
# Trying pattern rule '%.o: %.src conf' with stem '57_1_pattern_rules.mk'.
# Trying pattern rule '%.src:' with stem '57_1_pattern_rules.mk'.
# Found implicit rule '%.src:' for '57_1_pattern_rules.mk.src'.
# And executes the following steps:
# --- run rule conf ---
# --- run rule 57_1_pattern_rules.mk.src ---
# --- run rule 57_1_pattern_rules.mk.o : 57_1_pattern_rules.mk.src conf ---
# <builtin>: update target '57_1_pattern_rules.mk' due to: 57_1_pattern_rules.mk.o
# cc   57_1_pattern_rules.mk.o   -o 57_1_pattern_rules.mk
# The last fails but 57_1_pattern_rules.mk is overwritten!