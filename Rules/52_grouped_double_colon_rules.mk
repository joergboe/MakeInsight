# Grouped Double Colon Rules

# see: https://www.gnu.org/software/make/manual/make.html#Double_002dColon
# If you would like a target to appear in multiple groups, then you must use the double-colon grouped
# target separator, &:: when declaring all of the groups containing that target.
# Grouped double-colon targets are each considered independently, and each grouped double-colon rule’s
# recipe is executed at most once, if at least one of its multiple targets requires updating.

# Usage:   make -f 52_grouped_double_colon_rules.mk # all rules run except clean
#          make -f 52_grouped_double_colon_rules.mk # rule 'all' runs
#          rm res1
#          make -f 52_grouped_double_colon_rules.mk # rule 'all' and 'res1 res2' run
#          rm res2
#          make -f 52_grouped_double_colon_rules.mk # rule 'all', 'res1 res2' and 'res2 res3' run
#          rm res3
#          make -f 52_grouped_double_colon_rules.mk # rule 'all' and 'res2 res3' run
#          touch f1
#          make -f 52_grouped_double_colon_rules.mk # rule 'all' and 'res1 res2' run
#          touch f2
#          make -f 52_grouped_double_colon_rules.mk # rule 'all' and 'res2 res3' run

all: res1 res2 res3
	@echo -e "\n---- run $@ ----"
	cat res1
	cat res2
	cat res3

res1 res2 &:: f1
	@echo -e "\n---- run res1 res2 &::f1 ----"
	@echo "Triggered by \$$@: $@ - $?@: $?"
	echo "f1 used for generating: res1" > res1
	cat $< >> res1
	echo "f1 used for generating: res2" > res2
	cat $< >> res2

res2 res3 &:: f2
	@echo -e "\n---- run res2 res3 &::f2 ----"
	@echo "Triggered by \$$@: $@ - $?@: $?"
	echo "f2 used for generating: res2" > res2
	cat $< >> res2
	echo "f2 used for generating: res3" > res3
	cat $< >> res3

f1:
	@echo -e "\n---- run $@ ----"
	echo "Text1" > $@

f2:
	@echo -e "\n---- run $@ ----"
	echo "Text2" > $@

clean:
	rm -fv res{1..3} f1 f2

.PHONY: all clean
