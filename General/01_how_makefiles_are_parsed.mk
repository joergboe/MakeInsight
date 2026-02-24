# How Makefiles Are Parsed

# Usage: > make -f 01_how_makefiles_are_parsed.mk
# Result: The rule target1 is successfully executed.

# Usage: > make -f 01_how_makefiles_are_parsed.mk target2
# Result: No rule to make target 'echo'

# Usage: > make -f 01_how_makefiles_are_parsed.mk target3
# Result: The rule target3 is successfully executed.

# see: https://www.gnu.org/software/make/manual/html_node/Parsing-Makefiles.html

# GNU make parses makefiles line-by-line. Parsing proceeds using the following steps:
#
#	1. Read in a full logical line, including backslash-escaped lines.
#	2. Remove comments.
#	3. If the line begins with the recipe prefix character and we are in a rule context, add the line to the current
#	recipe and read the next line.
#	4. Expand elements of the line which appear in an immediate expansion context.
#	5. Scan the line for a separator character, such as ‘:’ or ‘=’, to determine whether the line is a macro
#	assignment or a rule.
#	6. Internalize the resulting operation and read the next line.

# An important consequence of this is that a macro can expand to an entire rule, if it is one line long. This will work:
rule1 = target1 : ; echo rule target1

$(rule1)

# However, this will not work because make does not re-split lines after it has expanded them:
define rule2
target2 :
	echo rule target2
endef

$(rule2)

# The above makefile results in the definition of a target ‘target’ with prerequisites ‘echo’ and ‘built’, as if the
# makefile contained target: echo built, rather than a rule with a recipe.
# Newlines still present in a line after expansion is complete are ignored as normal whitespace.

# In order to properly expand a multi-line macro you must use the eval function: this causes the make parser to be
# run on the results of the expanded macro.

define rule3
target3 :
	echo rule target3
endef

$(eval $(rule3))
