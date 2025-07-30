# Wildcard characters of GNU Make in prerequisites and targets.
# Non escaped characters *, ?, [..] are used as wildcards in prerequisites and targets!
# If nothing matches, the pattern is used as filename literally. (Like the shell does with
# option nullglob switched off)

# wildcards3.mk - Wildcard characters in targets

# Usage:
# Demonstrate pattern matching in targets.
# make -f wildcards3-rules.mk

# Check that all files are recognized as up to date: Nothing to be done for 'all'.
# make -f wildcards3-rules.mk STEP=2

# Check that all target patterns are used literally if no match was found.
# As long as the shell does not use 'nullglob', the target patterns are used literally. 
# make -f wildcards3-rules.mk STEP=3

# Check that all files are recognized as up to date: Nothing to be done for 'all'.
# make -f wildcards3-rules.mk STEP=4

# Run the rules again!
# If new files are found some rules may not be triggered
# make -f wildcards3-rules.mk STEP=5

# Cleanup
# make -f wildcards3-rules.mk clean

ifeq (2,$(STEP))
  $(info Not touching global prerequisite 'fileprerequisite')
  $(info Expect: Nothing to be done for 'all')
else ifeq (3,$(STEP))
  $(shell rm -f file*target*)
  $(info None of the expected targets exist.)
  $(info If nothing matches the pattern is used literally.)
  $(info Make sure that the shell does not use 'nullglob'.)
  $(info *** 'Touching global prerequisite 'fileprerequisite'.)
  $(shell touch fileprerequisite)
else ifeq (4,$(STEP))
  $(info Not touching global prerequisite 'fileprerequisite'.)
  $(info Expect: Nothing to be done for 'all')
else ifeq (5,$(STEP))
  $(info Now we create new targets file1target3 and file\1target4.)
  $(info !!! The files file[13]target3 and file\\[13]target4 are not updated any longer !!!)
  $(info *** 'Touching global prerequisite 'fileprerequisite'.)
  $(shell touch file1target3 file\\1target4)
  $(shell touch fileprerequisite)
  $(info !!! Now the targets are taken literally !!!)
else
  $(info To make the wilcard expansion happen, some targets must exist.)
  $(shell touch file{1..3}target{1..4} fileabtarget{1..4} file\\{1..3}target4)
  $(shell sleep 2)
  $(info *** 'Touching global prerequisite 'fileprerequisite'.)
  $(shell touch fileprerequisite)
endif

existing_targets1 := $(wildcard file*target1)
existing_targets2 := $(wildcard file*target2)
existing_targets3 := $(wildcard file*target3)
existing_targets4 := $(wildcard file*target4)
$(info Existing targets:)
$(info $(existing_targets1))
$(info $(existing_targets2))
$(info $(existing_targets3))
$(info $(existing_targets4))
$(info )


#.POSIX:
.SUFFIXES:
.PHONY: all clean

all: file*target1 file?target2 file[13]target3 file\\[13]target4

file*target1: fileprerequisite
	# The results of the found target files must not overlap.
	@echo 'Rule 1 file*target1 - file $@'
	touch $@
file?target2: fileprerequisite
	@echo 'Rule 2 file?target2 - file $@'
	touch $@
file[13]target3: fileprerequisite
	@echo 'Rule 3 file[13]target3 - file $@'
	touch $@
file\\[13]target4: fileprerequisite
	@echo 'Rule 4 file\\[13]target4 - file $@'
	touch '$@' # Names with backslashes before non special characters require shell qouting!

clean:
	-@rm -vf file*target* fileprerequisite
