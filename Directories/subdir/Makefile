$(info Directories in subdir/Makefile)
$(info CURDIR = $(CURDIR) origin = $(origin CURDIR) flavor = $(flavor CURDIR))
$(info PWD =   $(PWD) origin = $(origin PWD) flavor = $(flavor PWD))
$(info MAKEFILE_LIST = $(MAKEFILE_LIST))
$(info )
$(shell rm -f subdir/target1)

target1:
	@echo '---- run rule target1 ----'
	echo 'Text from subdir target1' > target1
