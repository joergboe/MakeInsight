# Special functions let and foreach
# make -f 20_special_functions.mk

comma:= ,
empty:=
space:= $(empty) $(empty)
spaces:= $(empty)   $(empty)
define nl :=


endef

$(info -§1- The let Function - $$(let var [var ...],[list],text))
# See: https://www.gnu.org/software/make/manual/html_node/Let-Function.html
mylist := 111 222 333 444 555 666
$(info mylist = $(mylist))
$(info -§1a- Assign mylist to var1, var2 and rest =\
$(let var1 var2 rest,$(mylist),var1 = $(var1) var2 = $(var2) rest = $(rest)))
$(info -§1b- Iterate recursively through a list =\
$(let first rest,$(mylist),$(first) $(let first rest,$(rest),$(first) ...)))
$(info -§1c- Type of local variables is simple expanded)
$(let v1 v2,aa bb cc,$(info type v1 = $(flavor v1) type v2 = $(flavor v2)))
$(info -§1d- Variables v1, v2 and v3 are stripped but spaces in rest are are preserved! =\
$(let v1 v2 v3 rest,   111   222	333    444   555	666   ,'$(v1)' '$(v2)' '$(v3)' '$(rest)'))

$(info -§1e- Empty list yields empty vars $(let v1 v2 rest,$(empty),'$(var1)' '$(var2)' '$(rest)'))
# Error in GNU Make 4.4.1: make: *** virtual memory exhausted
#$(info -§1f- Spaces in list $(let v1 rest, ,'$(v1)' '$(rest)'))
$(info )

$(info -§2- Use let to reverse a list)
reverse_list = $(let first rest,$(1),$(if $(rest),$(call reverse_list,$(rest)) )$(first))
$(info $$(call reverse_list,11 22 33 44 $$(comma)) = '$(call reverse_list,11 22 33 44 $(comma))')
$(info -§2a- Pretty reverse list yields additional spaces)
pretty_reverse = $(let first rest,$(1),\
		$(if $(rest),\
			$(call pretty_reverse,$(rest))\
		)$(first)\
)
$(info $$(call pretty_reverse,11 22 33 44 $$(comma)) = '$(call pretty_reverse,11 22 33 44 $(comma))')
$(info )


$(info -§3- Foreach function - $$(foreach var,list,text))
# The foreach function resembles the for command in the shell sh and the foreach command in the C-shell csh.
# See: https://www.gnu.org/software/make/manual/html_node/Foreach-Function.html
# The result is that text is expanded as many times as there are whitespace-separated words in list. The multiple
# expansions of text are concatenated, with spaces between them, to make the result of foreach.
$(info $$(foreach var,$$(mylist),_$$(var)_) = '$(foreach var,$(mylist),_$(var)_)')
# NOTE: The space is implicitly added!

# Spaces in list are not preserved
# NOTE: comma must be hidden; dollar must be escaped with dollar;
# NOTE: The used function delimiters (parentheses) must be pairs.
#       Braces may appear unpaired in this case.
# NOTE: hash mark is not significant in function body
$(info -§3a- $(foreach var,  111 222     333 $(comma) $(space) 444 $(multiline) 555 #66 \#666 7:7 8;8 9*9 a$$a b%b c\c\
d\\d e(@)e f{f g}g h[h i]i jüj kæk l"l m'm,'$(var)'))

# NOTE: Hash-mark must be escaped by a backslash in assignments.  A backslash before a has-mark must be doubled.
# NOTE: Comma, semicolon, colon have no special meaning in assignments
special_chars :=   111 222     333 , $(space) 444 $(multiline) 555 \#66 \\\#666 7:7 8;8 9*9 a$$a b%b c\c d\\d e(@)e\
f{f g}g h[h i]i jüj kæk l"l m'm
$(info -§3b- $(foreach var,$(special_chars),'$(var)'))

# Type of variable - simple expanded
$(info -§3c-)
$(foreach var,111 $(comma) 333,$(info type var = $(flavor var) value = $(value var)))

target:
