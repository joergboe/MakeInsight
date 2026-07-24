# Usage of function eval to generate rules

# Usage: make -f 41_eval_function_rules_late_expansion.mk

# Delayed expansion.

PROGRAMS    = foo$$.exe bar\#.exe baz\\\#.exe

$(info PROGRAMS = $(PROGRAMS))
$(info value PROGRAMS = $(value PROGRAMS))
$(info )

PHONY : all
all : $(PROGRAMS)
	@echo 'Run rule all due to $?'

# NOTE: Avoid references to local variable!
ALL_OBJS ::= # ensure the simply expanded variable flavor

# Use eval to generate rules and assignments
# Macro requires a variable var with the name of the program to generate.
define PROGRAM_template =
$(info immediate expansion - generate rule for $(var))
$$(info late      expansion - generate rule for $$(var))
$$(var) : $$(var:.exe=.o) # expansion here
	@echo 'Rule $$@ runs due to $$?'
ALL_OBJS   += $$(var:.exe=.o) # expansion here
endef

# The foreach loop provides the variable var
$(foreach var,$(PROGRAMS),\
    $(eval $(PROGRAM_template))\
    $(info )\
)

$(ALL_OBJS) :
	@echo 'Run rule $@'

$(info ALL_OBJS = $(ALL_OBJS))
$(info flavor ALL_OBJS = $(flavor ALL_OBJS))
$(info )

#NOTE: The display 'generate rule..' is correct. - Immediate and delayed expansion make the same string.
#NOTE: No issues with hashmark.
