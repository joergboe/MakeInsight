# Special function foreach
# make -f 21_special_functions_foreach.mk

comma ::= ,
empty ::=
space ::= $(empty) $(empty)
tab ::= $(empty)	$(empty)
define multiline ::=
line 1
line 2
endef

$(info -§2- Foreach function - $$(foreach var,list,text))
# The foreach function resembles the for command in the shell sh and the foreach command in the C-shell csh.
# See: https://www.gnu.org/software/make/manual/html_node/Foreach-Function.html

mylist ::= 111 222 333 444 555 666
$(info mylist = $(mylist))
$(info )

# The result is that text is expanded as many times as there are whitespace-separated words in list. The multiple
# expansions of text are concatenated, with spaces between them, to make the result of foreach.
$(info -§2a- Space separators are implicitly added.)
$(info $$(foreach var,$$(mylist),_$$(var)_) = '$(foreach var,$(mylist),_$(var)_)')
$(info )

# Spaces in list are not preserved
# NOTE: comma must be hidden; dollar must be escaped with dollar;
# NOTE: The used function delimiters (parentheses) must be pairs.
#       Braces may appear unpaired in this case.
# NOTE: hash mark is not significant in function body
$(info -§2b- Multiple spaces in input list are not preserved...)
$(info $(foreach var,  111 222     333 $(comma) $(space) 444 $(multiline) 55$(tab)5 #66 \#666 7:7 8;8 9*9 a$$a b%b c\c\
d\\d e(@)e f{f g}g h[h i]i jüj kæk l"l m'm,'$(var)'))
$(info )

# NOTE: Hash-mark must be escaped by a backslash in assignments.  A backslash before a has-mark must be doubled.
# NOTE: Comma, semicolon, colon have no special meaning in assignments
special_chars ::=   111 222     333 , $(space) 444 $(multiline) 55$(tab)5 \#66 \\\#666 7:7 8;8 9*9 a$$a b%b c\c d\\d\
e(@)e f{f g}g h[h i]i jüj kæk l"l m'm
$(info special_chars = '$(special_chars)')
$(info )

$(info -§2c- Tabs and newlines are delimiters like space characters.)
$(info $(foreach var,$(special_chars),'$(var)'))

$(info -§2d- Flavor of variable - simple expanded)
$(foreach var,111 $(comma) 333,$(info type var = $(flavor var) value = $(value var)))

target:
