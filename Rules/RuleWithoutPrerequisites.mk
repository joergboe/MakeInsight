# try this example with
# > make -f RuleWithoutPrerequisites.mk

# Rules without prerequisite run when the target does not exist.
# These rules never run when the target exits.

$(shell rm target* all)
$(shell touch target2 target4 target6 dependon3 dependon4)

all: target1 target2 dependon3 dependon4 target5 target6
	@echo -e 'Final target all.\nAll done!\n'

target1:
	@echo '--- run target1 ---'
	touch target1
	@echo

# this rule never runs - provoke an error
target2:
	@echo '--- run target2 ---'
	touch target2
	false

# When the rule has no prerequisite and no recipe, then make imagines
# this target to have been updated whenever its rule is run.
# This implies that all targets depending on this one will always have their recipe run.
# see : https://www.gnu.org/software/make/manual/make.html#Force-Targets
target3:;
target4:

dependon3: target3
	@echo -e '--- dependon3 ---'
	touch dependon3
	@echo -e 'This rule runs every time since the target3 is considered always newer than dependon3!\n'

# this rule never runs, since dependon4 exists and target4 was not triggered
dependon4: target4
	@echo -e '--- dependon4 ---'
	touch dependon4
	false

# Double-colon rules
# see https://www.gnu.org/software/make/manual/make.html#Double_002dColon
target5::
	@echo '--- run target5 ---'
	-ls -la target5
	touch target5
	@echo

target6::
	@echo '--- run target6 ---'
	@echo 'Double-colon rules without prerequisite run also when the target exits!'
	#see https://www.gnu.org/software/make/manual/html_node/Double_002dColon.html
	-ls -la target6
	touch target6
	@echo

clean:
	rm -fv target{1..6} dependon3 dependon4
.PHONY: clean
