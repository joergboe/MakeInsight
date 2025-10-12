# Prevent make from searching for an implicit rule to re-make this makefile.

# see: https://www.gnu.org/software/make/manual/html_node/Remaking-Makefiles.html

# Usage:
# make -f prevent_search_makefile_rebuild_2.mk -d

# The default goal 'all'
.PHONY: all
all:

# Make ignore this rule:
# Makefile 'prevent_search_makefile_rebuild_2.mk' might loop; not remaking it.
prevent_search_makefile_rebuild_2.mk:: ;

# Note: Double-Colon Rules with no prerequisites, its recipe is always executed
# (even if the target already exists)