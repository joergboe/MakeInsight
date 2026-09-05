# Secondary Expansion

# One may split prerequisites and place the candidates for secondary expansion near the end of the makefie.

# Usage: make -f 92_secondary_expansion.mk

ONEVAR = foo$$
TWOVAR = bar$$

targets = target
$(targets) : % : $(ONEVAR) file_$$_one
	@echo 'Rule $@ : $^'
	@echo 'Due to $?'
	@echo

$(ONEVAR) $(TWOVAR) file_$$_one file_$$$$_two :
	@echo 'Rule $@'
	@echo

.SECONDEXPANSION :
$(targets) : % : $$(TWOVAR) file_$$$$$$$$_two
