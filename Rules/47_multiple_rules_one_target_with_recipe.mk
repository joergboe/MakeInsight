# Multiple Rules for One Target:

# see: https://www.gnu.org/software/make/manual/make.html#Multiple-Rules
# There can only be one recipe to be executed for a file. If more than one rule gives a recipe for the
# same file, make uses the last one given and prints an error message. (As a special case, if the
# file’s name begins with a dot, no error message is printed. This odd behavior is only for compatibility
# with other implementations of make… you should avoid using it).

# Example target 'result' depends on 'f1', 'f2' and 'f3'.

# Usage: make -f 47_multiple_rules_one_target_with_recipe.mk # rule 'result: f3' is executed
#        make -f 47_multiple_rules_one_target_with_recipe.mk # rule 'all'
#        touch f2
#        make -f 47_multiple_rules_one_target_with_recipe.mk # rule 'result: f3' is executed !!
#
# Cleanup: make -f 47_multiple_rules_one_target_with_recipe.mk clean

.PHONY: all
all: result
	@echo "---- run $@ ----"
	cat result

# This rule is ignored
result: f1 f2
	@echo "---- run $@ : $^ ----"
	cat f1 f2 > $@

# This rule is taken
# Note: $^ is still the concatenation of both rules: f1 f2 f3
result: f3
	@echo "---- run $@ : $^ ----"
	cat f3 > $@

f1:
	@echo "---- run $@ ----"
	echo $@ > $@

f2:
	@echo "---- run $@ ----"
	echo $@ > $@

f3:
	@echo "---- run $@ ----"
	echo $@ > $@

.PHONY: clean
clean:
	rm -fv result f{1..3}
