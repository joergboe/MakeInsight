# Static Pattern Rules - Files are not in CURDIR

# With a pattern f%.o or f%.src The directory part of the target is also part of the stem!!!

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
	@echo -e "\n--- run rule $@ : $^ ---"
	touch $@

# Create the 'object files in build directory'
f%.o : f%.src conf
	@echo -e "\n--- run rule $@ : $^ ---"
	@echo "pattern stem \$$* : $*"
	touch $@

# Create the 'source' files
f%.src :
	@echo -e "\n--- run rule $@ ---"
	@echo "pattern stem \$$* : $*"
	touch $@

conf:
	@echo -e "\n--- run rule $@ ---"
	touch $@

# cleanup all artifacts
clean:
	@echo "--- run rule $@ ---"
	rm -rfv $(builddir)/target $(sources) $(objects) conf
	-rmdir $(builddir)
.PHONY: clean

58_3_pattern_rules_dir.mk:;
