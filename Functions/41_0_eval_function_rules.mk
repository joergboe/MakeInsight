# Usage of function eval to generate rules

# Usage: make -f 41_0_eval_function_rules.mk

# * Expansion in eval function - Escape $ and # symbols beforehand.
# * All variables except $@ and $? are expanded in the body of the eval function.
# * Targets, prerequisites and assignments are expanded a second time inside eval. This is a NOP is this case.
# * Recipes are expanded later in context of the rule.
# * Shell quoting is applied in recipes.

targets = foo$$.exe bar\#.exe # baz\\\#.exe

$(info targets = $(targets))
$(info value targets = $(value targets))
$(info )

PHONY : all
all : $(targets)
	@echo 'Run rule all'

# Use eval to generate rules and assignments
# Macro requires a variable var with the name of the program to generate.
define rule_template =
$(info immediate expansion - generate rule for $(var))
$$(info late      expansion - generate rule for $$(var))
$(var) : $(var:.exe=.o)
	@echo 'Rule $$@ runs due to $$?'
	@echo 'target: $(var) - pre: $(var:.exe=.o)'
	@echo
endef

# The foreach loop provides the variable var
# NOTE: The value function helps to escapes the dollar symbol for the recursively expanded variable 'targets'
# Escape the hashmark with bs. This is required in targets, prerequisites and assignments.
$(foreach var,$(subst #,\#,$(value targets)),\
    $(eval $(rule_template))\
    $(eval objects += $(var:.exe=.o))\
    $(info )\
)

$(objects) :

$(info objects = $(objects))
$(info flavor objects = $(flavor objects))
$(info )

#NOTE: The display 'generate rule..' is broken! - Info function expands the escaped string.
#NOTE: The recipe is broken \# vs #
#NOTE: The simple substitution for the hash mark fails if the hash mark is preceded by a backspace.
