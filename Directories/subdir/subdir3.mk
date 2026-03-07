$(info )
$(info Directories in subdir/subdir3.mk)
$(info CURDIR = $(CURDIR) origin = $(origin CURDIR) flavor = $(flavor CURDIR))
$(info PWD    = $(PWD) origin = $(origin PWD) flavor = $(flavor PWD))
$(info MAKEFILE_LIST = $(MAKEFILE_LIST))
$(info shell pwd = $(shell pwd))
$(info echo PWD  = $(shell echo $$PWD))
$(info )

subdir/target3:
	@echo '---- run rule target3 ----'
	command pwd
	echo $$PWD
