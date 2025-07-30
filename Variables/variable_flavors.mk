# Look into the kinds of variable/macro definitions, their flavors and origin.
#
# Usage: ENVIRONMENT_VAR=environment_var make -r -f variable_flavors.mk ARGUMENT_VAR1=argument_var1 ARGUMENT_VAR2:=argument_var2

RECURSIVE_VAR = recursive_var
SIMPLE_VAR := simple_var# comment not included in var
define MULTILINE_VAR1
line1
	line2
endef

define MULTILINE_VAR2 =
  line1       # comment is included
  line2
endef

define MULTILINE_VAR3 :=
  line1       # comment is included
  line2
endef

$(info *** Types of variables from different sources)
$(info RECURSIVE_VAR:    origin=$(origin RECURSIVE_VAR) flavor=$(flavor RECURSIVE_VAR) value=$(RECURSIVE_VAR))
$(info SIMPLE_VAR:       origin=$(origin SIMPLE_VAR) flavor=$(flavor SIMPLE_VAR) value=$(SIMPLE_VAR))
$(info ENVIRONMENT_VAR:  origin=$(origin ENVIRONMENT_VAR) flavor=$(flavor ENVIRONMENT_VAR) value=$(ENVIRONMENT_VAR))
$(info ARGUMENT_VAR1:    origin=$(origin ARGUMENT_VAR1) flavor=$(flavor ARGUMENT_VAR1) value=$(ARGUMENT_VAR1))
$(info It is possible to generate a simple variable/macro from the command line by using of := or ::=)
$(info ARGUMENT_VAR2:    origin=$(origin ARGUMENT_VAR2) flavor=$(flavor ARGUMENT_VAR2) value=$(ARGUMENT_VAR2))
$(info )
$(info MULTILINE_VAR1:   origin=$(origin MULTILINE_VAR1) flavor=$(flavor MULTILINE_VAR1) value='$(MULTILINE_VAR1)')
$(info MULTILINE_VAR2:   origin=$(origin MULTILINE_VAR2) flavor=$(flavor MULTILINE_VAR2) value='$(MULTILINE_VAR2)')
$(info MULTILINE_VAR3:   origin=$(origin MULTILINE_VAR3) flavor=$(flavor MULTILINE_VAR3) value='$(MULTILINE_VAR3)')
$(info )

$(info *** And there are default variables and undefined variables)
$(info RM:    origin=$(origin RM) flavor=$(flavor RM) value=$(RM))
$(info CXX:    origin=$(origin CXX) flavor=$(flavor CXX) value=$(CXX))
$(info CPPFLAGS:    origin=$(origin CPPFLAGS) flavor=$(flavor CPPFLAGS) value=$(CPPFLAGS))
$(info )

$(info *** Automatic variables are defined only in the context of a rule.)
$(info @:    origin=$(origin @) flavor=$(flavor @) value=$(@))
$(info )

$(info *** Adding content to a variable preserves the flavor if the variable exists.)
RECURSIVE_VAR += addendum
SIMPLE_VAR += addendum
ENVIRONMENT_VAR += addendum
ARGUMENT_VAR1 += addendum
$(info RECURSIVE_VAR:   origin=$(origin RECURSIVE_VAR) flavor=$(flavor RECURSIVE_VAR) value=$(RECURSIVE_VAR))
$(info SIMPLE_VAR:      origin=$(origin SIMPLE_VAR) flavor=$(flavor SIMPLE_VAR) value=$(SIMPLE_VAR))
$(info ENVIRONMENT_VAR: origin=$(origin ENVIRONMENT_VAR) flavor=$(flavor ENVIRONMENT_VAR) value=$(ENVIRONMENT_VAR))
$(info )
$(info *** If a variable has been set with a command line argument, then ordinary assignments in the makefile are ignored.)
$(info ARGUMENT_VAR1:   origin=$(origin ARGUMENT_VAR1) flavor=$(flavor ARGUMENT_VAR1) value=$(ARGUMENT_VAR1))
$(info ARGUMENT_VAR2:   origin=$(origin ARGUMENT_VAR2) flavor=$(flavor ARGUMENT_VAR2) value=$(ARGUMENT_VAR2))
$(info )
$(info *** Use the override directive to append/prefix in such a case.)
override ARGUMENT_VAR1 += addendum
$(info ARGUMENT_VAR1:   origin=$(origin ARGUMENT_VAR1) flavor=$(flavor ARGUMENT_VAR1) value=$(ARGUMENT_VAR1))
$(info )
$(info *** The addition of an prefix requires the simple variable flavor.)
$(info *** Otherwise the result is a infinite self reference.)
# override ARGUMENT_VAR1 = prefix $(ARGUMENT_VAR1)
override ARGUMENT_VAR2 := prefix $(ARGUMENT_VAR2)
$(info ARGUMENT_VAR1:    origin=$(origin ARGUMENT_VAR1) flavor=$(flavor ARGUMENT_VAR1) value=$(ARGUMENT_VAR1))
$(info ARGUMENT_VAR2:    origin=$(origin ARGUMENT_VAR2) flavor=$(flavor ARGUMENT_VAR2) value=$(ARGUMENT_VAR2))
$(info )

