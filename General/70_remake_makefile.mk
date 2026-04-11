# How Makefiles Are Remade

# see: https://www.gnu.org/software/make/manual/html_node/Remaking-Makefiles.html

# Usage: make -f 70_remake_makefile.mk
# Expected: 2 restarts of make

# and    make NOTOUCH=1 -f 70_remake_makefile.mk
# Expected: No restart

# or     make -f 70_remake_makefile.mk --no-builtin-rules --debug

# Cleanup: make -f 70_remake_makefile.mk clean

# NOTE: If a makefile is a target of a (implicit) rule and the rule updates (touches) the makefile, the makefile is re-read

ifndef MAKE_RESTARTS
  $(info **** START reading $(MAKEFILE_LIST))
else
  $(info **** RESTART # $(MAKE_RESTARTS) reading $(MAKEFILE_LIST))
endif

ifneq ($(MAKE_RESTARTS),2)
  $(info *    touch updateMakefile)
  xx := $(shell touch updateMakefile)
endif

.PHONY: all
all: intermediateTarget
	@echo 'RULE $@'

# This is the alternative form of a rule
intermediateTarget: ; @echo 'RULE $@'

# This reduces the number of potential rules to update Makefile
.SUFFIXES:

70_remake_makefile.mk: updateMakefile
	@echo 'RULE $@'
ifeq ($(NOTOUCH),)
	touch $@
endif

$(info **** END reading $(MAKEFILE_LIST))

.PHONY: clean
clean:; rm -f updateMakefile
