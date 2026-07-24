# Usage of function eval to generate rules

# Usage: make -f 41_eval_function_rules.mk

# Expansion in eval function. Escape $ and # symbols.

PROGRAMS    = foo$$.exe bar\#.exe # baz\\\#.exe

$(info PROGRAMS = $(PROGRAMS))
$(info value PROGRAMS = $(value PROGRAMS))
$(info )

PHONY : all
all : $(PROGRAMS)
	@echo 'Run rule all'

# Use eval to generate rules and assignments
# Macro requires a variable var with the name of the program to generate.
define PROGRAM_template =
$(info immediate expansion - generate rule for $(var))
$$(info late      expansion - generate rule for $$(var))
$(var) : $(var:.exe=.o)
	@echo 'Rule $$@ runs due to $$?'
ALL_OBJS   += $(var:.exe=.o)
endef

# The foreach loop provides the variable var
# The variables are expanded in target, prerequisite and assignment.
# The value function helps to escapes the dollar symbol for recursive variables
# Escape the hashmark with bs. This is required in targets, prerequisites and assignments.
$(foreach var,$(subst #,\#,$(value PROGRAMS)),\
    $(eval $(PROGRAM_template))\
    $(info )\
)

$(ALL_OBJS) :

$(info ALL_OBJS = $(ALL_OBJS))
$(info flavor ALL_OBJS = $(flavor ALL_OBJS))
$(info )

#NOTE: The display 'generate rule..' is broken! - Info function expands the escaped string.
#NOTE: The simple substitution for the hash mark fails if the hash mark is preceded by a backspace.
