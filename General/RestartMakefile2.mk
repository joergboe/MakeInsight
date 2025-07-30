# Prevent searching for rule to re-build Makefile
# Try sample with make -f RestartMakefile2.mk --no-builtin-rules -d
# or               make NOTOUCH=1 -f RestartMakefile2.mk --no-builtin-rules -d
# or               make NORULE=1 -f RestartMakefile2.mk --no-builtin-rules -d

# If a makefile is a target of a (implicit) rule and the rule fires, the makefile is re-read
# This is true also for included files
# But the included file must be target of a rule. With NORULE=1 no restart takes place.

$(info START reading RestartMakefile1.mk)
$(info 0 MAKEFILE_LIST=$(MAKEFILE_LIST))
$(info 0 MAKE_RESTARTS=$(MAKE_RESTARTS))

ifneq ($(MAKE_RESTARTS),2)
  ifeq ($(NORULE),)
    $(info --- touch updateMakefile)
    xx := $(shell touch updateMakefile)
  else
    $(info --- touch tempHelper.mk)
    xx := $(shell touch tempHelper.mk)
  endif
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
RestartMakefile2.mk: ;

# Use an empty receipt to prevent searching at all
# Do not use a rule with no receipt!
#tempHelper.mk: ;
ifeq ($(NORULE),)
tempHelper.mk: updateMakefile
	@echo 'RULE $@'
ifeq ($(NOTOUCH),)
	@echo "Create/update $@"
	@echo -e $(helperContent) > $@
endif
endif

include tempHelper.mk

helperContent = "\$$(info START reading tempHelper.mk)\n\
\$$(info X MAKEFILE_LIST=\$$(MAKEFILE_LIST))\n\
\$$(info X MAKE_RESTARTS=\$$(MAKE_RESTARTS))\n\
\$$(info END reading helper.mk)"

$(info END reading RestartMakefile1.mk)