# Break down a directory path into components that are needed one after the other to create the directory.

# Usage:
#	make -f directory_break_down.mk
# Cleanup:
#	make -f directory_break_down.mk clean

# From a given directory string
# dir1/dir2/dir3/dir4
#
# create the list
# dir1
# dir1/dir2
# dir1/dir2/dir3
# dir1/dir2/dir3/dir4

# Steps:
# 1. Split a single directory string into list of directory components and remove surplus dots and slashes
# 2. Reverse this list
# 3. Split and remove the first entry recursively
# 4. Reverse the reduced list and build a directory string
# 5. Reverse the result

# Example: given directory dir1/dir2/dir3/dir4
# 1. dir1 dir2 dir3 dir4
# 2. dir4 dir3 dir2 dir1
# 3. dir4      dir3 dir2 dir1  -> 4. dir1/dir2/dir3/dir4
#    dir3      dir2 dir1       -> 4. dir1/dir2/dir3
#    dir2      dir1            -> 4. dir1/dir2
#    dir1                      -> 4. dir1
# 5. dir1  dir1/dir2  dir1/dir2/dir3  dir1/dir2/dir3/dir4


empty ::=
space ::= $(empty) $(empty)
define nl ::=


endef

# Expands to non-empty string if param1 and param2 are not equal or to the empty string otherwise
# call neq,param1,param2
neq = $(or $(subst $2,,$1),$(subst $1,,$2))

# Reverse a list
# call reverse_list,list
# error: make: *** virtual memory exhausted
# in GNU Make 4.4.1 if called with a single space as input
# Prevented with $(strip $1)
reverse_list = $(let first rest,$(strip $1),$(if $(rest),$(call reverse_list,$(rest)) )$(first))

# Split a single directory string into list of directory components.
# Removes surplus slashes and remove single dot components
# call split_reduce_dir directory
split_reduce_dir = $(strip $(foreach comp,$(subst /, ,$1),$(if $(call neq,.,$(comp)),$(comp))))

# Reverse the input list $1 $2 and build a directory string.
# Replace spaces with slash
# call reverse_list_to_dir,last,dirs
reverse_list_to_dir = $(subst $(space),/,$(strip $(call reverse_list,$1 $2)))

# Breakdown reverse and return directory string
# call breakdown_reverse_dir,list
# Prevented bug with $(strip $1) (Remove additional spaces comming from pretty function format)
breakdown_reverse_dir = $(let first rest,$(strip $1),\
  $(call reverse_list_to_dir,$(first),$(rest))\
  $(if $(rest), $(call breakdown_reverse_dir,$(rest))))

# Break down a directory path into components that are needed one after the other to create the directory
# The directory must be a relative directory.
# call directory_break_down1,directory
directory_break_down1 = $(call reverse_list,\
  $(call breakdown_reverse_dir,\
    $(call reverse_list,\
      $(call split_reduce_dir,$1)\
    )\
  )\
)

target = cache/header/part1/part2/file.xx
$(info target = $(target))
dir = $(dir $(target))
$(info dir = $(dir))


$(info reverse_list_to_dir = '$(call reverse_list_to_dir,part2,part1 header cache)')
$(info split_reduce_dir = $(call split_reduce_dir,$(dir)))
$(info reverse_ $(call reverse_list,$(call split_reduce_dir,$(dir))))
$(info breakdown_reverse_dir '$(call breakdown_reverse_dir,$(call reverse_list,$(call split_reduce_dir,$(dir))))')
$(info directory_break_down1 = '$(call directory_break_down1,$(dir))')

# Alternative using a global variable and eval
directory_break_down2 = $(eval temp ::=)\
$(foreach var,$(call split_reduce_dir,$(subst #,\#,$(subst $$,$$$$,$1))),\
  $(if $(temp),\
    $(eval temp += $(var)),\
    $(eval temp ::= $(var))\
  )\
  $(subst $(space),/,$(temp))\
)
# NOTE: Substitution for eval lacks support for combination \#
# NOTE: temp += $(var) produces a space separated list

$(info directory_break_down2 = '$(call directory_break_down2,$(dir))')
$(info temp = $(temp))

$(info **** Tests ****)
test = $(info $1 $2 '$(list$2)' res = '$(call $1,$(list$2))')

lists ::= 1 2 3 4 5 6 7 8 9 10 11 12

list1 ::= $(empty)
list2 ::= $(space)
list3 ::= .
list4 ::= ./
list5 ::= $(space)./$(space)
list6 ::= dir1/dir2/dir3
list7 ::= dir1/dir2/dir3/
list8 ::= dir$$1/dir\\$$2/dir$$3/
list9 ::= dir1/./dir2///dir3/
list10 ::= /dir1/./dir2///dir3/
list11 ::= dir1/./dir2/..//../dir1/dir2//dir3/
list12 ::= dir\#0/dir\\\#00/dir:1/dir;2/dir§3/dirö4/dir*5/dir'6/dir"7/dir(8)/dir{9/dir}10

$(info Test split_reduce_dir)
$(foreach var,$(lists),$(call test,split_reduce_dir,$(var)))

$(info Test directory_break_down1)
$(foreach var,$(lists),$(call test,directory_break_down1,$(var)))

$(info Test directory_break_down2)
$(foreach var,$(lists),$(call test,directory_break_down2,$(var)))

$(target): temp ::=
$(target):
	echo $@
	echo $(dir $@)
	# $(value directory_break_down2)
	# $(origin directory_break_down2)
	# $(call directory_break_down2,$@)
	# $(call directory_break_down1,$@)
	mkdir -v $(call directory_break_down1,$(dir $@))
	touch $@
# NOTE: directory_break_down2 does not work in context of recipe

.PHONY: clean
clean:
	rm -vf $(target)
	# $(call directory_break_down1,$(dir $(target)))
	-rmdir -v $(call reverse_list,$(call directory_break_down1,$(dir $(target))))
