# Nesting foreach functions

# Usage: make -f 23_nesting_foreach.mk

# Foereach functions can be nested. The local variables of one level are visible in a nested foreach function if
# the variable name differs.
# The origin of the variables is automatic and the flavor is simple.

define nl ::=


endef

# var_info expands to info string
define var_info0
# var = '$(var)'; origin = $(origin var); flavor = $(flavor var)
# foo = '$(foo)'; origin = $(origin foo); flavor = $(flavor foo)

endef

var = global var
$(info Simple foreach function)
$(info $(foreach foo,aa bb cc,$(var_info0)$(nl)))
$(info global variables are visible)
$(info )

$(info after foreach)
$(info $(var_info0))
$(info )

# var_info expands to info string
define var_info1
# foo = '$(foo)'; origin = $(origin foo); flavor = $(flavor foo)
# bar = '$(bar)'; origin = $(origin bar); flavor = $(flavor bar)

endef

$(info Nested foreach)
$(info $(foreach foo,aa bb cc,$(foreach bar,11 22,$(var_info1))))
$(info )


define var_info1
# foo = '$(foo)'; origin = $(origin foo); flavor = $(flavor foo)

endef

$(info Nested foreach same variable name foo)
$(info $(foreach foo,aa bb cc,$(var_info1)$(foreach foo,a b,$(var_info1))))
$(info )

define var_info3
# 0 = '$0'; origin = $(origin 0); flavor = $(flavor 0)
# 1 = '$1'; origin = $(origin 1); flavor = $(flavor 1)
# 2 = '$2'; origin = $(origin 2); flavor = $(flavor 2)
# 3 = '$3'; origin = $(origin 3); flavor = $(flavor 3)
# foo = '$(foo)'; origin = $(origin foo); flavor = $(flavor foo)

endef

function1 = $(foreach foo,$1 $2 $3,$(var_info3))
$(info foreach function nested in call function)
$(info $(call function1,p1,p2,p3))

target: var = target var
target:
	@echo ' Recipe context $@'
	$(foreach foo,aa bb cc,$(var_info0)$(nl))
	@echo 'In recipe context target specific variables are visible'
