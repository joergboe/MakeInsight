$(info )
$(info Directories in subdir/Makefile)
$(info CURDIR = $(CURDIR) origin = $(origin CURDIR) flavor = $(flavor CURDIR))
$(info PWD    = $(PWD) origin = $(origin PWD) flavor = $(flavor PWD))
$(info MAKEFILE_LIST = $(MAKEFILE_LIST))
$(info shell pwd = $(shell pwd))
$(info echo PWD  = $(shell echo $$PWD))
$(info )

target1:
	@echo '---- run rule target1 ----'
	command pwd
	echo $$PWD
	echo "CURDIR='$${CURDIR}'"
