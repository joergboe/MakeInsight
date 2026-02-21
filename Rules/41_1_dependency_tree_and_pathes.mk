# Dependencies and file pathes

# Usage:
# > make -f 41_1_dependency_tree_and_pathes.mk
# Cleanup:
# > make -f 41_1_dependency_tree_and_pathes.mk clean

# For the creation of the dependency tree make uses the targets and prerequisites almost literally.
# It does Specifically, it does not canonize the path.
# Exception: Only leading ./ Dot components are removed.

$(shell ln -s target2 target_ln; ln -s src/fl1 ln1; ln -s src/fl2 ln2;)

prereq3 = $(abspath src/f3)
$(info prereq3 = $(prereq3))

./target: f1 ./f1 src/../f1 src/f2 ./src/.//f2 src/f3 $(prereq3) | src
	@echo '$$@ = $@'
	@echo '$$+ = $+'
	@echo '$$^ = $^'
	@echo '$$? = $?'
	@echo '$$< = $<'
	touch $@
# NOTE: ./f1 and f1 are considered the same object
# NOTE: ./f1 yields f1
# NOTE: f1 ./src/../f1 and src/f3 and $(abspath src/f3) are considered different objects

src:
	mkdir src

f1 ./src/../f1 src/f2 src/.//f2 ./src/f3 $(prereq3) :
	@echo "rule $@"

./target_ln: ln1 ln2 | src
	@echo '$$@ = $@'
	@echo '$$^ = $^'
	@echo '$$+ = $+'
	@echo '$$? = $?'
	@echo '$$< = $<'
	touch $@

ln1 ln2:
	@ls -l $@
	touch $@

.PHONY: clean
clean:
	rm -rf src
	rm -f target target2
	rm -f ln1 ln2 target_ln
