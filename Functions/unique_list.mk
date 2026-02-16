# Return the list with duplicates removed
# call unique_list list
unique_list = $(let first rest,$1,$(first)$(if $(rest), $(call unique_list,$(filter-out $(first),$(rest)))))

empty :=
space := $(empty) $(empty)
list1 =
list1a := $(space)
list2 = m1
list3 = m1 m2 m3 m3
list4 = . src . src src/m1
list5 = m1 m2 m3 . src . src , src/m1 m1 , \#

$(info ****** unique_list)
$(info list1 = '$(list1)')
$(info list1 = '$(call unique_list,$(list1))')

$(info list1a = '$(list1a)')
#$(info list1a = '$(call unique_list,$(list1a))')
# error make 4.4.1
# error: make: *** virtual memory exhausted

$(info list2 = '$(list2)')
$(info list2 = '$(call unique_list,$(list2))')

$(info list3 = '$(list3)')
$(info list3 = '$(call unique_list,$(list3))')

$(info list4 = '$(list4)')
$(info list4 = '$(call unique_list,$(list4))')

$(info list5 = '$(list5)')
$(info list5 = '$(call unique_list,$(list5))')

define nl :=


endef

$(info ****** unique_list by shell)
uniq = $(shell echo $(foreach var,$1,'$(var)$(nl)') | uniq -u)

$(info list1 = '$(list1)')
$(info list1 = '$(call uniq,$(list1))')

$(info list1a = '$(list1a)')
$(info list1a = '$(call uniq,$(list1a))')

$(info list2 = '$(list2)')
$(info list2 = '$(call uniq,$(list2))')

$(info list3 = '$(list3)')
$(info list3 = '$(call uniq,$(list3))')

$(info list4 = '$(list4)')
$(info list4 = '$(shell echo '$(list4)' \| uniq -u)')

$(info list5 = '$(list5)')
$(info list5 = '$(call uniq,$(list5))')

target:
