$(info Directories in subdir/subdir3.mk)
$(info CURDIR = $(CURDIR) origin = $(origin CURDIR) flavor = $(flavor CURDIR))
$(info PWD =   $(PWD) origin = $(origin PWD) flavor = $(flavor PWD))
$(info MAKEFILE_LIST = $(MAKEFILE_LIST))
$(info )
$(shell rm -f subdir/target3)

subdir/target3:
	@echo '---- run rule target3 ----'
	echo 'Text from subdir target3' > subdir/target3
