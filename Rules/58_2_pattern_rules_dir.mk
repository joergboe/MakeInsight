# Static Pattern Rules - Files are not in CURDIR

# With a pattern %.o or %.src The directory part of the target is part of the stem.

# Usage:   make -f 58_2_pattern_rules_dir.mk
# Expected: Directory build is created and target is built.
# NOTE: Stem is build/f1 and build/f2
# Cleanup: make -f 58_2_pattern_rules_dir.mk clean

# Usage:   make -f 58_2_pattern_rules_dir.mk NO_DIR=1
# Expected: All files are in CURDIR
# NOTE: The directory part ./ is removed from stem.
# Cleanup: make -f 58_2_pattern_rules_dir.mk clean NO_DIR=1

ifdef NO_DIR
  builddir ::= .
else
  builddir ::= build
  $(shell mkdir $(builddir))
endif

sources = $(addprefix $(builddir)/,f1.src f2.src)
objects = $(addprefix $(builddir)/,f1.o f2.o)


# build the final target
$(builddir)/target: $(objects)
	@echo "--- run final rule $@ : $^ ---"
	touch $@
	@echo

# Create the 'object files in build directory'
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
	touch $@
	@echo

# cleanup all artifacts
clean:
	@echo "--- run rule $@ ---"
	rm -rfv $(builddir)/target $(sources) $(objects) conf
ifndef NO_DIR
	-rmdir $(builddir)
endif
	@echo
.PHONY: clean

58_2_pattern_rules_dir.mk:;
