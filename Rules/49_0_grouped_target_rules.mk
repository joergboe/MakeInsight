# Rules with Grouped Targets

# see: https://www.gnu.org/software/make/manual/make.html#Multiple-Rules
# If instead of independent targets you have a recipe that generates multiple files from a single invocation,
# you can express that relationship by declaring your rule to use grouped targets. A grouped target
# rule uses the separator &: (the ‘&’ here is used to imply “all”).
# When make builds any one of the grouped targets, it understands that all the other targets in the 
# group are also updated as a result of the invocation of the recipe. Furthermore, if only some of the
# grouped targets are out of date or missing make will realize that running the recipe will update all
# of the targets.
# Finally, if any of the grouped targets are out of date, all the grouped targets are considered out of date.

# During the execution of a grouped target’s recipe, the automatic variable ‘$@’ is set to the name
# of the particular target in the group which triggered the rule.

# Unlike independent targets, a grouped target rule must include a recipe. However, targets that are 
# members of a grouped target may also appear in independent target rule definitions that do not have recipes.

# Usage  : make -f 49_0_grouped_target_rules.mk
#          # run rule 'res1 res2 res3' - $@ is res1

#          rm res3
#          make -f 49_0_grouped_target_rules.mk
#          # run rule 'res1 res2 res3' - $@ is res1 !

#          rm res2
#          make -f 49_0_grouped_target_rules.mk
#          # run rule 'res1 res2 res3' - $@ is res1 !

#          rm res3
#          make -f 49_0_grouped_target_rules.mk res2
#          # run rule 'res1 res2 res3' - $@ is res2

#          touch f1
#          make -f 49_0_grouped_target_rules.mk all2
#          # run rule 'res1 res2 res3' - $@ is res2

#          touch f1
#          make -f 49_0_grouped_target_rules.mk all3
#          # run rule 'res1 res2 res3' - $@ is res3

# Cleanup: make -f 49_0_grouped_target_rules.mk clean

.PHONY: all1 all2 all3 clean

all1: res1 res2 res3
	@echo -e "\n---- run $@ ----"
	cat res1
	cat res2
	cat res3

all2: res2 res3 res1
	@echo -e "\n---- run $@ ----"

all3: res3 res1 res2
	@echo -e "\n---- run $@ ----"


res1 res2 res3&: f1
	@echo -e "\n---- run res1 res2 res3 ----"
	@echo "Triggered by \$$@: $@"
	echo "f1 used for generating: res1" > res1
	cat $< >> res1
	echo "f1 used for generating: res2" > res2
	cat $< >> res2
	echo "f1 used for generating: res3" > res3
	cat $< >> res3

f1:
	@echo -e "\n---- run $@ ----"
	echo "Text1" > $@

clean:
	rm -fv res{1..3} f1
