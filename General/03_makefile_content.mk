# What a makefile contains

# Usage: make -f 03_makefile_content.mk

# see: https://www.gnu.org/software/make/manual/make.html#Makefile-Contents

# Makefiles contain five kinds of things:
# explicit rules, implicit rules, variable definitions, directives, and comments.

# *** An explicit rule says when and how to remake one or more files, called the rule’s targets.
#     It lists the other files that the targets depend on, called the prerequisites of the target,
#     and may also give a recipe to use to create or update the targets.
target: prerequisite1 prerequisite2
	# target: Recipe to create/update target

# *** An implicit rule says when and how to remake a class of files based on their names. It describes how a target may
#     depend on a file with a name similar to the target and gives a recipe to create or update such a target.
$(objects): %.o: %.c
	gcc -o $@ -c $<

# *** A variable definition is a line that specifies a text string value for a variable that can be substituted into the
#     text later.
var1 = content of var1

# *** A directive is an instruction for make to do something special while reading the makefile.
#     These include: Includes, Conditionals, Defines

#   # Includes: Reading another makefile
include 03_makefile_content_inc.mk

#   # Conditionals: Deciding (based on the values of variables) whether to use or ignore a part of the makefile.
ifdef var1
$(info var1 = $(var1))
else
$(info var1 is not defined or empty)
endif

#   # Defines: Defining a variable from a verbatim string containing multiple lines.
define multiline_variable
line
endef

# *** '#’ in a line of a makefile starts a comment. It and the rest of the line are ignored, except that a trailing \
      backslash not escaped by another backslash will continue the comment across multiple lines.\
      A line containing just a comment (with perhaps spaces before it) is effectively blank, and is ignored.\
      If you want a literal #, escape it with a backslash (e.g., \#).\
      Comments may appear on any line in the makefile, although they are treated specially in certain situations
var2 = In varaible assignements a literal \# must be escaped with a backslash. # The comment starts with a unescaped #

# NOTE: You cannot use comments within variable references or function calls: any instance of # will be treated\
        literally
$(info In functions the symbol # is treated literally.)
$(info $(var2))
$(info )

prerequisite1: # The unescaped hashmark starts a comment in rules
	# prerequisite1: Recipe lines are passed to the shell almost unchanged.
prerequisite2:
	# prerequisite2: The shell decides how to interpret it: whether or not this is a comment is up to the shell. 

define multiline_variable
# Within a define directive, comments are not ignored during the definition of the variable,
# but rather kept intact in the value of the variable.
# When the variable is expanded they will either be treated as make comments or as recipe text,
# depending on the context in which the variable is evaluated.

endef

$(info expanding a multiline variable in function context)
$(info $(multiline_variable))

# NOTE: Make works in two distinct phases: a read-in phase and a target-update phase.
# The read-in phase reads the makefile processes all directives and expands all references.
# The info function prints the (expanded) arguments to standard output and expands to the empty string.)
# Thus it can be used everywhere in a makefile.
$(info END - Last line reached; The target-update phase starts now.)
