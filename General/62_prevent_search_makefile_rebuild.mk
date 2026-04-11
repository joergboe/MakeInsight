# Prevent make from searching for an implicit rule to re-make this makefile.

# see: https://www.gnu.org/software/make/manual/html_node/Remaking-Makefiles.html

# Usage:
# make -f 62_prevent_search_makefile_rebuild.mk -d

# The default target must be the first.
all:

# Make ignore this rule:
# Makefile '62_prevent_search_makefile_rebuild.mk' might loop; not remaking it.
62_prevent_search_makefile_rebuild.mk:: ;

# NOTE: Double-Colon Rules with no prerequisites, its recipe is always executed
# (even if the target already exists)

.PHONY: all
all:;@echo 'Target all'
