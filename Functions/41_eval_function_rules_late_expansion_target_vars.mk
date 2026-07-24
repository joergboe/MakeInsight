# Usage of function eval to generate rules

# Usage: make -f 41_eval_function_rules_late_expansion_target_vars.mk

# * Delayed expansion. Using references for target, prerequisite and in assignment.
# * The variable rule_template is expanded in the body of the eval function.
# * Targets, prerequisites and assignments are expanded a second time inside eval.
# * Target variables store the values required in recipes.
# * Recipes use references to target variables.
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
$$(var) : my_target ::= $$(var)
$$(var) : $$(var:.exe=.o) # expansion here
	@echo 'Rule $$@ runs due to $$?'
	@echo 'target: $$(my_target) - pre: $$(my_target:.exe=.o)' # target variable
	@echo
objects += $$(var:.exe=.o) # expansion here
endef

# The foreach loop provides the variable var
$(foreach var,$(targets),\
    $(eval $(rule_template))\
    $(info )\
)

$(objects) :
	@echo 'Run rule $@'

$(info objects = $(objects))
$(info flavor objects = $(flavor objects))
$(info )

#NOTE: The display 'generate rule..' is correct. - Immediate and delayed expansion make the same string.
#NOTE: No issues with hashmark.
