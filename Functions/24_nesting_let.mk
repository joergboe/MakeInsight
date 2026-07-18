# Nesting function let

# Usage: make -f 24_nesting_let.mk

# Global variables are visible in let function context.
# The local variables of one level are visible in a nested function if the variable name differ.
# The local variables of one let function are visible in a nested call function.
# The local variables of one call function are visible in a nested let function.
# The origin of the variables is automatic and the flavor is simple.

define nl ::=


endef

# expand to variable info string
define var_0-3_info
# 0 = '$0'; origin = $(origin 0); flavor = $(flavor 0)
# 1 = '$1'; origin = $(origin 1); flavor = $(flavor 1)
# 2 = '$2'; origin = $(origin 2); flavor = $(flavor 2)
# 3 = '$3'; origin = $(origin 3); flavor = $(flavor 3)

endef

define var_v1-2_info
# v1 = '$(v1)'; origin = $(origin v1); flavor = $(flavor v1)
# v2 = '$(v2)'; origin = $(origin v2); flavor = $(flavor v2)

endef

$(info simple let context - $$(let v1 v2,aa bb cc,$$(info ...)))
exp ::= $(let v1 v2,aa bb cc,\
  $(var_v1-2_info)\
)
$(info $(exp))
$(info )

define var_v1-2_info2
# v1 = '$(v1)'; origin = $(origin v1); flavor = $(flavor v1)
# v2 = '$(v2)'; origin = $(origin v2); flavor = $(flavor v2)
# vn1 = '$(vn1)'; origin = $(origin vn1); flavor = $(flavor vn1)
# vn2 = '$(vn2)'; origin = $(origin vn2); flavor = $(flavor vn2)

endef

$(info nested let context - $$(let v1 v2,aa bb cc dd,$$(let vn1 vn2,$$(v2),$$(info ...))))
exp ::= $(let v1 v2,aa bb cc dd,\
  $(let vn1 vn2,$(v2),\
    $(var_v1-2_info2)\
  )\
)
$(info $(exp))
$(info )

function_2 = $(var_0-3_info)$(var_v1-2_info)

$(info let with calling a function - $$(let v1 v2,l1 l2 l3,..))
exp = $(let v1 v2,aa bb cc dd,\
  $(call function_2,$(v1),$(v2))\
)
$(info $(exp))
$(info )

target: 3 = target_3
target:
	# Recipe context $@
	$(exp)
