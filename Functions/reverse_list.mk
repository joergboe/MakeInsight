# Use Make functions to reverse a list

# Usage: make -f reverse_list.mk

# some required variables
empty ::=
space ::= $(empty) $(empty)
define nl ::=


endef
comma ::= ,

# Reverse a list
# call reverse_list,list
reverse_list = $(let first rest,$1,$(if $(rest),$(call reverse_list,$(rest)) )$(first))

$(info $$(call reverse_list,11 22 33 44 $$(comma)) = '$(call reverse_list,11 22 33 44 $(comma))')

$(info $$(call reverse_list,) = '$(call reverse_list,)')

#$(info $$(call reverse_list, ) = '$(call reverse_list, )')
# # error make 4.4.1
# error: make: *** virtual memory exhausted

$(info $$(call reverse_list,aa) = '$(call reverse_list,aa)')

$(info $$(call reverse_list, aa ) = '$(call reverse_list, aa )')

define multiline ::=
line1
line2
line2

endef

list6 =    111 222	333 , $(space) 444 $(multiline) 555 \#66 \\\#666 7:7 8;8 9*9 a$$a b%b c\c d\\d e(@)e\
f{f g}g h[h i]i jüj kæk l"l m'm f$$1 f$$2
$(info list6 = '$(list6)')
$(info $$(call reverse_list,$$(list6)) = '$(call reverse_list,$(list6))')
# NOTE: Newlines and tabs are replaced by spaces!
$(info )

$(info Pretty format of reverse list yields additional spaces)

# Reverse a list - pretty format
# call pretty_reverse,list
pretty_reverse = $(let first rest,$1,\
	$(if $(rest),\
		$(call pretty_reverse,$(rest))\
	)$(first)\
)

$(info $$(call pretty_reverse,11 22 33 44 $$(comma)) = '$(call pretty_reverse,11 22 33 44 $(comma))')
$(info )

$(info Dollar sign trick removes additional spaces)

# Reverse a list - pretty format with dollar sign trick
# call pretty_reverse,list
pretty_reverse = $(let first rest,$1,$\
	$(if $(rest),$\
		$(call pretty_reverse,$(rest))\
	)$(first)$\
)
# There is no $ after the recursive call with rest. There is a single space needed.

$(info $$(call pretty_reverse,11 22 33 44 $$(comma)) = '$(call pretty_reverse,11 22 33 44 $(comma))')
$(info )


$(info Makefile error workaround - strip the input)

# Reverse a list
# call robust_reverse,list
robust_reverse = $(call pretty_reverse,$(strip $1))

$(info $$(call robust_reverse,11 22 33 44 $$(comma)) = '$(call robust_reverse,11 22 33 44 $(comma))')

$(info $$(call robust_reverse,) = '$(call robust_reverse,)')

$(info $$(call robust_reverse, ) = '$(call robust_reverse, )')

$(info $$(call robust_reverse,aa) = '$(call robust_reverse,aa)')

$(info $$(call robust_reverse, aa ) = '$(call robust_reverse, aa )')

$(info list6 = '$(list6)')
$(info $$(call robust_reverse,$$(list6)) = '$(call robust_reverse,$(list6))')
# NOTE: Newlines and tabs are replaced by spaces!

target:
