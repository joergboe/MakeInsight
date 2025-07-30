# ERROR with colon
#cxx\:aaa = 111
# special-chars-vars.mk:2: *** missing separator.  Stop.

# Error with #
#cxx\#aaa = 444
# special-chars-vars.mk:6: *** missing separator.  Stop.

# Error with space
#cxx\ aaa = 444
# special-chars-vars.mk:10: *** missing separator.  Stop.

# Error with tab
# cxx\	aaa = 555
# special-chars-vars.mk:14: *** missing separator.  Stop.

define nl :=


endef

.PHONY: all
ifeq (0,${MAKELEVEL})

$(info Errors with this characters \:, \#, \<space> and \<tab>)
# = is always significant
cxx\=aaa = Equal sign is always significant - do not quote colon : - do qoute hashmark \# not a comment
$(info $(cxx\))

cxx$$dollar = var with dollar $$ must use $$$$
vl = cxx\  cxx$$dollar
$(info $(cxx$$dollar))

cxx$$$$2dollar := var with 2 dollars $$$$ must use $$$$$$$$
vl += cxx$$$$2dollar
$(info $(cxx$$$$2dollar))

cxx@aaa = var with @ cxx@aaa
vl += cxx@aaa

cxx§aaa = var with § cxx§aaa
vl += cxx§aaa

cxx*aaa = var with * cxx*aaa
vl += cxx*aaa

cxx\*aaa = var with \* cxx\*aaa
vl += cxx\*aaa

cxx?aaa = var with ? cxx?aaa
vl += cxx?aaa

cxx\?aaa = var with \? cxx\?aaa
vl += cxx\?aaa

cxx-aaa = var with - cxx-aaa
vl += cxx-aaa

cxx.aaa = var with . cxx.aaa
vl += cxx.aaa

cxx,aaa = var with , cxx,aaa
vl += cxx,aaa

cxx;aaa = var with ; cxx;aaa
vl += cxx;aaa

cxx_aaa = var with _ cxx_aaa
vl += cxx_aaa

cxx\aaa = var with \ xx\aaa
vl += cxx\aaa

cxx\\aaa = var with \\ xx\\aaa
vl += cxx\\aaa

cxx/aaa = var with / cxx/aaa
vl += cxx/aaa

cxx//aaa = var with // cxx//aaa
vl += cxx//aaa

cxx?aaa = var with ? cxx?aaa
vl += cxx?aaa

cxx!aaa = var with ! cxx!aaa
vl += cxx!aaa

cxx%aaa = var with % cxx%aaa
vl += cxx%aaa

cxx&aaa = var with & cxx&aaa
vl += cxx&aaa

cxx"aaa = var with " cxx"aaa
vl += cxx"aaa

cxx'aaa = var with ' cxx'aaa
vl += cxx'aaa

cxx[aaa = var with [ cxx[aaa
vl += cxx[aaa

cxx]aaa = var with ] cxx]aaa
vl += cxx]aaa

# don't do this
cxx()aaa = var with () 666cxx()aaa
vl += cxx()aaa

cxx{}aaa = var with {} 777cxx{}aaa
vl += cxx{}aaa

export $(vl)
export vl

$(info Liste: $(vl))
$(info $(foreach var,$(vl),$(nl)$(var) = $($(var)) origin = $(origin $(var))))

all:
	$(MAKE) -f special-chars-vars.mk
else

$(info *** Recursion - Check whether variables with special names are exported propperly ***)
$(info Liste: $(vl))
$(info $(foreach var,$(vl),$(nl)$(var) = $($(var)) origin = $(origin $(var))))

$(info But the variables cxx$$dolla and cxx$$$$2dolla are here but were expanded!)
$(info cxx$$dollar = $(cxx$$dollar))
$(info cxx$$$$2dollar = $(cxx$$$$2dollar))

all:
	# Adding a variable’s value to the environment requires it to be expanded. If expanding a variable has side-effects
	# (such as the info or eval or similar functions) then these side-effects will be seen every time
	# a command is invoked. You can avoid this by ensuring that such variables have names which
	# are not exportable by default. However, a better solution is to not use this “export by default”
	# facility at all, and instead explicitly export the relevant variables by name. 
endif
