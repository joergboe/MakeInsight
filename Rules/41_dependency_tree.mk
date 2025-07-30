# For more complex problems, rules can be chained. The prerequisites for one rule can
# be used as the target of another rule. This allows complex dependency trees to be expressed.

# The action target 'all' depends on target 'result'.
# The file target 'result' depends on 'f1', 'f2' and 'f3'.
# The files 'f1', 'f2' and 'f3' are created if necessary.

# Cleanup: make -f 41_dependency_tree.mk clean
# Usage: make -f 41_dependency_tree.mk # rules 'all', 'result', 'f1, 'f2' and 'f3' run.
#        make -f 41_dependency_tree.mk # only rule all runs
#        echo "New text number 2" > f2
#        make -f 41_dependency_tree.mk # only 'result' and 'all' run

# Files all and clean must not exist.
$(shell rm -f all clean)

all: result
	#--- run rule all ---
	cat result

# Automatic variables:
# see: https://www.gnu.org/software/make/manual/make.html#index-_003c-_0028automatic-variable_0029

# What you do is use a special feature of make, the automatic variables. These variables have values computed afresh
# for each rule that is executed, based on the target and prerequisites of the rule.
#
# It’s very important that you recognize the limited scope in which automatic variable values are available:
# they only have values within the recipe. In particular, you cannot use them anywhere within the target list of a rule;
# they have no value there and will expand to the empty string. Also, they cannot be accessed directly within
# the prerequisite list of a rule. A common mistake is attempting to use $@ within the prerequisites list;
# this will not work. However, there is a special feature of GNU make, secondary expansion (see Secondary Expansion),
# which will allow automatic variable values to be used in prerequisite lists
result: f1 f2 f3
	#--- run $@ because $? are newer than target ---
	### the target : $@
	### the first prerequisites : $<
	### the names of all the prerequisites that are newer than the target, with spaces between them : $?
	### all prerequisites : $^
	### the directory part of the file name of the target : $(@D)
	cat $^ > $@

f1:
	#--- run $@ ---
	echo "Text no 1" > $@

f2:
	#--- run $@ ---
	echo "Text no 2" > $@

f3:
	#--- run $@ ---
	echo "Text no 3" > $@

# Normally make prints each line of the recipe before it is executed.
# When a line starts with ‘@’, the echoing of that line is suppressed. The ‘@’ is discarded before the line is passed to the shell.
# Typically you would use this for a command whose only effect is to print something.
# The ‘-s’ or ‘--silent’ flag to make prevents all echoing, as if all recipes started with ‘@’.
# A rule in the makefile for the special target .SILENT without prerequisites has the same effect (see Special Built-in Target Names). 
clean:
	@echo "--- run $@ ---"
	@rm -fv result f{1..3}
