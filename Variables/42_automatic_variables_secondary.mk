# Automatic variables in prerequisites list and secondary expansion

# There is a special feature of GNU make, secondary expansion, which will allow automatic variable values to be used in
# prerequisite lists.

# See: https://www.gnu.org/software/make/manual/html_node/Secondary-Expansion.html

# Usage: make -f 42_automatic_variables_secondary.mk
# Expected result: The target is touched successfully in directory 'build'.

# Cleanup: make -f 42_automatic_variables_secondary.mk clean

.SECONDEXPANSION:

build/target: file1 file2 $$(info $$$$(@D) = '$$(@D)') | $$(@D)
	touch $@

file1 file2:
	touch $@

build :
	mkdir $@

.PHONY: clean
clean:
	rm -f file1 file2
	rm -rf build
