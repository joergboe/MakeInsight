# Nesting function let

# Usage: make -f 22_nesting_call.mk

# Global variables are visible in let function context.
# The local variables of one level are visible in a nested function if the variable name differ.
# The local variables of one let function are visible in a nested call function.
# The local variables of one call function are visible in a nested let function.
# The origin of the variables is automatic and the flavor is simple.

define nl ::=


endef

# expand to information string variables 1, 2..4
define var_0-4_info
# 0 = '$0'; origin = $(origin 0); flavor = $(flavor 0)
# 1 = '$1'; origin = $(origin 1); flavor = $(flavor 1)
# 2 = '$2'; origin = $(origin 2); flavor = $(flavor 2)
# 3 = '$3'; origin = $(origin 3); flavor = $(flavor 3)
# 4 = '$4'; origin = $(origin 4); flavor = $(flavor 4)
endef

$(info -§1- global context)
$(info $(var_0-4_info))
$(info default $$0, $$1, $$2 .. are undefined.$(nl))

$(info -§2- global context - define $$1, $$2 and $$3)
1 = global_1
2 ::= global_2
3 :::= global_3
$(info $(var_0-4_info))
$(info It is possible to define variables 1, 2,.. in global context but should be avoided.$(nl))

# a function expecting 2 parameters
func_2_param = $(var_0-4_info)

$(info -§3- function context, 2 params expected, 2 params provided)
text = $(call func_2_param,par31,par32)
$(info $(text))
$(info local variables 0, 1 and 2 hide global varables, global 3 is visible$(nl))

$(info -§4- function context 2 params expected, 1 param provided)
text = $(call func_2_param,par41)
$(info $(text))
$(info local variables 0 and 1 hide global variables, global 2 and 3 are visible$(nl))

$(info -§5- function context 2 params expected, 3 params provided)
text = $(call func_2_param,par51,par52,par53)
$(info $(text))
$(info local variables 0, 1, 2 and 3 hide global variables$(nl))

# a function expecting 2 parameters and calling func_1_param
func_2_param_n = $(var_0-4_info)$(nl)$(call func_1_param,intern1)

# a function expecting 1 parameter
func_1_param = $(var_0-4_info)

$(info -§6- nested function context 2 params expected, nested function expects 1 parameter)
text = $(call func_2_param_n,par61,par62)
$(info $(text))
$(info in nested call context local variables 0, 1 hide previous defined variables, local variable 2 is empty!,\
global 3 is visible$(nl))

# a function expecting 3 parameters an calling let function
func_3_param_let = $(let v1 v2,$1 $2 $3,$(var_v1v2_info)$(nl)$(var_0-4_info))

# expand to information string variables v1 and v2
define var_v1v2_info
# v1 = '$(v1)'; origin = $(origin v1); flavor = $(flavor v1)
# v2 = '$(v2)'; origin = $(origin v2); flavor = $(flavor v2)
endef

$(info -§7- nested let function context 3 params)
text = $(call func_3_param_let,par71,par72,par73)
$(info $(text))
$(info In nested let context context local variables of the calling function are visible!$(nl))

# a function expecting 2 parameters an calling for function
func_2_param_for = $(foreach var,$1 $2,$(var_0-4_info)$(nl)$(var_var_info)$(nl))

# expand to information string variable var
define var_var_info
# var = '$(var)'; origin = $(origin var); flavor = $(flavor var)
endef

$(info -§8- nested foreach function context 2 params)
text = $(call func_2_param_for,par81,par82)
$(info $(text))
$(info In nested foreach context context local variables of the calling function are visible!$(nl))

target: 3 = target_3
target:
	@echo '-§9- Recipe context $@'
	$(call func_2_param,91,92)
	@echo 'In recipe context global variables and target specific variables are visible'
