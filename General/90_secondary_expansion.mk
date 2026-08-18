# Secondary Expansion

# If .SECONDEXPANSION is defined then when GNU make needs to check the prerequisites of a target, the prerequisites are
# expanded a second time.

# See: https://www.gnu.org/software/make/manual/html_node/Secondary-Expansion.html

# Usage: make -f 90_secondary_expansion.mk

.SECONDEXPANSION:

ONEVAR = foo
TWOVAR = bar

targets = target
$(targets) : % : $(ONEVAR) $$(TWOVAR) file_$$$$_one file_$$$$$$$$_two
	@echo 'Rule $@ : $^'
	@echo 'Due to $?'

$(ONEVAR) $(TWOVAR) file_$$_one file_$$$$_two :
	@echo 'Rule $@'
