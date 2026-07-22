# Usage of function eval

# Usage: make -f 42_eval_function_list_processing.mk

# Use eval function to process a list.
# Avoid unnecessary expansions, use variables instead.
# see: 43_eval_function_in_functions.mk

# a list with 2 columns separated by ;
# lines are separated by a space
# headline:  module-name; cmi-file
MOD_CMI_LIST ::= module$$1;gcm.cache/module$$1.gcm
MOD_CMI_LIST += greetings-impl;gcm.cache/greetings-impl.gcm
MOD_CMI_LIST += weired-][?*!§%\\\src,(1){äæ-module1;gcm.cache/weired-name\#=:][?*!§%\\\src,(1){äæ.gcm
#MOD_CMI_LIST += weired-][?*!§%\\\src,(1){äæ-module\;gcm.cache/weired-name\\\#=:][?*!§%\\\src,(1){äæ.gcm\\#
# NOTE: The list ends with a single backslash.
MOD_CMI_LIST += weired-][?*!§%\\\src,(1){äæ-module2;gcm.cache/weired-name\\\#=:][?*!§%\\\src,(1){äæ.gcm
# NOTE: Errors when backslash is at line end!

# function to escape dollar symbol with two dollar symbols and hide hasmarks for eval
escape = $(subst #,$$(hsm),$(subst $$,$$$$,$1))
hsm ::= \#

$(info Input)
$(foreach x,$(MOD_CMI_LIST),$(info MOD_CMI_LIST += $(x)))
$(info )

$(info ***** Use: #1 $$(eval $$(call assign,$$(mod),$$(cmi))))

# The function to define variables invoked by 'call'
define assign =
$(info $0 : 1=$1 2=$2)
module2cmi1_$1 ::= $2
modules1 += $1
cmifiles1 += $2
endef

# function to process the list and define the variables macro assign
split1 = $(foreach line,$1,\
  $(let mod cmi,$(subst ;, ,$(line)),\
    $(eval $(call assign,$(mod),$(cmi)))\
  )\
)

#$(call split1,$(subst $$,$$$$,$(subst #,\#,$(MOD_CMI_LIST))))
$(call split1,$(call escape,$(MOD_CMI_LIST)))

$(info Results:)
$(info modules1 = $(modules1))
$(info cmifiles1 = $(cmifiles1))
$(foreach mod,$(modules1),$(info module2cmi1_$(mod) = $(module2cmi1_$(mod))))
$(info )

$(info ***** Use: #2 $$(eval $$(assign2)))
# The function to define variables using named variables
define assign2 =
$(info $0 : mod=$(mod) cmi=$(cmi))
module2cmi2_$(mod) ::= $(cmi)
modules2 += $(mod)
cmifiles2 += $(cmi)
endef

# function to process the list and define the variables macro assign2
split2 = $(foreach line,$1,\
  $(let mod cmi,$(subst ;, ,$(line)),\
    $(eval $(assign2))\
  )\
)

$(call split2,$(call escape,$(MOD_CMI_LIST)))

$(info Results:)
$(info modules2 = $(modules2))
$(info cmifiles2 = $(cmifiles2))
$(foreach mod,$(modules2),$(info module2cmi2_$(mod) = $(module2cmi2_$(mod))))
$(info )

$(info ***** Use: #3 Variable assignment direct in eval function.)
split3 = $(foreach line,$1,\
  $(let mod cmi,$(subst ;, ,$(line)),\
    $(info $0 : mod=$(mod) cmi=$(cmi))\
    $(eval module2cmi3_$(mod) ::= $(cmi))\
    $(eval modules3 += $(mod))\
    $(eval cmifiles3 += $(cmi))\
  )\
)

$(call split3,$(call escape,$(MOD_CMI_LIST)))

$(info Results:)
$(info modules3 = $(modules3))
$(info cmifiles3 = $(cmifiles3))
$(foreach mod,$(modules3),$(info module2cmi3_$(mod) = $(module2cmi3_$(mod))))
$(info )

all:
