# Dependencies and file pathes

# Usage: > make -f 41_1_dependency_tree_and_pathes.mk
# Expect: Run rules foo src/../foo src/bar src/./bar src//bar src/baz $(prereq3) /$(prereq3) and target and src
# Cleanup: > make -f 41_1_dependency_tree_and_pathes.mk clean

# Usage: > make -f 41_1_dependency_tree_and_pathes.mk TOUCH=1
# Expect: Run rules foo src/bar src/baz and target and src. Duplicate file objects are skipped. These files are current
#         after the first touch of the common file object.
# Cleanup: > make -f 41_1_dependency_tree_and_pathes.mk clean

# Usage: > make -f 41_1_dependency_tree_and_pathes.mk TOUCH=1 -j --output-sync
# Expect: Run rules foo src/../foo src/bar src/./bar src//bar src/baz $(prereq3) /$(prereq3) and target and src
# Cleanup: > make -f 41_1_dependency_tree_and_pathes.mk clean

# Usage: > make -f 41_1_dependency_tree_and_pathes.mk target2
# Expected: Inconsistent usage results in failures.

# For the creation of the dependency tree make uses the targets and prerequisites almost literally.
# Specifically, it does not canonize the path.
# Exception: Only leading ./ Dot components are removed.

prereq3 = $(abspath src/baz)
$(info prereq3 = $(prereq3))
$(info )

./target: foo ./foo src/../foo src/bar src/./bar ./src//bar src/baz $(prereq3) /$(prereq3)
	@echo "rule $@"
	@echo '$$@ = $@'
	@echo '$$+ = $+'
	@echo '$$^ = $^'
	@echo '$$? = $?'
	@echo '$$< = $<'
	touch $@
# NOTE: ./foo and foo are considered the same object
# NOTE: ./foo yields foo
# NOTE: foo ./src/../foo are considered different objects and separate rules are created.
# NOTE: src/bar, src/./bar and src//bar are considered different objects
# NOTE: src/baz, $(abspath src/baz) and /$(abspath src/baz) are considered different objects

foo ./foo ./src/../foo src/bar src/./bar src//bar ./src/baz $(prereq3) /$(prereq3) : | src
	@echo "rule $@"
ifdef TOUCH
	touch $@
endif
	@echo
# NOTE: finally the same file object are touched foo, src/bar and src/baz

src:
	mkdir src
	@echo

target2 : src/./foobar
	@echo "rule $@"

src/foobar:
	@echo "rule $@"

.PHONY: clean
clean:
	rm -rf src
	rm -f target target2 foo
