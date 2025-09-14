# Usage: make -f non-ascii-vars.mk

define nl :=


endef

.PHONY: all
ifeq (0,${MAKELEVEL})

$(info Check variable names with non ASCII characters.)

naïve := value - naïve
vl = naïve

dänemark := value - dänemark
vl += dänemark

Færøerne := value - Færøerne
vl +=  Færøerne

Rønne := value - Rønne
vl += Rønne

变量 := value - 变量
vl += 变量

éè := value - éè
vl += éè

szß := value - szß
vl += szß

export $(vl)
export vl

$(info Liste: $(vl))
$(info $(foreach var,$(vl),$(nl)$(var) = $($(var)) origin = $(origin $(var))))

all:
	$(MAKE) -f non-ascii-vars.mk
else

$(info *** Recursion - Check whether variables with special names are exported propperly ***)
$(info Liste: $(vl))
$(info $(foreach var,$(vl),$(nl)$(var) = $($(var)) origin = $(origin $(var))))

all:
	# Adding a variable’s value to the environment requires it to be expanded. If expanding a variable has side-effects
	# (such as the info or eval or similar functions) then these side-effects will be seen every time
	# a command is invoked. You can avoid this by ensuring that such variables have names which
	# are not exportable by default. However, a better solution is to not use this “export by default”
	# facility at all, and instead explicitly export the relevant variables by name. 
endif
