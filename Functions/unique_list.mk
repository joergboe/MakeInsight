# Demonstration Uniq List

# Usage:make -f unique_list.mk

# Return the list with duplicates removed
# To avoid the virtual memory exhausted error in GNU make 4.4.1, the input is stripped
# call uniq_list list
uniq_list = $(call uniq_list_,$(strip $1))

# Internal function called from uniq_list
uniq_list_ = $(let first rest,$1,$\
	$(first)$\
	$(if $(rest),\
		$(call uniq_list_,$(filter-out $(first),$(rest)))$\
	)$\
)
# Before the recursive call of uniq_list_ is a space required so there is no dollar sign at the end of line 3

# some required variables
empty ::=
space ::= $(empty) $(empty)
define nl ::=


endef
define multiline ::=
line1
line2
line2

endef

list1 =
list1a ::= $(space)
list2 = m1
list3 = m1 m2 m3 m3   #
list4 = . src . src src/m1
list5 = m1 m2 m3 . src . src , src/m$$1 m$$1 , \# src/m$$1
list6 =    111 222     333 , $(space) 444 $(multiline) 555 \#66 \\\#666 7:7 8;8 9*9 a$$a b%b c\c d\\d e(@)e\
f{f g}g h[h i]i jüj kæk l"l m'm

$(info ****** uniq_list)
$(info list1 = '$(list1)')
$(info uniq  = '$(call uniq_list,$(list1))')

$(info list1a = '$(list1a)')
$(info uniq   = '$(call uniq_list,$(list1a))')
# error make 4.4.1
# error: make: *** virtual memory exhausted

$(info list2 = '$(list2)')
$(info uniq  = '$(call uniq_list,$(list2))')

$(info list3 = '$(list3)')
$(info uniq  = '$(call uniq_list,$(list3))')

$(info list4 = '$(list4)')
$(info uniq  = '$(call uniq_list,$(list4))')

$(info list5 = '$(list5)')
$(info uniq  = '$(call uniq_list,$(list5))')

$(info list6 = '$(list6)')
$(info uniq  = '$(call uniq_list,$(list6))')


$(info ****** uniq_list by shell)

# Return the list with duplicates removed
# Use sort -u command
# call uniq list,input_name
uniq = $(shell echo "$${$1}" | sort -u)

# Prepare a make list for sort command
# call prepare_list_for_sort,list
prepare_list_for_sort = $(subst $(space),$(nl),$(strip $1))

$(info list1 = '$(list1)')
# NOTE: use simple variables only, recursively expanded variables are exported late!
export list1_ ::= $(call prepare_list_for_sort,$(list1))
$(info uniq  = '$(call uniq,list1_)')

$(info list1a = '$(list1a)')
export list1a_ ::= $(call prepare_list_for_sort,$(list1a))
$(info uniq   = '$(call uniq,list1a_)')

$(info list2 = '$(list2)')
export list2_ ::= $(call prepare_list_for_sort,$(list2))
$(info $(value list2))
$(info uniq  = '$(call uniq,list2_)')

$(info list3 = '$(list3)')
export list3_ ::= $(call prepare_list_for_sort,$(list3))
$(info uniq  = '$(call uniq,list3_)')

$(info list4 = '$(list4)')
export list4_ ::= $(call prepare_list_for_sort,$(list4))
$(info uniq  = '$(call uniq,list4_)')

$(info list5 = '$(list5)')
export list5_ ::= $(call prepare_list_for_sort,$(list5))
$(info uniq  = '$(call uniq,list5_)')

$(info list6 = '$(list6)')
export list6_ ::= $(call prepare_list_for_sort,$(list6))
$(info uniq  = '$(call uniq,list6_)')

$(info ****** uniq_list by shell #2)

# Return the list with duplicates removed
# Use sort -u command
# call uniq list,filename
uniq = $(file > $2,$(subst $(space),$(nl),$(strip $1)))$(shell sort -u $2)

$(info list1 = '$(list1)')
$(info uniq  = '$(call uniq,$(list1),list1)')

$(info list1a = '$(list1a)')
$(info uniq   = '$(call uniq,$(list1a),list1a)')

$(info list2 = '$(list2)')
$(info uniq  = '$(call uniq,$(list2),list2)')

$(info list3 = '$(list3)')
$(info uniq  = '$(call uniq,$(list3),list3)')

$(info list4 = '$(list4)')
$(info uniq  = '$(call uniq,$(list4),list4)')

$(info list5 = '$(list5)')
$(info uniq  = '$(call uniq,$(list5),list5)')

$(info list6 = '$(list6)')
$(info uniq  = '$(call uniq,$(list6),list6)')

target:
	rm list*
