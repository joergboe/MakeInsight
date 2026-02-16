# Demonstration of some Text functions

# Usage:
# make -f 10_text_functions.mk

# Define variables to hide special characters in function calls
comma:= ,
empty:=
space:= $(empty) $(empty)

spaces:= $(empty)   $(empty)
# NOTE: a single newline variable requires 2 empty lines!
define nl :=


endef

# See: https://www.gnu.org/software/make/manual/html_node/Text-Functions.html


$(info -§1- Text substitution - $$(subst from,to,text))
# Performs a textual replacement on the text: each occurrence of from is replaced by to. The result is substituted
# for the function call.
# NOTE: Whitespaces in text are preserved.
$(info -§1a- $(subst ee,EE,feet     on the street))

# NOTE: No pattern applied
$(info -§1b- $(subst ee,E%,feet     on the street))
$(info -§1b- $(subst %ee,%EE,f%eet     on the str%eet))

# NOTE: Hide intial whitespace in the first argument.
$(info -§1c- $$(subst $$(space),:,/bin /usr/bin /usr/local/bin) = $(subst $(space),:,/bin /usr/bin /usr/local/bin))

foo := a:b:c
$(info foo = $(foo))
# Preceding whitespace is removed
bar := $(subst  :,$(comma),$(foo))
$(info -§1d- bar is now '$(bar)')

# Trailing whitespace in argument 1 is preserved
bar := $(subst : ,$(comma) ,$(foo) )
$(info -§1e- bar is now '$(bar)')

# Whitespace in subsequent arguments is preserved
bar := $(subst :, $(comma) , $(foo) )
$(info -§1f- bar is now '$(bar)')

$(info )
$(info $$(patsubst pattern,replacement,text))
# Finds whitespace-separated words in list that match pattern and replaces them with replacement. Here pattern may
# contain a ‘%’ which acts as a wildcard, matching any number of any characters within a word. If replacement also
# contains a ‘%’, the ‘%’ is replaced by the text that matched the ‘%’ in pattern. Words that do not match the pattern
# are kept without change in the output. Only the first ‘%’ in the pattern and replacement is treated this way; any
# subsequent ‘%’ is unchanged.
# ‘%’ characters in patsubst function invocations can be quoted with preceding backslashes (‘\’).
var1 ::= foo.c.c    bar.c
$(info var1 = $(var1))
$(info -§3a- $(patsubst %.c,%.o,$(var1)))
# Substitution references References) are a simpler way to get the effect of the patsubst function.
# See: https://www.gnu.org/software/make/manual/html_node/Substitution-Refs.html
$(info -§3b- shorthand 1 $$(var:pattern=replacement))
$(info -     $(var1:%.c=%.o))
# The second shorthand simplifies one of the most common uses of patsubst: replacing the suffix at the end of file names.
$(info -§3c- shorthand 2 $$(var:suffix=replacement))
$(info -     $(var1:.c=.o))
$(info -§3d- )
$(info $(patsubst the\%weird\\%pattern\\,\%%%,one two the%weird\firstpattern\\ the%weird\secondpattern\\))
$(info $$(patsubst ab%,AB%,abc abcccc ab%aaa)       = $(patsubst ab%,AB%,abc abcccc ab%aaa))
$(info $$(patsubst ab%,AB,abc abcccc ab%aaa)        = $(patsubst ab%,AB,abc abcccc ab%aaa))
$(info $$(patsubst ab%,AB%%,abc abcccc ab%aaa)      = $(patsubst ab%,AB%%,abc abcccc ab%aaa))
$(info $$(patsubst ab%%,AB%%,abc% abcccc% ab%aaa%)  = $(patsubst ab%%,AB%%,abc% abcccc% ab%aaa%))
$(info $$(patsubst \%ab%,AB%%,%abc %abcccc %ab%aaa) = $(patsubst \%ab%,AB%%,%abc %abcccc %ab%aaa))
$(info )

