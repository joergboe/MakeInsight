# Double-Colon Rules

# see: https://www.gnu.org/software/make/manual/make.html#Double_002dColon
# Double-colon rules are explicit rules written with ‘::’ instead of ‘:’ after the target names.
# They are handled differently from ordinary rules when the same target appears in more than one rule.
# Pattern rules with double-colons have an entirely different meaning (see Match-Anything Pattern Rules).
#
# When a target appears in multiple rules, all the rules must be the same type: all ordinary,
# or all double-colon. If they are double-colon, each of them is independent of the others.
# Each double-colon rule’s recipe is executed if the target is older than any prerequisites of that
# rule.
#
# Double-colon rules with the same target are in fact completely separate from one another.
# Each double-colon rule is processed individually, just as rules with different targets are processed.
#
# The double-colon rules for a target are executed in the order they appear in the makefile.

# Usage  : make -f 50_double_colon_rules.mk # target triggered by f1 and target triggered by f2
#          touch f1
#          make -f 50_double_colon_rules.mk # target triggered by f1
#          touch f2
#          make -f 50_double_colon_rules.mk # target triggered by f2
# Cleanup: make -f 50_double_colon_rules.mk clean

all: target
	@echo -e "\n---- run $@ ----"
	cat $<

target:: f1
	@echo -e "\n---- run $@ ----"
	@echo "Triggered by \$$?: $?"
	echo "f1 used for generating: $@" > $@
	cat $< >> $@

target:: f2
	@echo -e "\n---- run $@ ----"
	@echo "Triggered by \$$?: $?"
	echo "f2 used for generating: $@" > $@
	cat $< >> $@

f1:
	@echo -e "\n---- run $@ ----"
	echo "Text1" > $@

f2:
	@echo -e "\n---- run $@ ----"
	echo "Text2" > $@

clean:
	rm -fv res{1..3} f1 f2 target
.PHONY: all clean
