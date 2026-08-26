# Secondary Expansion

# If .SECONDEXPANSION is defined then when GNU make needs to check the prerequisites of a target, the prerequisites are
# expanded a second time.

# See: https://www.gnu.org/software/make/manual/html_node/Secondary-Expansion.html

# Usage: make -f 94_secondary_expansion_with_pattern_rules.mk

.SECONDEXPANSION:

SOURCES = foo$$.c bar$$.c baz.c
OBJECTS = $(SOURCES:.c=.o)

# NOTE: Variables with dollar signs should be expanded late.
target : $$(OBJECTS)
	@echo 'Rule $@ : $^'
	@echo 'Due to $?'
	@echo

OTHER = file_$$_one1

$(OBJECTS): %.o : %.c $$(OTHER) file_$$$$_one2
	@echo 'Rule $@ : $^'
	@echo 'Due to $?'
	@echo

$(SOURCES): %.c :
	@echo 'Rule $@ : $^'
	@echo

$(OTHER) file_$$_one2 :
	@echo 'Rule $@ : $^'
	@echo
