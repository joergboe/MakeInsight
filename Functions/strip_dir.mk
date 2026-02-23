# Demonstration:
# Remove surplus slashes and remove single dot components from a directory string
# Ensure directory end

# Usage: make -f strip_dir.mk

# Expands to non-empty string if param1 and param2 are not equal or to the empty string otherwise
# call neq,param1,param2
neq = $(or $(subst $2,,$1),$(subst $1,,$2))

# Split a single directory string into list of directory components.
# Removes surplus slashes and remove single dot components
# call split_reduce_dir directory
split_reduce_dir = $(strip $(foreach d,$(subst /, ,$1),$(if $(call neq,.,$(d)),$(d))))

# Appends all list elements as dir components recursively.
# List must not be empty!
# call append_dir list
append_dir = $(let dn rest,$1,/$(dn)$(if $(rest),$(call append_dir,$(rest))))

# Creates a relative directory string from a list of elements.
# Returns a single dot if the list is empty.
# call make_rel_dir list
make_rel_dir = $(if $1,$(let d1 rest,$1,$(d1)$(if $(rest),$(call append_dir,$(rest)))),.)

# Creates an absolute directory string from a list of elements.
# Returns a single slash if the list is empty.
# call make_abs_dir list
make_abs_dir = /$(if $1,$(let d1 rest,$1,$(d1)$(if $(rest),$(call append_dir,$(rest)))))

# Remove surplus slashes and remove single dot components from a single directory.
# call strip_dir directory
strip_dir = $(if $(filter /%,$1),$\
	$(call make_abs_dir,$(call split_reduce_dir,$1))$\
,$\
	$(call make_rel_dir,$(call split_reduce_dir,$1))$\
)

list = file file%1 file\#1 . ./ .//. src/ ./src//pa*rt1 ../srcabs(1)/ ./../srcabs{2// ../MakeSnippets/// /opt//xxx \
	//.//./. /
$(info list = $(list))

$(info ****** split_reduce_dir)
$(foreach directory,$(list),$(info $(directory) = '$(call split_reduce_dir,$(directory))'))

$(info $$(call split_reduce_dir, ) = '$(call split_reduce_dir, )')

$(info ****** strip_dir)
$(foreach directory,$(list),$(info $(directory) = '$(call strip_dir,$(directory))'))

$(info $$(call strip_dir,) = '$(call strip_dir,)')
$(info $$(call strip_dir, ) = '$(call strip_dir, )')
$(info $$(call strip_dir,/ ) = '$(call strip_dir,/ )')

# Make sure the string ends with a forward slash.
# call ensure_dir_end dir_list
ensure_dir_end = $(foreach var,$1,$(if $(filter %/,$(var)),$(var),$(var)/))

empty :=
space := $(empty) $(empty)
list1 =
list1a = $(space)
list2 = m1
list3 = m1 m2 m3 m3
list4 = . src . src src/m1
list5 = m1 m2 m3 . src . src src/m1 m1

$(info ****** ensure_dir_end)
$(info list1 = '$(list1)' ensure_dir_end = '$(call ensure_dir_end,$(list1))')

$(info list1a = '$(list1a)' ensure_dir_end = '$(call ensure_dir_end,$(list1a))')

$(info list2 = '$(list2)' ensure_dir_end = '$(call ensure_dir_end,$(list2))')

$(info list3 = '$(list3)' ensure_dir_end = '$(call ensure_dir_end,$(list3))')

$(info list4 = '$(list4)' ensure_dir_end = '$(call ensure_dir_end,$(list4))')

target:
