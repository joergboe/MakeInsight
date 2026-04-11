# Prevent make from searching for an implicit rule to re-make this makefile.

# see: https://www.gnu.org/software/make/manual/html_node/Remaking-Makefiles.html

# Usage:
# make -f 61_prevent_search_makefile_rebuild.mk -d

# The default target must be the first.
all:

# This stops the try to re-make the Makefile
# Makefile '61_prevent_search_makefile_rebuild.mk' might loop; not remaking it.
.PHONY: 61_prevent_search_makefile_rebuild.mk

# The default goal 'all'
.PHONY: all
all:;@echo 'Target all'
