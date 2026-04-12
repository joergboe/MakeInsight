# How Makefiles Are Remade

# If a makefile is a target of a (implicit) rule and the rule updates (touches) the makefile, the makefile is re-read
# see: https://www.gnu.org/software/make/manual/html_node/Remaking-Makefiles.html

# Usage: make -f 70_remake_makefile.mk
# Expected: 2 restarts of make

# and    make -f 70_remake_makefile.mk NOTOUCH=1
# Expected: No restart

# or     make -f 70_remake_makefile.mk --no-builtin-rules --debug

# Cleanup: make -f 70_remake_makefile.mk clean
# NOTE: 2 restarts before cleanup!

ifndef MAKE_RESTARTS
  $(info START reading $(MAKEFILE_LIST))
else
  $(info RESTART # $(MAKE_RESTARTS) reading $(MAKEFILE_LIST))
endif

# This reduces the number of potential rules searches to update Makefile
.SUFFIXES:

ifneq ($(MAKE_RESTARTS),2)
  $(info touch updateMakefile)
  xx := $(shell touch updateMakefile)
endif

target2: target1; @echo 'RULE $@'

target1: ; @echo 'RULE $@'

70_remake_makefile.mk: updateMakefile
	@echo 'RULE $@'
ifeq ($(NOTOUCH),)
	touch $@
endif

.PHONY: clean
clean:; rm -f updateMakefile target1 target2

$(info END reading $(MAKEFILE_LIST))
