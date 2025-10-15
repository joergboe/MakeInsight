# Rules with Grouped Targets

# see: https://www.gnu.org/software/make/manual/make.html#Multiple-Rules

# Unlike independent targets, a grouped target rule must include a recipe. However, targets that are 
# members of a grouped target may also appear in independent target rule definitions that do not have recipes.
# This add dependencies to the grouped target rule.

# Usage  : make -f 49_2_add_deps.mk
#          # run rule 'res1 res2 res3' $@ is res1
#          make -f 49_2_add_deps.mk
#          # run rule 'res1 res2 res3' $@ is res1
#          touch f1
#          make -f 49_2_add_deps.mk
#          # run rule 'res1 res2 res3' $@ is res1
#          touch f2
#          make -f 49_2_add_deps.mk
#
#          # run rule 'res1 res2 res3' $@ is res2
#          touch f1
#          make -f 49_2_add_deps.mk res2
#          # run rule 'res1 res2 res3' $@ is res3
#          touch f2
#          make -f 49_2_add_deps.mk res3

# Cleanup: make -f 49_2_add_deps.mk clean

all: res1 res2 res3
	@echo -e "\n---- run $@ ----"
	cat res1
	cat res2
	cat res3

res1 res2 res3&: f1
	@echo -e "\n---- run res1 res2 res3 ----"
	@echo "Triggered by \$$@: $@"
	echo "$^ used for generating: res1" > res1
	cat $^ >> res1
	echo "$^ used for generating: res2" > res2
	cat $^ >> res2
	echo "$^ used for generating: res3" > res3
	cat $^ >> res3

# add dependency f2 to group res1 res2 and res3
res2: f2

f1:
	@echo -e "\n---- run $@ ----"
	echo "Text1" > $@

f2:
	@echo -e "\n---- run $@ ----"
	echo "Text2" > $@

clean:
	rm -fv res{1..3} f1 f2

.PHONY: all clean
