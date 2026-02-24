# Rules with Grouped Targets

# see: https://www.gnu.org/software/make/manual/make.html#Multiple-Rules
# Multiple targets and multiple prerequisites.

# Usage  : make -f 49_1_grouped_target_rules.mk
#          # run rule 'res1 res2 res3' - $@ is res1 - $?: f1 f2

#          rm res3
#          make -f 49_1_grouped_target_rules.mk
#          # run rule 'res1 res2 res3' - $@ is res1 ! - $?: f1 f2

#          echo "Appendix" >> f1
#          make -f 49_1_grouped_target_rules.mk
#          # run rule 'res1 res2 res3' - $@ is res1 - $?: f1

#          echo "Appendix" >> f2
#          make -f 49_1_grouped_target_rules.mk
#          # run rule 'res1 res2 res3' - $@ is res1 - $?: f2

# Cleanup: make -f 49_1_grouped_target_rules.mk clean

.PHONY: all clean

all: res1 res2 res3
	@echo -e "\n---- run $@ ----"
	cat res1
	cat res2
	cat res3


res1 res2 res3&: f1 f2
	@echo -e "\n---- run res1 res2 res3 ----"
	@echo "Triggered by \$$@: $@ newer prerequisites \$$?: $?"
	echo "f1 used for generating: res1" > res1
	cat $^ >> res1
	echo "f1 used for generating: res2" > res2
	cat $^ >> res2
	echo "f1 used for generating: res3" > res3
	cat $^ >> res3

f1:
	@echo -e "\n---- run $@ ----"
	echo "Text1" > $@

f2:
	@echo -e "\n---- run $@ ----"
	echo "Text2" > $@

clean:
	rm -fv res{1..3} f1 f2
