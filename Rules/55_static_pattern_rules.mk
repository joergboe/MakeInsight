# Static Pattern Rules

# see: https://www.gnu.org/software/make/manual/make.html#Static-Pattern

# Static pattern rules are rules which specify multiple targets and construct the prerequisite names
# for each target based on the target name. They are more general than ordinary rules with multiple
# targets because the targets do not have to have identical prerequisites. Their prerequisites must
# be analogous, but not necessarily identical.
#
# Syntax of a static pattern rule:
# targets …: target-pattern: prereq-patterns …
#	recipe
#	…

# The targets list specifies the targets that the rule applies to. The targets can contain wildcard
# characters.
# The target-pattern and prereq-patterns say how to compute the prerequisites of each target.
# Each target is matched against the target-pattern to extract a part of the target name, called the
# stem. This stem is substituted into each of the prereq-patterns to make the prerequisite names
# (one from each prereq-pattern).
#
# Each pattern normally contains the character ‘%’ just once. When the target-pattern matches a target,
# the ‘%’ can match any part of the target name; this part is called the stem. The rest of the pattern
# must match exactly.
# For example, the target foo.o matches the pattern ‘%.o’, with ‘foo’ as the stem. The targets
# foo.c and foo.out do not match that pattern.
#
# The prerequisite names for each target are made by substituting the stem for the ‘%’ in each
# prerequisite pattern. For example, if one prerequisite pattern is %.c, then substitution of the stem
# ‘foo’ gives the prerequisite name foo.c. It is legitimate to write a prerequisite pattern that does
# not contain ‘%’; then this prerequisite is the same for all targets.

# The list with the targets is often hold in a variable.

# Usage:   make -f 55_static_pattern_rules.mk
# Cleanup: make -f 55_static_pattern_rules.mk clean

# Try with parallel build
# Usage:   make -f 55_static_pattern_rules.mk -j 4
# runs step1: f1.src f2.src f3.src conf
#      step2: f1.o f2.o f3.o
#      step3: target

sources = f1.src f2.src f3.src
objects = f1.o f2.o f3.o

# build the final target
target: $(objects)
	@echo -e "\n--- run rule $@ : $^ ---"
	cat $^ > $@

# Create the 'object files in build directory'
$(objects) : %.o : %.src conf
	@echo -e "\n--- run rule $@ : $^ ---"
	@echo "pattern stem \$$* : $*"
	cat $^ > $@

# Create the 'source' files
$(sources) : %.src :
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
