# Secondary Expansion

# If .SECONDEXPANSION is defined then when GNU make needs to check the prerequisites of a target, the prerequisites are
# expanded a second time.

# See: https://www.gnu.org/software/make/manual/html_node/Secondary-Expansion.html

# Usage: make -f 90_secondary_expansion.mk

.SECONDEXPANSION:

ONEVAR = foo$$
TWOVAR = bar$$

$(info $$(value TWOVAR) = $(value TWOVAR))
$(info )

targets = target
#$(targets) : % : $$(ONEVAR) $(subst $$,$$$$,$(TWOVAR)) file_$$$$_one file_$$$$$$$$_two
$(targets) : % : $$(ONEVAR) $(value TWOVAR) file_$$$$_one file_$$$$$$$$_two
	@echo 'Rule $@ : $^'
	@echo 'Due to $?'
	@echo
# NOTE: Prerequisites are expanded twice, thus explicit prerequisites must write 4 dollar symbols for a single symbol $.
# NOTE: If a variable is eagerly expanded variables in prerequisites, dollar symbols must be escaped.

$(ONEVAR) $(TWOVAR) file_$$_one file_$$$$_two :
	@echo 'Rule $@'
	@echo
