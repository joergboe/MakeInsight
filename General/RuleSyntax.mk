# try this example with
# > make -f RuleSyntax.mk

# see also : https://www.gnu.org/software/make/manual/make.html#Rule-Syntax
# The syntax of rules is :
# targets : prerequisites
#	recipe
#	...
#
# Note: The recipe lines start with a tab character or the first character in the value of the .RECIPEPREFIX

# A file 'all' must not exist
$(shell rm -f all)

all : target6
	echo -e '--- rule all ---\nAll Done!!!\n'
#	touch $@

# The recipe is passed literally to the shell including comment
target1 :
	echo --- rule for target1 --- # comment
#	touch $@

# The backslash before newline can be used to split long lines.
# This recipe is handed to the shell as a single line.
# Note the first space character in the continuation line.
target2 : target1
	echo --- rule for target2 --- and a long\
	 long long long text
#	 touch $@

# a line with an tab character is an empty recipe
target3 : target2
#	touch $@
	
# The alternative syntax:
# targets : prerequisites ; recipe
#	recipe
target4 : target3; echo -e '--- rule for target4 --- uses the alternative syntax\n'
#	touch $@

# Make file variables are expanded with $(name), ${name} or $name
# The form $name is not recommended for normal variables. (Works only for one letter names)
# If you want to a $ in the recipe (to use a shell variable), you must double it.
LIST = one two three
TITLE = target5
T = target5
target5 : target4
	echo '--- $(TITLE) ---'
	echo ${TITLE}
	echo $T
	for i in $(LIST); do \
	  echo "$${i}"; \
	done; \
	echo
#	touch $@

# The recipe is passed to the shell. Normally sh
# Each line starts a new shell!
# If you want to a $ in the recipe, you must double it ($$ is the process id of the current shell)
target6 : target5
	echo pid=$$$$
	echo pid=$$$$
	echo -e "command=$$0\n"
#	touch $@

clean:
	echo --- rule for $@ ---
	rm -v target{1..6} all
