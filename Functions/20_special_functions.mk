# demon function
# make -f 20_special_functions.mk

comma:= ,
empty:=
space:= $(empty) $(empty)
spaces:= $(empty)   $(empty)
define nl :=


endef

$(info $$(call variable,param,param,…))
# The call function is unique in that it can be used to create new parameterized functions. You can write a complex
# expression as the value of a variable, then use call to expand it with different values.
# See: https://www.gnu.org/software/make/manual/html_node/Call-Function.html

reverse = $(2) $(1)
$(info $$(call reverse,11,22) = $(call reverse,11,22)$(nl))

$(info parameter)
# Caution: be careful when adding whitespace to the arguments to call. As with other functions, any whitespace contained
# in the second and subsequent arguments is kept; this can cause strange effects
# It’s generally safest to remove all extraneous whitespace when providing parameters to call. 
print_param = '$(1)' '$(2)' '$(3)'

$(info $$(call print_param , a , b    , c  ) = $(call print_param , a , b    , c  ))
$(info $$(call print_param,\na,\n    b) = $(call print_param,\
a,\
    b))
pb = b
pc = c
$(info $$(call print_param, , $(pb) , $(pc) ) = $(call print_param, , $(pb) , $(pc) ))
$(info $$(call print_param,\n,\n$$(pb),\n$$(pc)\n) = $(call print_param,\
,$(pb),\
$(pc)\
))
# Hide a comma in a variable
$(info $$(call print_param,$$(comma),b) = $(call print_param,$(comma),b))
# Can use multiline variables - The newline is hidden
define multiline
line 1
line 2
endef
$(info $$(call print_param,a,b$$(multiline)b,   c) = $(call print_param,a,b$(multiline)b,   c))

# paranteses must be a matched pair
$(info $$(call print_param,x(x)x,y(y)y, ) = $(call print_param,x(x)x,y(y)y, ))
# braces may be unmatched
$(info $$(call print_param,x{xx,yy}y, ) = $(call print_param,x{xx,yy}y, ))
# or use braces - paranteses may be unmatches
${info $${call print_param,x(xx,yyy, } = ${call print_param,x(xx,yyy, }}

# NOTE: If a function expands to the empty string, one can use a function in makefile
print = $(info '$1') $(info '$2')
$(call print,aa,bb)
# NOTE: Paramaeter 0 is the Function/Macro/Variable name
print = $(info '$0' '$1' '$2')
$(call print,aa,bb)

# Type of parameter variable is simlple expanded variable
type_info = $(info type $$1 = $(flavor 1) type $$2 = $(flavor 2) type $$3 = $(flavor 3)\
$(info value $$1 = '$(value 1)' value $$2 = '$(value 2)' value $$3 = '$(value 3)'))
$(call type_info,a,$(comma))

# NOTE: Assignements are not possible in functions.
define assignement
$(info $0)
VAR = $1
$(info end)
endef
#$(call assignement,1234)  # *** missing separator.  Stop.

# Must use eval in such cases
$(eval $(call assignement,1234))
$(info VAR=$(VAR))


$(info )
$(info $$(let var [var ...],[list],text))
# See: https://www.gnu.org/software/make/manual/html_node/Let-Function.html
mylist := 111 222 333 444 555 666
$(info $(let var rest,$(mylist),var = $(var) rest = $(rest)))
# Iterate recursively through a list
$(info $(let var rest,$(mylist),$(var) $(let var rest,$(rest),$(var) )))
# Spaces are not preserved
$(info $(let v1 v2 v3 v4 v5 v6,   111 222 333    444 555 666   ,$(v1) $(v2) $(v3) $(v4) $(v5) $(v6)))
$(info )

$(info reverse list)
reverse_list = $(let first rest,$(1),$(if $(rest),$(call reverse_list,$(rest)) )$(first))
$(info $(call reverse_list,11 22 33 44))
$(info pretty reverse list)
# Formatting may result in additional spaces
pretty_reverse = $(let first rest,$(1),\
		$(if $(rest),\
			$(call pretty_reverse,$(rest))\
		)$(first)\
)
$(info $(call pretty_reverse,11 22 33 44))
$(info )

# Type of variables - simple expanded
$(let v1 v2,aa bb cc,$(info type v1 = $(flavor v1) type v2 = $(flavor v2)))

$(info $$(foreach var,list,text))
# The foreach function resembles the for command in the shell sh and the foreach command in the C-shell csh.
# See: https://www.gnu.org/software/make/manual/html_node/Foreach-Function.html
$(info $(foreach var,$(mylist),_$(var)_))

# spaces are not preserved
# NOTE: comma must be hidden; dollar must be escaped with dollar; paranteses must be pairs
# NOTE: hashmark is not significant
$(info $(foreach var,  111 222     333 $(comma) $(space) 444 $(multiline) 555 #66 \#666 7:7 8;8 9*9 a$$a b%b c\c d\\d e(@)e f{f g}g h[h i]i jüj kæk l"l m'm,'$(var)'))

# NOTE: hashmark must be escaped by a backslash; A backslash befor a hasmark must be doubled.
special_cars :=   111 222     333 , $(space) 444 $(multiline) 555 \#66 \\\#666 7:7 8;8 9*9 a$$a b%b c\c d\\d e(@)e f{f g}g h[h i]i jüj kæk l"l m'm
$(info $(foreach var,$(special_cars),'$(var)'))

# Type of variable - simple expanded
$(foreach var,111 $(comma) 333,$(info type var = $(flavor var) value = $(value var)))

$(info END)
