# Static Pattern Rules - Files are not in CURDIR

# With a pattern f%.o or f%.src The directory part of the target is also part of the stem!!!

# See: https://www.gnu.org/software/make/manual/html_node/Pattern-Match.html

# When the target pattern does not contain a slash (and it usually does not), directory names in the file names are
# removed from the file name before it is compared with the target prefix and suffix. After the comparison of the file
# name to the target pattern, the directory names, along with the slash that ends them, are added on to the prerequisite
# file names generated from the pattern rule’s prerequisite patterns and the file name. The directories are ignored only
# for the purpose of finding an implicit rule to use, not in the application of that rule. Thus, ‘e%t’ matches the file
# name src/eat, with ‘src/a’ as the stem. When prerequisites are turned into file names, the directories from the stem
# are added at the front, while the rest of the stem is substituted for the ‘%’.

# Usage:   make -f 58_3_pattern_rules_dir.mk
# Expected: Directory build is created and target is built.
# NOTE: Stem is build/1 and build/2
# Cleanup: make -f 58_3_pattern_rules_dir.mk clean

builddir ::= build
$(shell mkdir $(builddir))

sources = $(addprefix $(builddir)/,f1.src f2.src)
objects = $(addprefix $(builddir)/,f1.o f2.o)


# build the final target
$(builddir)/target: $(objects)
	@echo "--- run final rule $@ : $^ ---"
	touch $@
	@echo

# Create the 'object files in build directory'
f%.o : f%.src conf
	@echo "--- run 'object' rule $@ : $^ ---"
	@echo "pattern stem \$$* : $*"
	touch $@
	@echo

# Create the 'source' files
f%.src :
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
	rm -rfv $(builddir)/target $(sources) $(objects) conf
	-rmdir $(builddir)
	@echo
.PHONY: clean

58_3_pattern_rules_dir.mk:;
