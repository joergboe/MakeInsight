# Dependencies and links

# Usage: > make -f 41_2_dependency_tree_and_links.mk
# Expect: File operations are with link targets
# Cleanup: > make -f 41_2_dependency_tree_and_links.mk clean

$(shell ln -s target2 target_ln; ln -s src/file1 link1; ln -s src/file2 link2;)

./target_ln: link1 link2
	@echo "rule ./target_ln"
	@echo '$$@ = $@'
	@echo '$$^ = $^'
	@echo '$$+ = $+'
	@echo '$$? = $?'
	@echo '$$< = $<'
	touch $@
	@ls -l $@
	@echo

link1 link2: | src
	@echo "rule $@"
	touch $@
	@ls -l $@
	@echo

src:
	mkdir src
	@echo

.PHONY: clean
clean:
	rm -rf src
	rm -f target2
	rm -f target_ln
	rm -f link1 link2
