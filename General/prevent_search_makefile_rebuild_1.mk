# Prevent make from searching for an implicit rule to re-make this makefile.

# see: https://www.gnu.org/software/make/manual/html_node/Remaking-Makefiles.html

# Usage:
# make -f prevent_search_makefile_rebuild_1.mk -d

# This stops the try to re-make the Makefile
# Makefile 'prevent_search_makefile_rebuild_1.mk' might loop; not remaking it.
.PHONY: prevent_search_makefile_rebuild_1.mk

# The default goal 'all'
.PHONY: all
all:
