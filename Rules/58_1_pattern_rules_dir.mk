# Static Pattern Rules - Files are not in CURDIR

# The list with the targets is often hold in a variable.

# Usage:   make -f 58_1_pattern_rules_dir.mk
# Expected: directories src and build are created and target is built.
# Cleanup: make -f 58_1_pattern_rules_dir.mk clean

# Usage:   make -f 58_1_pattern_rules_dir.mk NO_DIR=1
# Expected: All files are in CURDIR
# One warning issued: 58_1_pattern_rules_dir.mk:48: target '.' given more than once in the same rule
# Cleanup: make -f 58_1_pattern_rules_dir.mk clean NO_DIR=1

ifdef NO_DIR
builddir ::= .
srcdir ::= .
else
builddir ::= build
srcdir ::= src
endif

sources = $(srcdir)/f1.src $(srcdir)/f2.src $(srcdir)/f3.src
objects = $(builddir)/f1.o $(builddir)/f2.o $(builddir)/f3.o


# build the final target
$(builddir)/target: $(objects) | $(builddir)
	@echo -e "\n--- run rule $@ : $^ ---"
	cat $^ > $@

# Create the 'object files in build directory'
$(builddir)/%.o : $(srcdir)/%.src conf | $(builddir)
	@echo -e "\n--- run rule $@ : $^ ---"
	@echo "pattern stem \$$* : $*"
	cat $^ > $@

# Create the 'source' files
$(srcdir)/%.src : | $(srcdir)
	@echo -e "\n--- run rule $@ ---"
	@echo "pattern stem \$$* : $*"
	echo "Text $@" > $@

conf:
	@echo -e "\n--- run rule $@ ---"
	echo "Configuration" > $@

# Create directory
$(builddir) $(srcdir):
	@echo -e "\n--- run rule $@ ---"
	mkdir $@

# cleanup all artifacts
clean:
	@echo "--- run rule $@ ---"
	rm -rfv $(builddir)/target $(sources) $(objects) conf
ifndef NO_DIR
	-rmdir $(builddir) $(srcdir)
endif
.PHONY: clean

58_1_pattern_rules_dir.mk:;
