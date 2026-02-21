# Rule Syntax

# Usage:
# > make -f 20_rule_syntax.mk

# see also : https://www.gnu.org/software/make/manual/make.html#Rule-Syntax

# The syntax of rules is :
# targets : prerequisites
#	recipe
#	...
#
# Or the syntax is like this :
# targets : prerequisites ; recipe
#	recipe
#	…
# NOTE: The recipe lines start with a tab character or the first character in the value of the .RECIPEPREFIX
#

# These files must not exist!
$(shell rm -f all target*)

all : target5
	echo -e '--- rule all ---\nAll Done!!!\n'

# The recipe is passed literally to the shell including comment
target1 :
	echo --- rule for target1 --- # comment

# The backslash before newline can be used to split long lines.
# This recipe is handed to the shell as a single line.
# NOTE: the first space character in the continuation line.
target2 : target1
	echo --- rule for target2 --- and a long\
	 long long long text

# a line with an tab character is an empty recipe
target3 : target2
	

# The alternative syntax:
# targets : prerequisites ; recipe
#	recipe
target4 : target3; echo -e '--- rule for target4 --- uses the alternative syntax\n'

# Make file variables are expanded with $(name), ${name} or $name
# The form $name is not recommended for normal variables. (Works only for one letter names)
# If you want to a $ in the recipe (to use a shell variable), you must double it.
list = one two three
t = --- rule for target5 ---
target5 : target4
	echo $(t)
	echo ${t}
	echo $t
	for i in $(list); do \
	  echo "$${i}"; \
	done; \
	echo
