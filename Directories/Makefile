# Show directories of make

$(info CURDIR=$(CURDIR) origin=$(origin CURDIR) flavor=$(flavor CURDIR))
$(info PWD=   $(PWD) origin=$(origin PWD) flavor=$(flavor PWD))
$(info MAKEFILE_LIST = $(MAKEFILE_LIST))
$(info )
$(shell rm -f maintarget subdir/target1 subdir/target2 subdir/target3)

maintarget: subdir/target1 subdir/target2 subdir/target2 subdir/target3
	@echo '---- rule maintarget ----'
	cat subdir/target2 subdir/target2 subdir/target3 > maintarget
	cat maintarget

subdir/target1:
	@echo '---- rule subdir/target ----'
	$(MAKE) -C subdir

subdir/target2:
	@echo '---- rule subdir/target2 ----'
	$(MAKE) -C subdir -f subdir2.mk

subdir/target3:
	@echo '---- rule subdir/target3 ----'
	$(MAKE) -f subdir/subdir3.mk
