# Sort the input list and remove duplicated from the output

# Usage: make -f sort_uniq.mk

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

# Testlists
list1 =
list2 ::= $(space)
list3 = m1
list4 = $(space)m1 m2 m3 m3   #
list5 = . src . src src/m1
list6 = m1 m2 m3 . src . src , src/m$$1 m$$1 , \# src/m$$1
list7 =    111 222     333 , $(space) 444 $(multiline) 555 \#66 \\\#666 7:7 8;8 9*9 a$$a b%b c\c d\\d e(@)e\
f{f g}g h[h i]i jüj kæk l"l m'm
list8 = aa cc bb aa cc dd dd aa cc bb

# Expands to non-empty string if param1 and param2 are not equal or to the empty string otherwise
# call neq,param1,param2
neq = $(or $(subst $2,,$1),$(subst $1,,$2))

# Sort the input list and remove duplicated from the output
# call sort_uniq,list
sort_uniq = $(call sort_uniq_1,$(sort $1),)

# Internal function add a distinct first element to input list
sort_uniq_1 = $(call sort_uniq_2,$(firstword $1)& $1)

# Internal function
sort_uniq_2 = $(let old first rest,$1,$\
	$(if $(call neq,$(first),$(old)),$\
		$(first)\
	)$\
	$(if $(rest),$\
		$(call sort_uniq_2,$(first) $(rest))$\
	)$\
)

$(info ****** sort_uniq)
$(foreach v,1 2 3 4 5 6 7 8,$(info list$(v) = '$(list$(v))'$(nl)sort = '$(call sort_uniq,$(list$(v)))'))

megalist ::= $(shell for ((x=1000;x>0;x--)); do echo -n "xxxxxxxxxxxxxx$${x} cccccccccccccc$${x} aaaaaaaaaaaaaaa$${x} xxxxxxxxxxxxxx$${x} "; done)
$(info megalist = '$(megalist)')
$(info sort_uniq megalist = '$(call sort_uniq,$(megalist))')
$(info words megalist = $(words $(megalist)))
$(info words sorted = $(words $(call sort_uniq,$(megalist))))

target:
