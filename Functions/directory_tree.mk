
print_list = $(foreach item,$1,$(info '$(item)'))

builddirs = build build/sub/sub/sub build/sub/sub/sub/src build/sub/sub/sub/.. build/sub/sub/sub/../.. build/sub/sub/sub/../../src/inc build/sub/sub/sub/../../src/include
$(info builddirs =)
$(call print_list,$(builddirs))
$(info )
resolved ::= $(abspath $(builddirs))
$(info resolved =)
$(call print_list,$(resolved))
$(info )
resolved_rel ::= $(patsubst $(CURDIR)/%,%,$(resolved))
$(info resolved_rel =)
$(call print_list,$(resolved_rel))
$(info )

empty =
space = $(empty) $(empty)
$(info dir '' = '$(dir $(empty))')
$(info dir ' ' = '$(dir $(space))')
$(info dir 'dir/file' = '$(dir dir/file)')
$(info dir 'dir/' = '$(dir dir/)')
$(info dir 'dir' = '$(dir dir)')
$(info dir '.' = '$(dir .)')
$(info dir './' = '$(dir ./)')
$(info dir '..' = '$(dir ..)')
$(info dir '../' = '$(dir ../)')
$(info dir '/usr' = '$(dir /usr)')
$(info dir '/' = '$(dir /)')
$(info dir '//' = '$(dir //)')
$(info )

# all_dirs - expands to the list of all (parent) directories of a path including the last slash
# If path does not end with /, the last component is considered a file object.
# usage: $(call parent_dirs,path)
all_dirs = $(let dd,$(dir $1),$\
  $(if $(subst ./,,$(dd)),$\
    $(dd) $(call all_dirs,$(patsubst %/,%,$(dd)))$\
  )$\
)

print_all_dirs = $(foreach path,$1,\
  $(info path = '$(path)/')\
  $(info $(call all_dirs,$(path)))\
)

$(info resolved_rel : all_dirs =)
$(call print_all_dirs,$(resolved_rel))
$(info resolved : all_dirs =)
$(call print_all_dirs,$(resolved))
$(info other : all_dirs =)
$(call print_all_dirs,$(space) $(empty) : /usr / . .. ./ ../../)
$(info )

# Reverse a list
# call reverse_list,list
reverse_list = $(let first rest,$1,$(if $(rest),$(call reverse_list,$(rest)) )$(first))

objects ::= $(word 2,$(builddirs))/obj1 $(word 3,$(builddirs))/obj2 $(word 4,$(builddirs))/obj3 $(word 5,$(builddirs))/obj4 $(word 6,$(builddirs))/obj5 $(word 7,$(builddirs))/obj6

build/target : $(objects) | build ; touch $@

build/target2 : $(call reverse_list,$(objects)) | build ; touch $@

$(word 2,$(builddirs))/obj1 : | $(word 2,$(builddirs)) ; touch $@
$(word 3,$(builddirs))/obj2 : | $(word 3,$(builddirs)) ; touch $@
$(word 4,$(builddirs))/obj3 : | $(word 4,$(builddirs)) ; touch $@
$(word 5,$(builddirs))/obj4 : | $(word 5,$(builddirs)) ; touch $@
$(word 6,$(builddirs))/obj5 : | $(word 6,$(builddirs)) ; touch $@
$(word 7,$(builddirs))/obj6 : | $(word 7,$(builddirs)) ; touch $@

.SECONDEXPANSION :

all_build_dirs ::= $(patsubst %/,%,$(sort $(foreach dd,$(builddirs),$(call all_dirs,$(dd)/))))
$(info all_build_dirs)
$(info $(all_build_dirs))
$(info )

$(all_build_dirs) : % : | $$(@D)
	-mkdir -v $@

.PHONY : clean
clean :
	rm -rfv build
