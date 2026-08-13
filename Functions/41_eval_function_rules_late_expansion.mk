# Usage of function eval to generate rules

# Usage: make -f 41_eval_function_rules_late_expansion.mk

# * Delayed expansion. Using references for target, prerequisite and in assignment.
# * The variable rule_template is expanded in the body of the eval function.
# * Targets, prerequisites and assignments are expanded a second time inside eval.
# * Recipes are expanded later in context of the rule. Thus local variables must be expanded beforehand.
# * Shell quoting is applied in recipes.
targets    = foo$$.exe bar\#.exe baz\\\#.exe

$(info targets = $(targets))
$(info value targets = $(value targets))
$(info )

PHONY : all
all : $(targets)
	@echo 'Run rule all due to $?'

# NOTE: Avoid references to local variable!
objects ::= # ensure the simply expanded variable flavor

# Use eval to generate rules and assignments
# Macro requires a variable var with the name of the program to generate.
define rule_template =
$(info immediate expansion - generate rule for $(var))
$$(info late      expansion - generate rule for $$(var))
$$(var) : $$(var:.exe=.o) # expansion here
	@echo 'Rule $$@ runs due to $$?'
	$(subst $$,$$$$,@echo 'target: $(var) - pre: $(var:.exe=.o)')
	@echo
endef

# The foreach loop provides the variable var
$(foreach var,$(targets),\
    $(eval $(rule_template))\
    $(eval objects += $$(var:.exe=.o) # expansion here)\
    $(info )\
)

$(objects) :
	@echo 'Run rule $@'

$(info objects = $(objects))
$(info flavor objects = $(flavor objects))
$(info )

#NOTE: The display 'generate rule..' is correct. - Immediate and delayed expansion make the same string.
#NOTE: No issues with hashmark.
