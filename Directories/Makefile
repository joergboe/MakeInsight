# Show directories of make in case of recursive usage of make

# see: https://www.gnu.org/software/make/manual/html_node/Recursion.html#index-CURDIR

# For your convenience, when make starts, after it has processed any -C options, it sets the variable CURDIR to the
# pathname of the current working directory.
# NOTE that setting this variable has no impact on the operation of make it does not cause make to change its working
# directory.

# Use CURDIR to get the current directory.
# Variable PWD in make context may differ.
# Shells started from make have the correct PWD set.

$(info )
$(info CURDIR=$(CURDIR) origin=$(origin CURDIR) flavor=$(flavor CURDIR))
$(info PWD=   $(PWD) origin=$(origin PWD) flavor=$(flavor PWD))
$(info MAKEFILE_LIST = $(MAKEFILE_LIST))
$(info )

maintarget: subdir/target1 subdir/target2 subdir/target2 subdir/target3
	@echo '---- rule maintarget ----'

subdir/target1:
	@echo '---- rule subdir/target1 ----'
	$(MAKE) -C subdir

subdir/target2:
	@echo '---- rule subdir/target2 ----'
	$(MAKE) -C subdir -f subdir2.mk

subdir/target3:
	@echo '---- rule subdir/target3 ----'
	$(MAKE) -f subdir/subdir3.mk
