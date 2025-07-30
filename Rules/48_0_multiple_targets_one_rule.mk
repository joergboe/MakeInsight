# Multiple Targets in a Rule

# see: https://www.gnu.org/software/make/manual/make.html#Multiple-Rules
# When an explicit rule has multiple targets they can be treated in one of two possible ways: as
# independent targets or as grouped targets. The manner in which they are treated is determined by the
# separator that appears after the list of targets.

# Rules with Independent Targets:
# Rules that use the standard target separator, :, define independent targets. This is equivalent to
# writing the same rule once for each target, with duplicated prerequisites and recipes. Typically,
# the recipe would use automatic variables such as ‘$@’ to specify which target is being built.

# Usage  : make -f 48_0_multiple_targets_one_rule.mk # runs : all res1 res2 res3 f1
# Cleanup: make -f 48_0_multiple_targets_one_rule.mk clean

all: res1 res2 res3
	@echo -e "\n---- run $@ ----"
	cat res1
	cat res2
	cat res3

res1 res2 res3: f1
	@echo -e "\n---- run $@ ----"
	echo "f1 used for generating: $@" > $@
	cat $< > $@

f1:
	@echo -e "\n---- run $@ ----"
	echo "Text1" > $@

clean:
	rm -fv res{1..3} f1

.PHONY: all clean
