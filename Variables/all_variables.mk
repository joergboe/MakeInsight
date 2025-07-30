# All internal variables
# Usage: make -f all_variables.mk

.POSIX:

$(info $(.VARIABLES))
$(info $(foreach var,$(.VARIABLES),$(info $(var)    origin=$(origin $(var))    flavor=$(flavor $(var))   value='$(value $(var))'    ='$($(var))')))
