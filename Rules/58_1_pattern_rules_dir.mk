# Pattern Rules - Files are not in CURDIR

# Usage:   make -f 58_1_pattern_rules_dir.mk
# Expected: directories src and build are created and target is built.
# Cleanup: make -f 58_1_pattern_rules_dir.mk clean

# Usage:   make -f 58_1_pattern_rules_dir.mk NO_DIR=1
# Expected: All files are in CURDIR
# One warning issued: 58_1_pattern_rules_dir.mk:50: target '.' given more than once in the same rule
# Cleanup: make -f 58_1_pattern_rules_dir.mk clean NO_DIR=1

ifdef NO_DIR
  builddir ::= .
  srcdir ::= .
else
  builddir ::= build
  srcdir ::= src
endif

sources = $(srcdir)/f1.src $(srcdir)/f2.src
objects = $(builddir)/f1.o $(builddir)/f2.o


# build the final target
$(builddir)/target: $(objects) | $(builddir)
	@echo "--- run final rule $@ : $^ ---"
	touch $@
	@echo

# Create the 'object files in build directory'
$(builddir)/%.o : $(srcdir)/%.src conf | $(builddir)
	@echo "--- run 'object' rule $@ : $^ ---"
	@echo "pattern stem \$$* : $*"
	touch $@
	@echo

# Create the 'source' files
$(srcdir)/%.src : | $(srcdir)
	@echo "-- run 'source' rule $@ ---"
	@echo "pattern stem \$$* : $*"
	touch $@
	@echo

conf:
	@echo "--- run rule $@ ---"
	touch $@
	@echo

# Create directory
$(builddir) $(srcdir):
	@echo "--- run 'directory' rule $@ ---"
	mkdir $@
	@echo

# cleanup all artifacts
clean:
	@echo "--- run rule $@ ---"
	rm -rfv $(builddir)/target $(sources) $(objects) conf
ifndef NO_DIR
	-rmdir $(builddir) $(srcdir)
endif
	@echo
.PHONY: clean

58_1_pattern_rules_dir.mk:;