$(info -§4- Strip function - $$(strip string))
# Function strip: Removes leading and trailing whitespace from string and replaces each internal sequence of one or more
# whitespace characters with a single space.
$(info $$(strip a    b   ) = '$(strip a      b   )')
$(info $$(strip $$(space)) = '$(strip $(space))')
$(info $$(strip $$(empty)) = '$(strip $(empty))')
$(info $$(strip $$(nl))    = '$(strip $(nl))')
# Subsequent commas have no special meaning
$(info $$(strip aaa, bbb)  = '$(strip aaa, bbb)')
$(info $$(strip aaa$$(comma) bbb)  = '$(strip aaa$(comma) bbb)')
$(info $$(strip a$$(empty)$$(empty)b)    = '$(strip a$(empty)$(empty)b)')
$(info $$(strip a$$(space)$$(space)$$(space)b) = '$(strip a$(space)$(space)$(space)b)')
$(info )

$(info -§5- Findstring - $$(findstring find,in))
# Searches in for an occurrence of find. If it occurs, the value is find; otherwise, the value is empty. You can use
# this function in a conditional to test for the presence of a specific substring in a given string.
$(info $$(findstring a,a b c)   = '$(findstring a,a b c)')
$(info $$(findstring a,a b c a) = '$(findstring a,a b c a)')
$(info $$(findstring a,b c)   = '$(findstring a,b c)')
$(info $$(findstring a,abcdef)= '$(findstring a,abcdef)')
$(info $$(findstring a,)      = '$(findstring a,)')
$(info -§5a- One match only $$(findstring a,a b c a) = '$(findstring a,a b c a)')
$(info -§5b- No pattern match $$(findstring a%,abc dd) = '$(findstring a%,abc dd)')
$(info -§5b- No pattern match $$(findstring a%,a%bc add) = '$(findstring a%,a%bc add)')

$(info )

$(info -§6- Filter - $$(filter pattern…,list))
# Returns all whitespace-separated words in list that do match any of the pattern words, removing any words that do not
# match.
sources := foo.c bar.c baz.s ugh.h
$(info sources = $(sources))
$(info $$(filter %.c %.s,$$(sources)) = '$(filter %.c %.s,$(sources))')
$(info )
# complete match required
modules := mod mod1 module
$(info modules = $(modules))
$(info -§6a- complete match required $$(filter mod,$$(modules)) = '$(filter mod,$(modules))')
$(info -§6a- complete match required $$(filter mod%,$$(modules)) = '$(filter mod%,$(modules))')
$(info )

$(info -§7- Filter out - $$(filter-out pattern…,list))
# Returns all whitespace-separated words in list that do not match any of the pattern words, removing the words that do
# match one or more.
$(info $$(filter-out  %.c %.s,$$(sources)) = '$(filter-out  %.c %.s,$(sources))')
$(info )

$(info -§8- Sort $$(sort list))
# Sorts the words of list in lexical order, removing duplicate words. The output is a list of words separated by single
# spaces
$(info $$(sort sort foo bar lose foo) = '$(sort sort foo bar lose foo)')
$(info )

$(info -§9- nth word - $$(word n,list))
# Returns the nth word of list. The legitimate values of n start from 1. If n is bigger than the number of words in list,
# the value is empty.
numbers = one two three
$(info $$(word 2,$(numbers)) = '$(word 2,$(numbers))')
$(info )

$(info -§10- Wordlist - $$(wordlist s,e,text))
# Returns the list of words in text starting with word s and ending with word e (inclusive). The legitimate values of s
# start from 1; e may start from 0. If s is bigger than the number of words in text, the value is empty.
# If e is bigger than the number of words in text, words up to the end of text are returned. If s is greater than e,
# nothing is returned.
$(info $$(wordlist 2, 3,$(numbers)) = '$(wordlist 2, 3,$(numbers))')
$(info )

$(info -§11- Words - $$(words list))
# Returns the number of words in list.
$(info $$(words $$(numbers)) = '$(words $(numbers))')
$(info $$(word $$(words $$(numbers)),$$(numbers)) = '$(word $(words $(numbers)),$(numbers))')
$(info )

$(info -§12- First word - $$(firstword names…))
# The argument names is regarded as a series of names, separated by whitespace. The value is the first name in the series.
$(info $$(firstword $$(numbers)) = '$(firstword $(numbers))')
$(info )

$(info -§13- Last word - $$(lastword names…))
# The value is the last name in the series.
$(info $$(lastword $$(numbers)) = '$(lastword $(numbers))')
$(info )

$(info The number of search pathes in environment PATH = $(words $(subst :, ,$(PATH))))

target:
