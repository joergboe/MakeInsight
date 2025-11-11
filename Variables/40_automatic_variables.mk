# Basics for automatic variables

# usage: make -f 40_automatic_variables.mk

# Automatic variables have values computed afresh for each rule that is executed, based on the target and prerequisites
# of the rule.
# Automatic variables only have values within the recipe. In particular, you cannot use them anywhere within the target
# list of a rule; they have no value there and will expand to the empty string. Also, they cannot be accessed directly
# within the prerequisite list of a rule.
# However, there is a special feature of GNU make, secondary expansion (see Secondary Expansion), which will allow
# automatic variable values to be used in prerequisite lists.
# See: https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html

define aut_vars :::=
Some important automatic variables are:
	$$@    The file name of the target of the rule.
	$$%    The target member name, when the target is an archive member.
	$$<    The name of the first prerequisite. 
	$$?    The names of all the prerequisites that are newer than the target, with spaces between them.
	$$^    The names of all the prerequisites, with spaces between them. So if you list a prerequisite more than once
	       for a target, the value of $$^ contains just one copy of the name. This list does not contain any of the
	       order-only prerequisites.
	$$+    This is like ‘$$^’, but prerequisites listed more than once are duplicated in the order they were listed
	       in the makefile.
	$$|    The names of all the order-only prerequisites, with spaces between them.
	$$*    The stem with which an implicit rule matches.

There are variants to get the directory part and to get the filename part like:
	$$(@D)    The directory part of the file name of the target, with the trailing slash removed.
	$$(@F)    The file-within-directory part of the file name of the target.

endef
$(info $(aut_vars))


source_files ::= f1.cc f2.cc f3.cc
object_files ::= $(source_files:%.cc=%.o)
header_files ::= h1.h h2.h

# If you want to define macros using automatic variables, you have to use recursive variables. These are expanded during
# use and thus produce the desired result.

macro1 = echo "Target : $@"
inv_macro1 ::= echo "Target : $@"
$(info Automatic variables are empty in this context:)
$(info macro1 = $(macro1))
$(info inv_macro1 = $(inv_macro1))
$(info )

echo_auto_vars = echo -e "\$$@ = $@\n\$$< = $<\n\$$^ = $^\n$$+ = $+\n\$$? = $?\n\$$* = $*\n"

target: $(object_files)
	@$(echo_auto_vars)

# Disable the builtin rule
%.o: %.cc
# Define this rule
%.o: %.cc $(header_files) h1.h
	@$(echo_auto_vars)

f1.cc:
	@$(macro1)
f2.cc:
	@$(macro1)
f3.cc:
	@$(macro1)
h1.h:
	@$(macro1)
h2.h:
	@echo "Note!"
	@$(inv_macro1)
