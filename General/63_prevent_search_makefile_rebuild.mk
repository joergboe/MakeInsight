# Prevent make from searching for an implicit rule to re-make this makefile.

# see: https://www.gnu.org/software/make/manual/html_node/Remaking-Makefiles.html

# see: https://lists.gnu.org/archive/html/help-make/2024-01/msg00004.html

# Usage:
# make -f 63_prevent_search_makefile_rebuild.mk -d

# This avoids to search in the database for almost all implicit rules.
.SUFFIXES:
# Delete the RCS and SCCS rules;
%:: %,v
%:: RCS/%,v
%:: RCS/% # NOTE: add this too.
%:: s.%
%:: SCCS/s.%

# The default goal 'all'
.PHONY: all
all:
