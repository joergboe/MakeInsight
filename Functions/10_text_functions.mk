# Demonstration of some Text functions

# Usage:
# make -f 10_text_functions.mk

# See: https://www.gnu.org/software/make/manual/html_node/Text-Functions.html

comma:= ,
empty:=
space:= $(empty) $(empty)
spaces:= $(empty)   $(empty)
# NOTE: a single newline variable requires 2 empty lines!
define nl :=


endef

$(info $$(subst from,to,list))
# Performs a textual replacement on the text text: each occurrence of from is replaced by to. The result is substituted
# for the function call.
$(info $(subst ee,EE,feet     on the street))
# NOTE: Whitespaces are preserved.
$(info )
$(info $$(patsubst pattern,replacement,text))
# Finds whitespace-separated words in list that match pattern and replaces them with replacement. Here pattern may
# contain a ‘%’ which acts as a wildcard, matching any number of any characters within a word. If replacement also
# contains a ‘%’, the ‘%’ is replaced by the text that matched the ‘%’ in pattern. Words that do not match the pattern
# are kept without change in the output. Only the first ‘%’ in the pattern and replacement is treated this way; any
# subsequent ‘%’ is unchanged.
# ‘%’ characters in patsubst function invocations can be quoted with preceding backslashes (‘\’).
var1 ::= foo.c.c    bar.c
$(info $(patsubst %.c,%.o,$(var1)))
# Substitution references References) are a simpler way to get the effect of the patsubst function.
# See: https://www.gnu.org/software/make/manual/html_node/Substitution-Refs.html
$(info $$(var:pattern=replacement))
$(info $(var1:%.c=%.o))
# The second shorthand simplifies one of the most common uses of patsubst: replacing the suffix at the end of file names.
$(info $$(var:suffix=replacement))
$(info $(var1:.c=.o))
$(info )
$(info $(patsubst the\%weird\\%pattern\\,\%%%,one two the%weird\firstpattern\\ the%weird\secondpattern\\))
$(info $$(patsubst ab%,AB%,abc abcccc ab%aaa)       = $(patsubst ab%,AB%,abc abcccc ab%aaa))
$(info $$(patsubst ab%,AB,abc abcccc ab%aaa)        = $(patsubst ab%,AB,abc abcccc ab%aaa))
$(info $$(patsubst ab%,AB%%,abc abcccc ab%aaa)      = $(patsubst ab%,AB%%,abc abcccc ab%aaa))
$(info $$(patsubst ab%%,AB%%,abc% abcccc% ab%aaa%)  = $(patsubst ab%%,AB%%,abc% abcccc% ab%aaa%))
$(info $$(patsubst \%ab%,AB%%,%abc %abcccc %ab%aaa) = $(patsubst \%ab%,AB%%,%abc %abcccc %ab%aaa))
$(info )

$(info $$(strip string))
# Function strip: Removes leading and trailing whitespace from string and replaces each internal sequence of one or more
# whitespace characters with a single space.
$(info strip a    b   = '$(strip a      b   )')
$(info strip empty    = '$(strip $(empty))')
$(info strip nl       = '$(strip $(nl))')
$(info strip aaa, bbb = '$(strip aaa, bbb)')
$(info strip aaa$(comma) bbb             = '$(strip aaa$(comma) bbb)')
$(info strip a$$(empty)$$(empty)b          = '$(strip a$(empty)$(empty)b)')
$(info strip a$$(space)$$(space)$$(space)b  = '$(strip a$(space)$(space)$(space)b)')
$(info )

$(info $$(findstring find,in))
# Searches in for an occurrence of find. If it occurs, the value is find; otherwise, the value is empty. You can use
# this function in a conditional to test for the presence of a specific substring in a given string.
$(info $$(findstring a,a b c) = '$(findstring a,a b c)')
$(info $$(findstring a,b c)   = '$(findstring a,b c)')
$(info $$(findstring a,abcdef)= '$(findstring a,abcdef)')
$(info $$(findstring a,)      = '$(findstring a,)')
$(info )

$(info $$(filter pattern…,list))
# Returns all whitespace-separated words in list that do match any of the pattern words, removing any words that do not
# match.
sources := foo.c bar.c baz.s ugh.h
$(info sources = $(filter %.c %.s,$(sources)))
$(info )

$(info $$(filter-out pattern…,list))
# Returns all whitespace-separated words in list that do not match any of the pattern words, removing the words that do
# match one or more.
$(info headers = $(filter-out  %.c %.s,$(sources)))
$(info )

$(info $$(sort list))
# Sorts the words of list in lexical order, removing duplicate words. The output is a list of words separated by single
# spaces
$(info $(sort sort foo bar lose foo))
$(info )

$(info $$(word n,list))
# Returns the nth word of list. The legitimate values of n start from 1. If n is bigger than the number of words in list,
# the value is empty.
numbers = one two three
$(info $(word 2,$(numbers)))
$(info )

$(info $$(wordlist s,e,text))
# Returns the list of words in text starting with word s and ending with word e (inclusive). The legitimate values of s
# start from 1; e may start from 0. If s is bigger than the number of words in text, the value is empty.
# If e is bigger than the number of words in text, words up to the end of text are returned. If s is greater than e,
# nothing is returned. For example,
$(info $(wordlist 2, 3,$(numbers)))
$(info )

$(info $$(words list))
# Returns the number of words in list.
$(info $(words $(numbers)))
$(info $(word $(words $(numbers)),$(numbers)))
$(info )

$(info $$(firstword names…))
# The argument names is regarded as a series of names, separated by whitespace. The value is the first name in the series.
$(info $(firstword $(numbers)))
$(info )

$(info $$(lastword names…))
# The value is the last name in the series.
$(info $(lastword $(numbers)))
$(info )

$(info The number of search pathes in environment PATH = $(words $(subst :, ,$(PATH))))
