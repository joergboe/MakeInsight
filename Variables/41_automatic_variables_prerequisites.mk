# Automatic variables are not valid in prerequisites list

# See: https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html

# Usage: make -f 41_automatic_variables_prerequisites.mk
# Expected result: touch: cannot touch 'build/target': No such file or directory
# The builddir-rule is not triggered because $(@D) is empty in prerequisite list

# Cleanup: make -f 41_automatic_variables_prerequisites.mk clean

build/target: file1 file2 $(info $$(@D) = '$(@D)') | $(@D)
	touch $@

file1 file2:
	touch $@

build:
	mkdir $@

.PHONY: clean
clean:
	rm -f file1 file2
	rm -rf build
