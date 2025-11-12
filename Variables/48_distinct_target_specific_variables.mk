# Target-specific Variables are distinct

# usage: make -f 48_distinct_target_specific_variables.mk

# See: https://www.gnu.org/software/make/manual/html_node/Target_002dspecific.html

# The variable-assignment can be any valid form of assignment; recursive (‘=’), simple (‘:=’ or ‘::=’), immediate (‘::=’),
# appending (‘+=’), or conditional (‘?=’). All variables that appear within the variable-assignment are evaluated
# within the context of the target: thus, any previously-defined target-specific variable values will be in effect.
# Note that this variable is actually distinct from any “global” value: the two variables do not have to have the same
# flavor (recursive vs. simple)

$(info Note: gvar is a simple variable in global context and a recursive variable in target context!)
gvar := global
var = global var

target: gvar += target
target: var := target.exe
target: file1.oo file2.oo
	@echo "*** Rule - $@ ***"
	@echo "gvar=$(gvar) flavor=$(flavor gvar) origin=$(origin gvar)"
	@echo "var=$(var) flavor=$(flavor var) origin=$(origin var)"
	@echo

file1.oo: gvar += object1
file2.oo: gvar += object2
file1.oo: var += object1.o
file2.oo: var += object2.o
%.oo: %.src header1 header2
	@echo "*** Rule - $@ ***"
	@echo "gvar=$(gvar) flavor=$(flavor gvar) origin=$(origin gvar)"
	@echo "var=$(var) flavor=$(flavor var) origin=$(origin var)"
	@echo


%.src: target_var = source
%.src: gvar += source12
%.src:
	@echo "*** Rule - $@ ***"
	@echo "gvar=$(gvar) flavor=$(flavor gvar) origin=$(origin gvar)"
	@echo "var=$(var) flavor=$(flavor var) origin=$(origin var)"
	@echo

header1: gvar += header1
header1:
	@echo "*** Rule - $@ ***"
	@echo "gvar=$(gvar) flavor=$(flavor gvar) origin=$(origin gvar)"
	@echo "var=$(var) flavor=$(flavor var) origin=$(origin var)"
	@echo

header2: gvar += header2
header2:
	@echo "*** Rule - $@ ***"
	@echo "gvar=$(gvar) flavor=$(flavor gvar) origin=$(origin gvar)"
	@echo "var=$(var) flavor=$(flavor var) origin=$(origin var)"
	@echo

$(info Global scope:)
$(info "gvar=$(gvar) flavor=$(flavor gvar) origin=$(origin gvar)")
$(info "var=$(var) flavor=$(flavor var) origin=$(origin var)")
$(info )
