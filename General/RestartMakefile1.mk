# Prevent searching for rule to re-build Makefile
# Try sample with make -f RestartMakefile1.mk --no-builtin-rules -d
# or               make NOTOUCH=1 -f RestartMakefile1.mk --no-builtin-rules -d

# If a makefile is a target of a (implicit) rule and the rule fires, the makefile is re-read

$(info START reading RestartMakefile1.mk)
$(info --- MAKE_RESTARTS = $(MAKE_RESTARTS))

ifneq ($(MAKE_RESTARTS),2)
  $(info --- touch updateMakefile)
  xx := $(shell touch updateMakefile)
endif

.PHONY: all
all: intermediateTarget
	@echo 'RULE $@'
	@echo '--- MAKE_RESTARTS = $(MAKE_RESTARTS)'

# This is the alternative form of a rule
intermediateTarget: ; @echo 'RULE $@'

# This reduces the number of potential rules to update Makefile
.SUFFIXES:

# Use an empty receipt to prevent searching at all
# Do not use a rule with no receipt!
#RestartMakefile1.mk: ;
RestartMakefile1.mk: updateMakefile
	@echo 'RULE $@'
ifeq ($(NOTOUCH),)
	touch $@
endif

$(info END reading RestartMakefile1.mk)