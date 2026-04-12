# How Makefiles Are Remade

# If a included makefile is a target of a (implicit) rule and the rule updates (touches) the makefile, the makefile
# is re-read.
# see: https://www.gnu.org/software/make/manual/html_node/Remaking-Makefiles.html

# Usage: make -f 72_remake_makefile.mk
# Expect: 2 restarts of the main script
#         Script generatedMakefile.mk is 2 times or 3 times included/executed
#         Finally recipes target1 and target2 are fired

# Usage: make -f 72_remake_makefile.mk NOUPDATE=1
# Expect: No restart of the main script
#         Script generatedMakefile.mk is included once (generatedMakefile.mk must exist)
#         Finally recipes target1 and target2 are fired

# Cleanup: make -f 72_remake_makefile.mk clean
# Expect: 2 restarts and a final cleanup

# Usage: make -f 72_remake_makefile.mk NORULE=1
# Expect: make: *** No rule to make target 'generatedMakefile.mk'.  Stop.

# Cleanup: make -f 72_remake_makefile.mk clean

ifndef MAKE_RESTARTS
  $(info *** START reading $(MAKEFILE_LIST) ***)
else
  $(info *** RESTART # $(MAKE_RESTARTS) reading $(MAKEFILE_LIST) ***)
endif

# This reduces the number of potential rules searches to update Makefile
.SUFFIXES:

define makefileContent ::=
$$(info ** START reading generatedMakefile.mk)
$$(info MAKEFILE_LIST=$$(MAKEFILE_LIST))
$$(info MAKE_RESTARTS=$$(MAKE_RESTARTS))
$$(info ** END reading generatedMakefile.mk)
endef
# Export to environment of recipe
export makefileContent

ifndef NOTOUCH
  TOUCH = 1
endif

# Touch updateMakefile.mk at least one
ifndef MAKE_RESTARTS
  $(info touch updateMakefile.mk)
  $(shell touch updateMakefile.mk)
else
  ifneq ($(MAKE_RESTARTS),2)
    ifdef TOUCH
      $(info touch updateMakefile.mk)
      $(shell touch updateMakefile.mk)
    endif
  endif
endif

target2: target1; @echo 'RULE $@'

target1: ; @echo 'RULE $@'

# Use an empty receipt to prevent implicit rule searching at all
72_remake_makefile.mk: ;

ifndef NORULE
generatedMakefile.mk: updateMakefile.mk
	@echo 'RULE $@'
ifndef NOUPDATE
	@echo "Create/update $@"
	@echo "$${makefileContent}" > $@
else
	@echo done
endif
endif

# NOTE: generatedMakefile.mk may not exist, but must be target of one rule.
include generatedMakefile.mk

.PHONY: clean
clean:
	rm -f generatedMakefile.mk updateMakefile.mk target*

$(info END reading $(MAKEFILE_LIST))
