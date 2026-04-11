# Prevent make from searching for an implicit rule to re-make this makefile.

# see: https://www.gnu.org/software/make/manual/html_node/Remaking-Makefiles.html

# Usage:
# make -f 60_prevent_search_makefile_rebuild.mk -d

# The default target must be the first.
all:

# Write an explicit rule with the makefile as the target, and an empty recipe.
60_prevent_search_makefile_rebuild.mk:;
# NOTE: Do not use a rule with no receipt! A rule with no recipe will not end the implicit rule search.

.PHONY: all
all:;@echo 'Target all'
