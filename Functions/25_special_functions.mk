# Special functions

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

$(info -§4- The shell Function)
# see: https://www.gnu.org/software/make/manual/html_node/Shell-Function.html
# It takes as an argument a shell command and expands to the output of the command.
# The only processing make does on the result is to convert each newline (or carriage-return / newline pair)
# to a single space. If there is a trailing (carriage-return and) newline it will simply be removed.

files := $(shell echo *.mk)
$(info files = '$(files)')
$(info -§4a- Be careful with recursively expanded variables; these variables are expanded when they are used!)
files_rec = $(shell echo *.mk; echo >&2 Shell runs)
$(info files_rec = '$(files_rec)')
$(info files_rec = '$(files_rec)')

#NOTE: see also expansion_export_loop.mk

$(info -$4b- The return result of the shell invokation is put to variable .SHELLSTATUS)
$(info .SHELLSTATUS = '$(.SHELLSTATUS)')
wrong := $(shell Non\ existing\ programm)
$(intcmp $(.SHELLSTATUS),0,,$(warning Shell exit status is $(.SHELLSTATUS)))

$(info -§5- The assignment !=)
# see: https://www.gnu.org/software/make/manual/html_node/Setting.html
# The shell assignment operator ‘!=’ can be used to execute a shell script and set a variable to its output.

CMD = echo *.mk
files != $(CMD)
$(info files = '$(files)')
$(info -§5a- Now files has flavor = '$(flavor files)')
$(info -§5b- The return result of the shell invokation is put to variable .SHELLSTATUS)
$(info .SHELLSTATUS = '$(.SHELLSTATUS)')

target:;
