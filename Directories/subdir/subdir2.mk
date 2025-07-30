$(info Directories in subdir/subdir2.mk)
$(info CURDIR = $(CURDIR) origin = $(origin CURDIR) flavor = $(flavor CURDIR))
$(info PWD =   $(PWD) origin = $(origin PWD) flavor = $(flavor PWD))
$(info MAKEFILE_LIST = $(MAKEFILE_LIST))
$(info )
$(shell rm -f target2)

target2:
	@echo '---- run rule target2 ----'
	echo 'Text from subdir target2' > target2
