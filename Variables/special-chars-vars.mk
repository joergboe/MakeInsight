# Special characters in variable names.
# Export of variables with special characters.

# See: https://www.gnu.org/software/make/manual/html_node/Using-Variables.html

# To substitute a variable’s value, write a dollar sign followed by the name of the variable in parentheses or braces:
# either ‘$(foo)’ or ‘${foo}’ is a valid reference to the variable foo.
# This special significance of ‘$’ is why you must write ‘$$’ to have the effect of a single dollar sign in a variable
# assignment, file name or recipe.

# A variable name may be any sequence of characters not containing ‘:’, ‘#’, ‘=’, or white-space. However, variable names
# containing characters other than letters, numbers, and underscores should be considered carefully, as in some shells
# they cannot be passed through the environment to a sub-make. Variable names beginning with ‘.’ and an uppercase letter
# may be given special meaning in future versions of make.

# Usage:
# make -f special-chars-vars.mk

# No escape possible for ‘:’, ‘#’, ‘=’, or whitespace!
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
#cxx\	aaa = 555
# special-chars-vars.mk:14: *** missing separator.  Stop.

# Define a multi-line variable with a single new-line.
define nl :=


endef

ifeq (0,${MAKELEVEL})

# Note: Quote the hashmark in assignment.
# Note: the equal sign is always significat, thus the variable name has the trailing backslash.
cxx\=aaa = A variable name may be any sequence of characters not containing ‘:’, ‘\#’, ‘=’, or white-space.
$(info $(cxx\))

cxx$$dollar = var with dollar $$ must use $$$$
vl = cxx\ cxx$$dollar
$(info $(cxx$$dollar))

cxx$$$$2dollar := var with 2 dollars $$$$ must use $$$$$$$$
vl += cxx$$$$2dollar
$(info $(cxx$$$$2dollar))

cxx@aaa = var with @ cxx@aaa
vl += cxx@aaa

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

cxx!aaa = var with ! cxx!aaa
vl += cxx!aaa

cxx%aaa = var with % cxx%aaa
vl += cxx%aaa

cxx&aaa = var with & cxx&aaa
vl += cxx&aaa

# slashes
cxx\aaa = var with \ xx\aaa
vl += cxx\aaa

cxx\\aaa = var with \\ xx\\aaa
vl += cxx\\aaa

cxx/aaa = var with / cxx/aaa
vl += cxx/aaa

cxx//aaa = var with // cxx//aaa
vl += cxx//aaa

# wildcard chars
cxx*aaa = var with * cxx*aaa
vl += cxx*aaa

cxx\*aaa = var with \* cxx\*aaa
vl += cxx\*aaa

cxx?aaa = var with ? cxx?aaa
vl += cxx?aaa

cxx\?aaa = var with \? cxx\?aaa
vl += cxx\?aaa

cxx[aaa = var with [ cxx[aaa
vl += cxx[aaa

cxx]aaa = var with ] cxx]aaa
vl += cxx]aaa

# Quotes
cxx"aaa = var with " cxx"aaa
vl += cxx"aaa

cxx'aaa = var with ' cxx'aaa
vl += cxx'aaa

# Non ascii charactes
cxx§aaa = var with § cxx§aaa
vl += cxx§aaa

cxxäaaa = var with ä cxxäaaa
vl += cxxäaaa

cxxéaaa = var with é cxxéaaa
vl += cxxéaaa

cxxæaaa = var with æ cxxæaaa
vl += cxxæaaa

# Don't do this! Danger when parentheses are used unpaired.
cxx()aaa = Danger when parentheses are used unpaired: var with () 666cxx()aaa
vl += cxx()aaa

cxx{}aaa = Danger when parentheses are used unpaired: var with {} 777cxx{}aaa
vl += cxx{}aaa

export $(vl)
export vl

$(info ***************************************************************)
$(info Names list: $(vl))
$(info $(foreach var,$(vl),$(nl)$(var) = $($(var)) origin = $(origin $(var))))
$(info )

.PHONY: all
all:
	$(MAKE) -f special-chars-vars.mk
else

$(info )
$(info *** Recursion level - Check whether variables with special names are exported propperly ***)
$(info Names List: $(vl))
$(info $(foreach var,$(vl),$(nl)$(var) = $($(var)) origin = $(origin $(var))))
$(info )
$(info The variables cxx$$dolla and cxx$$$$2dolla are available in the recursion level.)
$(info But in the names list $$$$ is expanded to $$ !)

$(info cxx$$dollar = $(cxx$$dollar))
$(info cxx$$$$2dollar = $(cxx$$$$2dollar))

.PHONY: all
all:
	# Adding a variable’s value to the environment requires it to be expanded. If expanding a variable has side-effects
	# (such as the info or eval or similar functions) then these side-effects will be seen every time
	# a command is invoked. You can avoid this by ensuring that such variables have names which
	# are not exportable by default. However, a better solution is to not use this “export by default”
	# facility at all, and instead explicitly export the relevant variables by name. 
endif
