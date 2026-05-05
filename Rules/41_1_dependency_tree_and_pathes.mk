# Dependencies and file pathes

# Usage: > make -f 41_1_dependency_tree_and_pathes.mk
# Expect: Run rules f1 src/../f1 src/f2 src/./f2 src//f2 src/f3 $(prereq3) /$(prereq3) and target and src
# Cleanup: > make -f 41_1_dependency_tree_and_pathes.mk clean

# Usage: > make -f 41_1_dependency_tree_and_pathes.mk TOUCH=1
# Expect: Run rules f1 src/f2 src/f3 and target and src. Duplicate file objects are skipped.
# Cleanup: > make -f 41_1_dependency_tree_and_pathes.mk clean

# Usage: > make -f 41_1_dependency_tree_and_pathes.mk TOUCH=1 -j
# Expect: Run rules f1 src/../f1 src/f2 src/./f2 src//f2 src/f3 $(prereq3) /$(prereq3) and target and src
# Cleanup: > make -f 41_1_dependency_tree_and_pathes.mk clean

# Usage: > make -f 41_1_dependency_tree_and_pathes.mk target_ln
# Expect: File operations are with link targets
# Cleanup: > make -f 41_1_dependency_tree_and_pathes.mk clean

# For the creation of the dependency tree make uses the targets and prerequisites almost literally.
# Specifically, it does not canonize the path.
# Exception: Only leading ./ Dot components are removed.

$(shell ln -s target2 target_ln; ln -s src/file1 link1; ln -s src/file2 link2;)

prereq3 = $(abspath src/f3)
$(info prereq3 = $(prereq3))
$(info )

./target: f1 ./f1 src/../f1 src/f2 src/./f2 ./src//f2 src/f3 $(prereq3) /$(prereq3)
	@echo "rule $@"
	@echo '$$@ = $@'
	@echo '$$+ = $+'
	@echo '$$^ = $^'
	@echo '$$? = $?'
	@echo '$$< = $<'
	touch $@
# NOTE: ./f1 and f1 are considered the same object
# NOTE: ./f1 yields f1
# NOTE: f1 ./src/../f1 are considered different objects
# NOTE: src/f2, src/./f2 and src//f2 are considered different objects
# NOTE: src/f3, $(abspath src/f3) and /$(abspath src/f3) are considered different objects

f1 ./src/../f1 src/f2 src/./f2 src//f2 ./src/f3 $(prereq3) /$(prereq3) : src
	@echo "rule $@"
ifdef TOUCH
	touch $@
endif
# NOTE: finally the same file object are touched f1, src/f2 and src/f3

src:
	mkdir src

./target_ln: link1 link2
	@echo "rule ./target_ln"
	@echo '$$@ = $@'
	@echo '$$^ = $^'
	@echo '$$+ = $+'
	@echo '$$? = $?'
	@echo '$$< = $<'
	touch $@

link1 link2: | src
	@echo "rule $@"
	touch $@
	@ls -l $@

.PHONY: clean
clean:
	rm -rf src
	rm -f target target2
	rm -f target_ln
	rm -f link1 link2
