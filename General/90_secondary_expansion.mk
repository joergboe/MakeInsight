# Secondary Expansion

# If .SECONDEXPANSION is defined then when GNU make needs to check the prerequisites of a target, the prerequisites are
# expanded a second time.

# See: https://www.gnu.org/software/make/manual/html_node/Secondary-Expansion.html

# Usage: make -f 90_secondary_expansion.mk

.SECONDEXPANSION:

ONEVAR = foo$$
TWOVAR = bar$$

$(info $$(value TWOVAR) = $(value TWOVAR))
$(info $(subst $$,$$$$,$(TWOVAR)))

targets = target
$(targets) : % : $$(ONEVAR) $(subst $$,$$$$,$(TWOVAR)) file_$$$$_one file_$$$$$$$$_two
	@echo 'Rule $@ : $^'
	@echo 'Due to $?'
# NOTE: Implicit prerequisites are expanded twice, thus a single symbol $ must be written using 4 $ symbols.
# NOTE: If a variable is eagerly expanded variables in prerequisites, dollar symbols must be escaped.

$(ONEVAR) $(TWOVAR) file_$$_one file_$$$$_two :
	@echo 'Rule $@'
