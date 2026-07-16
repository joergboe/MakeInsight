# Usage of function eval to generate rules

# Usage: make -f 41_eval_function_rules.mk

PROGRAMS    = pr1 pr2

PHONY: all
all: $(PROGRAMS)
	@echo 'Run rule all'

# Use eval to generate rules and assignments
define PROGRAM_template =
 $(info generate rule for $1)
 $1: $1.o
	@echo Rule $$@ runs due to $$?
 ALL_OBJS   += $1.o
endef

$(foreach var,$(PROGRAMS),$(eval $(call PROGRAM_template,$(var))))

$(ALL_OBJS):

$(info ALL_OBJS = $(ALL_OBJS))
$(info )
