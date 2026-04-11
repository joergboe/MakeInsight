# Prevent make from searching for an implicit rule to re-make this makefile.

# see: https://www.gnu.org/software/make/manual/html_node/Remaking-Makefiles.html

# Usage:
# make -f 63_prevent_search_makefile_rebuild.mk -d

# This avoids to search in the database for almost all implicit rules.
.SUFFIXES:
# NOTE: But it still tries to apply the RCS and SCCS rules.

# The default goal 'all'
.PHONY: all
all:
