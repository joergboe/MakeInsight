# try this example with
# > make -f RuleExecution.mk
# > make --ignore-errors|-i RuleExecution.mk
# > make --keep-going|-k RuleExecution.mk

# These files must not exist
$(shell rm -f all target*)

# print a sigle $ sign
$(info $$)

all: target6

# The recipe line is passed literally to the shell. Normally sh
# The variable SHELL can change the used shell
# The arguments passed to the shell are taken from the variable .SHELLFLAGS
# normally -c or -ec in posix mode
# see also https://www.gnu.org/software/make/manual/make.html#Choosing-the-Shell
SHELL=/bin/bash
.SHELLFLAGS=-ec
target1:
	echo -e "command=$$0\n"

# Each line starts a new shell!
target2 : target1
	echo -e pid=$$$$
	echo -e "pid=$$$$\n"; ps
	ps

# Normally make prints each line before it is executed
# When the line starts wit a '@' the echo is suppressed. The '@' is discarded before the line is passed to the shell.
target3 : target2
	# this line is printed before execution
	@echo -e 'this line is not printed before execution\n'


# Each shell invocation must return successfully (the exit status is zero)
# If a shell returns an error, make gives up on current rule, and perhaps on all rules.
# When the recipe line starts with '-' make ignores the error.
# see: https://www.gnu.org/software/make/manual/make.html#Errors
target4 : target3
	@echo '--- rule4 to make target4 ---'
	-echo 'Return an error!' && false
	@echo -e 'Continuation of the recipe'
	@-echo -e "You can combine the '@' and the '-'\nReturn another error!" && exit 55
	@echo -e 'Continuation #2 of the recipe\n'

# With command line option --ignore-errors | -i make ignores errors in all recipes.
# With command line option -k, --keep-going make keeps going the remaining targets if a targets can't be made.
target5 : target4
	@echo '--- rule5 to make target5 ---'
	@echo -e 'Use option --ignore-errors or --keep-going to complete the script.\nReturn an error!' && false
	@echo -e 'Continuation of the recipe rule5\n'

# rules5a 5b use alternative syntax
target5a : ; @echo -e '--- rule5a to make target5a ---\n'
target5b:;@echo -e '--- rule5b to make target5b ---\n'

# targets 5, 5a and 5b contribute to target6
target6 : target5 target5a target5b
	@echo -e 'The final rule6 to make target6.\nAll done!!!\n'
