# Recipe execution using one shell

# Usage:
# > make -i -f 32_recipe_execution_one_shell.mk
# > make -f 32_recipe_execution_one_shell.mk

# Normally each line of a recipe starts a new shell. But you can start all lines in a
# single shell with the special target .ONESHELL:
# This can increase the performance when your receipts consist of many command lines,
# by avoiding extra processes.
# see also : https://www.gnu.org/software/make/manual/make.html#One-Shell

# If the .ONESHELL special target appears anywhere in the makefile then
# all recipe lines for each target will be provided to a single invocation of the shell.
# Newlines between recipe lines will be preserved

.ONESHELL:

# These files must not exist
$(shell rm -f all target*)

$(info Default values)
$(info SHELL = $(SHELL))
$(info .SHELLFLAGS = $(.SHELLFLAGS))
# NOTE: Unlike most variables, the variable SHELL is never set from the environment. This is because the SHELL
# environment variable is used to specify your personal choice of shell program for interactive use.

.PHONY: all
all : target3
	@echo -e '--- rule all\nAll done!!!\n'

target1:
	@echo '--- rule1: run in one shell ---'
	echo \$$0=$$0
	echo 'The change of the directory is effective in following lines of the recipe.'
	pwd
	cd ..
	pwd
	echo

# If .ONESHELL is provided, then only the first line of the recipe
# will be checked for the special prefix characters (‘@’, ‘-’, and ‘+’)
# If you want your recipe to start with one of these special characters you’ll
# need to arrange for them to not be the first - characters on the first line,
# perhaps by adding a comment or similar. 
target2: target1
	@# dummy comment to place the '@' at the start of the first line
	echo '--- rule2: run in one shell, no print ---'
	echo 'The process id of the current shell is equal in all lines of the recipe.'
	echo pid=$$$$
	echo pid=$$$$
	echo The shell command is:
	echo \$$0=$$0
	@echo If the shell is determied a POSIX-shell, the special prefix characters\
	 in “internal” recipe lines will be removed before the recipe is processed.
	echo

# Special care must be taken to propagate possible errors in one line to the
# exit status of the shell
# Use .SHELLFLAGS = -ce for shells like sh or bash
SHELL = /usr/bin/bash
.SHELLFLAGS = -ce
# NOTE: These assignments are executed before the rules are processed!

target3: target2
	@echo '--- rule3 : provoke an error in one line ---'
	echo -e 'Use command line option -i to finalize the script\n'
	false
	echo '!!! This line is never reached!!!'
