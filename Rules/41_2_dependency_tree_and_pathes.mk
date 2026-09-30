# Dependencies and file pathes

# For the creation of the dependency tree make uses the targets and prerequisites almost literally.
# Specifically, it does not canonize the path.
# Exception: Only leading dot components such as ./ ././ .// are removed.

# Usage: > make -f 41_2_dependency_tree_and_pathes.mk
# Expection: target, foo, foo2, bar, bar2, baz and baz2 are created.

# Usage: > make -f 41_2_dependency_tree_and_pathes.mk
# Expection: 'target' is up to date.

# Cleanup: > make -f 41_2_dependency_tree_and_pathes.mk clean

./target : foo ./foo2 bar ././bar2 baz .//baz2
	@echo "rule $@"
	@echo '$$@ = $@'
	@echo '$$+ = $+'
	@echo '$$^ = $^'
	@echo '$$? = $?'
	@echo '$$< = $<'
	touch $@

./foo foo2 ././bar bar2 .//baz baz2 :
	@echo "rule $@"
	touch $@
# NOTE: ./foo and foo are considered the same object
# NOTE: ./foo yields foo
# NOTE: ././bar and bar are considered the same object
# NOTE: ././bar yields bar
# NOTE: .//baz and baz are considered the same object
# NOTE: .//baz yields baz

.PHONY : clean
clean :
	rm -f foo foo2 bar bar2 baz baz2 target
