# Multiple Rules for One Target:

# see: https://www.gnu.org/software/make/manual/make.html#Multiple-Rules
# One file can be the target of several rules. All the prerequisites mentioned in all the rules are
# merged into one list of prerequisites for the target. If the target is older than any prerequisite
# from any rule, the recipe is executed.
# There can only be one recipe to be executed for a file. If more than one rule gives a recipe for the
# same file, make uses the last one given and prints an error message. (As a special case, if the
# file’s name begins with a dot, no error message is printed. This odd behavior is only for compatibility
# with other implementations of make… you should avoid using it).

# Example target 'result' depends on 'f1', 'f2' and 'f3'.

# Usage: make -f 46_multiple_rules_one_target.mk # all rules run
#        make -f 46_multiple_rules_one_target.mk # target 'result' is up to date
#        touch f2
#        make -f 46_multiple_rules_one_target.mk # only 'result' runs
#
# Cleanup: make -f 46_multiple_rules_one_target.mk clean

result: f1
	@echo "---- run $@ ----"
	@echo "first prerequisite \$$< : $<"
	@echo "all prerequisites \$$^ : $^"
	@echo "prerequisites newer than the target \$$? : $?"
	@cat $^ > $@

# rules with the same target and without receipt are merged into one rule
result: f2
result: f3
# is the same as:
#result: f1 f2 f3
#	..

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
