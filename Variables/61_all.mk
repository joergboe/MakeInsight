# All variables
# Usage: make -f 61_all.mk ARG1=abc ARG2:=11

.POSIX:

$(info All Variables)
$(foreach var,$(sort $(.VARIABLES)),\
	$(info $(var) = $($(var))      flavor = $(flavor $(var))     origin = $(origin $(var)))\
)
$(info )
$(info END)
