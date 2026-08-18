# Secondary Expansion

# Split prerequisites is possible.

# Usage: make -f 92_secondary_expansion.mk

ONEVAR = foo
TWOVAR = bar

targets = target
$(targets) : % : $(ONEVAR) file_$$_one
	@echo 'Rule $@ : $^'
	@echo 'Due to $?'

$(ONEVAR) $(TWOVAR) file_$$_one file_$$$$_two :
	@echo 'Rule $@'

.SECONDEXPANSION :
$(targets) : % : $$(TWOVAR) file_$$$$$$$$_two