$(info *** Appending to a non existent variable produces a recursive variable flavor.)
NEW_VAR += addendum
$(info NEW_VAR: origin=$(origin NEW_VAR) flavor=$(flavor NEW_VAR) value=$(NEW_VAR))
$(info )

$(info *** Defining the default value of an variable preserves the flavor if the variable exists,)
$(info *** and produces a recursive variable otherwise.)
RECURSIVE_VAR ?= default
SIMPLE_VAR ?= default
ENVIRONMENT_VAR ?= default
ARGUMENT_VAR1 ?= default
ARGUMENT_VAR2 ?= default
ANOTHER_NEW_VAR ?= default
$(info RECURSIVE_VAR:   origin=$(origin RECURSIVE_VAR) flavor=$(flavor RECURSIVE_VAR) value=$(RECURSIVE_VAR))
$(info SIMPLE_VAR:      origin=$(origin SIMPLE_VAR) flavor=$(flavor SIMPLE_VAR) value=$(SIMPLE_VAR))
$(info ENVIRONMENT_VAR: origin=$(origin ENVIRONMENT_VAR) flavor=$(flavor ENVIRONMENT_VAR) value=$(ENVIRONMENT_VAR))
$(info ARGUMENT_VAR1:    origin=$(origin ARGUMENT_VAR1) flavor=$(flavor ARGUMENT_VAR1) value=$(ARGUMENT_VAR1))
$(info ARGUMENT_VAR2:    origin=$(origin ARGUMENT_VAR2) flavor=$(flavor ARGUMENT_VAR2) value=$(ARGUMENT_VAR2))
$(info ANOTHER_NEW_VAR: origin=$(origin ANOTHER_NEW_VAR) flavor=$(flavor ANOTHER_NEW_VAR) value=$(ANOTHER_NEW_VAR))
$(info )

$(info *** A re-definition of an variable can change the flavor.)
RECURSIVE_VAR := is now simple
SIMPLE_VAR = is now recursive
ENVIRONMENT_VAR := is now simple
override ARGUMENT_VAR1 := is now simple
$(info RECURSIVE_VAR:   origin=$(origin RECURSIVE_VAR) flavor=$(flavor RECURSIVE_VAR) value=$(RECURSIVE_VAR))
$(info SIMPLE_VAR:      origin=$(origin SIMPLE_VAR) flavor=$(flavor SIMPLE_VAR) value=$(SIMPLE_VAR))
$(info ENVIRONMENT_VAR: origin=$(origin ENVIRONMENT_VAR) flavor=$(flavor ENVIRONMENT_VAR) value=$(ENVIRONMENT_VAR))
$(info ARGUMENT_VAR1:    origin=$(origin ARGUMENT_VAR1) flavor=$(flavor ARGUMENT_VAR1) value=$(ARGUMENT_VAR1))
$(info )

$(info *** You can undefine a variable.)
undefine ANOTHER_NEW_VAR
$(info ANOTHER_NEW_VAR: origin=$(origin ANOTHER_NEW_VAR) flavor=$(flavor ANOTHER_NEW_VAR) value=$(ANOTHER_NEW_VAR))
$(info )

$(info *** If we need a variable (macro) to be used in a rule and refers to a automatic variable, we must)
$(info *** use a recursive variable. Recursive variables are expanded during use and thus they are sometimes called macros.)
MACRO_FOR_ECHO = 'Macro for echo in rule: $@'
# The right side of simple variable definition is immediately expanded and this most probably not what you want.
VAR1_FOR_ECHO := 'Variable1 for echo in rule: $@'
# This does not work either.
VAR2_FOR_ECHO := 'Variable2 for echo in rule: $$@'

.PHONY: all
all:
	@echo 'Executing the rule : $@'
	$(info RECURSIVE_VAR:   origin=$(origin RECURSIVE_VAR) flavor=$(flavor RECURSIVE_VAR) value=$(RECURSIVE_VAR))
	$(info SIMPLE_VAR:      origin=$(origin SIMPLE_VAR) flavor=$(flavor SIMPLE_VAR) value=$(SIMPLE_VAR))
	$(info @:    origin=$(origin @) flavor=$(flavor @) value=$(@))
	@echo $(MACRO_FOR_ECHO)
	@echo $(VAR1_FOR_ECHO)
	@echo $(VAR2_FOR_ECHO)
