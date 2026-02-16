# Demonstrate of function equal

# Usage: make -f equal.mk

empty:=
space:= $(empty) $(empty)

$(info -§1- Compare equal - This option is not completely safe.)
# Expands to 1 if param1 and param2 are equal or to the empty string otherwise
# Requires non empty parameter $1 and $1 must not be the repeated $2
# call eq,param1,param2
eq = $(if $(subst $(2),,$(1)),,1)

$(info $$(eq,1,2) = '$(call eq,1,2)')
$(info $$(eq,1,1) = '$(call eq,1,1)')
$(info $$(eq,aaaa,a) = '$(call eq,aaaa,a)' !!!)
$(info $$(eq,ababab,ab) = '$(call eq,ababab,ab)' !!!)
$(info $$(eq,1 ,1) = '$(call eq,1 ,1)')
$(info $$(eq,--,--) = '$(call eq,--,--)')
$(info $$(eq,--,- -) = '$(call eq,--,- -)')
$(info $$(eq, ,  ) = '$(call eq, ,  )')
$(info $$(eq,  , ) = '$(call eq,  , )')
$(info $$(eq,, ) = '$(call eq,, )' !!)
$(info $$(eq, ,) = '$(call eq, ,)')
$(info $$(eq,,) = '$(call eq,,)')


$(info $$(subst abc,,abcabcabc) = '$(subst abc,,abcabcabc)')

# No such thing
#define eq
#ifeq "$1" "$2"
#1
#endif
#endef


$(info -§2- Compare not equal - The save variant)
# Expands to non-empty string if param1 and param2 are not equal or to the empty string otherwise
# call neq,param1,param2
neq = $(or $(subst $2,,$1),$(subst $1,,$2))

$(info $$(neq,1,2) = '$(call neq,1,2)')
$(info $$(neq,1,1) = '$(call neq,1,1)')
$(info $$(neq,aaaa,a) = '$(call neq,aaaa,a)' !!!)
$(info $$(neq,ababab,ab) = '$(call neq,ababab,ab)' !!!)
$(info $$(neq,1 ,1) = '$(call neq,1 ,1)')
$(info $$(neq,--,--) = '$(call neq,--,--)')
$(info $$(neq,--,- -) = '$(call neq,--,- -)')
$(info $$(neq, ,  ) = '$(call neq, ,  )')
$(info $$(neq,  , ) = '$(call neq,  , )')
$(info $$(neq,, ) = '$(call neq,, )' !!)
$(info $$(neq, ,) = '$(call neq, ,)')
$(info $$(neq,,) = '$(call neq,,)')
