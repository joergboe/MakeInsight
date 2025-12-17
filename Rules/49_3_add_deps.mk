# Rules with Grouped Targets

# see: https://www.gnu.org/software/make/manual/make.html#Multiple-Rules

# Unlike independent targets, a grouped target rule must include a recipe. However, targets that are 
# members of a grouped target may also appear in independent target rule definitions that do not have recipes.
# This add dependencies to the grouped target rule.

# Usage  : make -f 49_3_add_deps.mk
#          # run rule 'res1 res2 res3' $@ is res1 newer prerequisites $?: f1 f2 f3

#          make -f 49_3_add_deps.mk
#          # run rule all

#          echo "Appendix" >> f1
#          make -f 49_3_add_deps.mk
#          # run rule 'res1 res2 res3' $@ is res1 newer prerequisites $?: f1
#          # f1 f2 f3 used for generating

#          echo "Appendix" >> f2
#          make -f 49_3_add_deps.mk
#          # run rule 'res1 res2 res3' $@ is res1 newer prerequisites $?: f2
#          # f1 f2 f3 used for generating

#          echo "Appendix" >> f3
#          make -f 49_3_add_deps.mk
#          # run rule 'res1 res2 res3' $@ is res1 newer prerequisites $?: f3
#          # f1 f2 f3 used for generating

#          echo "Appendix2" >> f3
#          make -f 49_3_add_deps.mk all2
#          # run rule 'res1 res2 res3' $@ is res3 newer prerequisites $?:
#          # f1 f2 used for generating
#          !! newer is none and $^ is f1 and f2 !!

# Cleanup: make -f 49_3_add_deps.mk clean

all: res1 res2 res3
	@echo -e "\n---- run $@ ----"
	cat res1
	cat res2
	cat res3

all2: res3 res2 res1
	@echo -e "\n---- run $@ ----"
	cat res1
	cat res2
	cat res3

res1 res2 res3&: f1
	@echo -e "\n---- run res1 res2 res3 ----"
	@echo "Triggered by \$$@: $@ newer prerequisites \$$?: $?"
	echo "$^ used for generating: res1" > res1
	cat $^ >> res1
	echo "$^ used for generating: res2" > res2
	cat $^ >> res2
	echo "$^ used for generating: res3" > res3
	cat $^ >> res3

# add dependency f2 to res1 res2 and res3
res1 res2 res3: f2

# add dependency f3 to res1 only
# ERROR: The automatic variables $? and $^ are not propperly set!
res1: f3

f1:
	@echo -e "\n---- run $@ ----"
	echo "Text1" > $@

f2:
	@echo -e "\n---- run $@ ----"
	echo "Text2" > $@

f3:
	@echo -e "\n---- run $@ ----"
	echo "Text3" > $@

clean:
	rm -fv res{1..3} f{1..3}

.PHONY: all all2 clean
