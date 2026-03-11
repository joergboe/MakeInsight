# Pattern Rules - Implicit Rules

# You define an implicit rule by writing a pattern rule. A pattern rule looks like an ordinary rule, except that its
# target contains the character ‘%’ (exactly one of them). The target is considered a pattern for matching file names;
# the ‘%’ can match any nonempty substring, while other characters match only themselves. The prerequisites likewise
# use ‘%’ to show how their names relate to the target name.

# Thus, a pattern rule ‘%.o : %.c’ says how to make any file stem.o from another file stem.c.

# NOTE: that expansion using ‘%’ in pattern rules occurs after any variable or function expansions, which take place
# when the makefile is read.

# See: https://www.gnu.org/software/make/manual/html_node/Pattern-Rules.html

# Usage:   make -f 57_1_pattern_rules.mk
# Expect:  Successfully build of target
# Cleanup: make -f 57_1_pattern_rules.mk clean

# NOTE: The stem of the pattern must not be empty!
# Usage:   make -f 57_1_pattern_rules.mk ZERO_STEM=1
# Expect:  Fails to build target
# Cleanup: make -f 57_1_pattern_rules.mk ZERO_STEM=1 clean

sources ::= f1.src f2.src
objects ::= f1.o f2.o

ifdef ZERO_STEM
  sources += .src
  objects += .o
endif
$(info sources = '$(sources)')
$(info objects = '$(objects)')
$(info )

# build the final target
target: $(objects)
	@echo "--- run final rule $@ : $^ ---"
	touch $@
	@echo

# Create the 'object' files

%.o : %.src conf
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
	echo "Configuration" > $@
	@echo

# cleanup all artifacts
clean:
	@echo "--- run rule $@ ---"
	rm -rfv target $(sources) $(objects) conf
	@echo
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