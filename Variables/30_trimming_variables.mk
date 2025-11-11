# Trimming of variables

# try this example with
# > make -f 30_trimming_variables.mk

# During setting of a variable from a makefile:
# Whitespace around the variable name and immediately after the ‘=’ is ignored.
# Leading spaces are trimmed.
# Trailing and embedded spaces are not trimmed.
var0=foo
var1 = foo
var2 =     b a	r     
var3 = baz ss\\s \ \$$ s \\\\\# hashmark must be escaped with 2N+1 backslashes    \
a single dollar sign must be preceded by a dollar $$$$   
var4 = backslashes go unmolested \ \\\$$ s \\\#trailing space is not: trimmed    

$(info $$(var0)='$(var0)')
$(info $$(var1)='$(var1)')
$(info $$(var2)='$(var2)')
$(info $$(var3)='$(var3)')
$(info $$(var4)='$(var4)')

# This is also true for simple variables
svar1 :=    f	o o     # same here
$(info $$(svar1)='$(svar1)')
# The function $(strip text) removes all leading and trailing spaces and replaces embedded whitespaces with a single space.
$(info $$(strip $$(svar1))='$(strip $(svar1))')

# This is also true for immediate variables
ivar1 :::=    f	o o     # same here
$(info $$(ivar1)='$(ivar1)')
# The function $(strip text) removes all leading and trailing spaces and replaces embedded whitespaces with a single space.
$(info $$(strip $$(ivar1))='$(strip $(ivar1))')

# Empty var is expanded to the empty string
empty :=    # all white spaces are trimmed
$(info $$(empty)='$(empty)')

# In case of appending, the spaces are preserved
var5 :=
var5 := $(var5)     foo
$(info $$(var5)='$(var5)')

# But with += syntax, leading spaces are trimmed!
var6 :=
var6 +=     foo
var6 +=     bar      #
var6 += baz   #
$(info $$(var6)='$(var6)')

# This holds true for conditional assignments:
var7 ?=       conditional          #
$(info $$(var7)='$(var7)')

# And for assignments from shell output
# The trailing newline is removed!
var8 !=      echo "1234"
$(info $$(var8)='$(var8)')

# but the spaces from the shell are not removed.
var9 !=      echo "    1234    "
$(info $$(var9)='$(var9)')

PHONY: all
all:
	@echo 'All done'
