# Function eval

# Usage: make -f 40_eval_function.mk

# See: https://www.gnu.org/software/make/manual/html_node/Eval-Function.html

# The eval function is very special: it allows you to define new makefile constructs that are not constant; which are
# the result of evaluating other variables and functions. The argument to the eval function is expanded, then the
# results of that expansion are parsed as makefile syntax. The expanded results can define new make variables, targets,
# implicit or explicit rules, etc.

# The result of the eval function is always the empty string; thus, it can be placed virtually anywhere in a makefile
# without causing syntax errors.

# The eval argument is expanded twice; first by the eval function, then the results of that expansion are expanded again
# when they are parsed as makefile syntax. This means you may need to provide extra levels of escaping for “$”
# characters when using eval.

PROGRAMS    = pr1 pr2

PHONY: all
all: $(PROGRAMS)

# Use eval to generate rules and assignments
define PROGRAM_template =
 $(info generate rule for $1)
 $1: $1.o
	@echo Rule $$@
 ALL_OBJS   += $1.o
endef

$(foreach var,$(PROGRAMS),$(eval $(call PROGRAM_template,$(var))))

$(ALL_OBJS):

$(info ALL_OBJS = $(ALL_OBJS))

$(info )
text ::= Dollar $$$$ must be escaped twice; \# hashmark once; \\\# backslash hashmark must follow quoting rule;\
paranteses must match (x); and braches may not match{; comma, is possible
$(eval $$(info $(text)))

$(info )
# A list with 4 columns separated by ;
# headline:  source-file;module;cmi-file;is-interface
SRC_MOD_CMI_IS-IF_LIST = module$$1.cpp;module$$1;gcm.cache/module$$1.gcm;1
SRC_MOD_CMI_IS-IF_LIST += m_greetings-impl.cpp;greetings-impl;gcm.cache/greetings-impl.gcm;0
SRC_MOD_CMI_IS-IF_LIST += m_greetings_if.cpp;greetings_if;gcm.cache/greetings_if.gcm;1
SRC_MOD_CMI_IS-IF_LIST += weired\#name][?*!§%\\\src,(1){äæ.cpp;weiredname][?*!§%\\\src,(1){äæ-module;gcm.cache/weired\#name][?*!§%\\\src,(1){äæ.gcm;1

# The function to define variables invoked by 'call'
define split =
$(info $0 : $$1=$1 $$2=$2 $$3=$3 $$4=$4)
module2cmi_$2 ::= $3
modules += $2
modsources += $1
endef

split_four_column_list = $(foreach line,$1,\
  $(let src mod cmi is-if,$(subst ;, ,$(line)),\
    $(eval $(call split,$(src),$(mod),$(cmi),$(is-if)))\
  )\
)

# Escape $ and # with subst
$(call split_four_column_list,$(subst $$,$$$$,$(subst #,\#,$(SRC_MOD_CMI_IS-IF_LIST))))

$(info modules = $(modules))
$(info modsources = $(modsources))
$(info Database)
$(foreach mod,$(modules),$(info module2cmi_$(mod) = $(module2cmi_$(mod))))
$(info )

# The function to define variables using named variables
define split2 =
$(info $0 : $$(src)=$(src) $$(mod)=$(mod) $$(cmi)=$(cmi) $$(is-if)=$(is-if))
module2cmi2_$(mod) ::= $(cmi)
modules2 += $(mod)
modsources2 += $(src)
endef
# NOTE: The split macro must use $(src) but not $$(src) - The (local) variables src,mod.. are valid only when the eval
# arguments are expanded. These local variables are undefined in the second step when the eval result is parsed!

split_four_column_list = $(foreach line,$1,\
  $(let src mod cmi is-if,$(subst ;, ,$(line)),\
    $(eval $(split2))\
  )\
)

$(call split_four_column_list,$(subst $$,$$$$,$(subst #,\#,$(SRC_MOD_CMI_IS-IF_LIST))))

$(info modules2 = $(modules2))
$(info modsources2 = $(modsources2))
$(info Database2)
$(foreach mod,$(modules2),$(info module2cmi2_$(mod) = $(module2cmi2_$(mod))))
$(info )

# Variable definition direct in eval function
split_four_column_list = $(foreach line,$1,\
  $(let src mod cmi is-if,$(subst ;, ,$(line)),\
    $(info $0 : $$(src)=$(src) $$(mod)=$(mod) $$(cmi)=$(cmi) $$(is-if)=$(is-if))\
    $(eval module2cmi3_$(mod) ::= $(cmi))\
    $(eval modules3 += $(mod))\
    $(eval modsources3 += $(src))\
  )\
)
# NOTE: We must use $(src) but not $$(src) - The (local) variables src,mod.. are valid only when the eval
# arguments are expanded. These local variables are undefined in the second step when the eval result is parsed!

$(call split_four_column_list,$(subst $$,$$$$,$(subst #,\#,$(SRC_MOD_CMI_IS-IF_LIST))))

$(info modules3 = $(modules3))
$(info modsources3 = $(modsources3))
$(info Database3)
$(foreach mod,$(modules3),$(info module2cmi3_$(mod) = $(module2cmi3_$(mod))))
$(info )
