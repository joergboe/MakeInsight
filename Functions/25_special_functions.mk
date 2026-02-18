# Special functions : value, origin, flavor

# Usage: make -f 25_special_functions.mk ARG1=11

$(info -§1- The value Function - $$(value variable))
# see: https://www.gnu.org/software/make/manual/html_node/Value-Function.html
# The value function provides a way for you to use the value of a variable without having it expanded.

CPPFLAGS = -MM -MF $*.dep -MP -MQ $@
$(info CPPFLAGS = '$(CPPFLAGS)')
$(info $$(value CPPFLAGS) = '$(value CPPFLAGS)')

$(info -§2- The origin Function - $$(origin variable))
# see: https://www.gnu.org/software/make/manual/html_node/Origin-Function.html
# The origin function tells you where the variable came from.
$(info $$(origin CPPFLAGS) = '$(origin CPPFLAGS)')
$(info $$(origin PATH) = '$(origin PATH)')
$(info $$(origin CXX) = '$(origin CXX)')
$(info $$(origin ARG1) = '$(origin ARG1)')

$(info -§3- The flavor Function - $$(flavor variable))
# see: https://www.gnu.org/software/make/manual/html_node/Flavor-Function.html
# The flavor function tells you the flavor of a variable.
$(info $$(flavor CPPFLAGS) = '$(flavor CPPFLAGS)')
$(info $$(flavor PATH) = '$(flavor PATH)')
$(info $$(flavor CXX) = '$(flavor CXX)')
$(info $$(flavor ARG1) = '$(flavor ARG1)')

var1 := 
var2 :::=
$(info $$(flavor var1) = '$(flavor var1)')
$(info $$(flavor var2) = '$(flavor var2)')

target:;
