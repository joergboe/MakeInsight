# Wildcard characters of GNU Make in prerequisites and targets.
# Non escaped characters *, ?, [..] are used as wildcards in prerequisites and targets!
# If nothing matches, the pattern is used as filename literally. (Like the shell does with
# option nullglob switched off)

# wildcards2-rules.mk - Wildcard characters in prerequisites

# Usage:
# Demonstrate pattern matching in prerequisites.
# make -f wildcards2-rules.mk

# Check that all files are recognized as up to date: Nothing to be done for 'all'.
# make -f wildcards2-rules.mk STEP=2

# Cleanup
# make -f wildcards2-rules.mk clean

ifneq (2,$(STEP))
  $(info All prerequisites must exist - touching all prerequisites)
  $(shell touch file{1..5}prereq file\\{1..5}prereq fileabprereq\
                file\*prereq file\\\*prereq file\\\\\?prereq\
                file\[15]prereq file\\\[15]prereq)
endif
prerequisites1 := $(wildcard file[1-9]*prereq file\*prereq fileabprereq file\[*)
prerequisites2 := $(wildcard file\\[1-9]*prereq file\\\*prereq file\\\[*)
prerequisites3 := $(wildcard file\\\\*prereq)
$(info Prerequisites:)
$(info $(prerequisites1))
$(info $(prerequisites2))
$(info $(prerequisites3))
$(info )


#.POSIX:
.SUFFIXES:
.PHONY: all clean

all: filerule1 filerule2 filerule3 filerule4 filerule5 filerule6 filerule7\
     filerulenowc1 filerulenowc2 filerulenowc3

filerule1: file*prereq
	@echo 'Rule: $@  : file*prereq'
	@echo '$$^: $^'
	touch $@
filerule2: file?prereq
	@echo 'Rule $@ : file?prereq'
	@echo '$$^: $^'
	touch $@
filerule3: file[13]prereq
	@echo 'Rule $@ : file[13]prereq'
	@echo '$$^: $^'
	touch $@
filerule4: file[3-5]prereq
	@echo 'Rule $@ : file[3-5]prereq'
	@echo '$$^: $^'
	touch $@
filerule5: file\\*prereq
	@echo 'Rule $@ : file\\*prereq - one literal \ and wildcard * - 2N backslashes represents N backslashes'
	@echo '$$^: $^'
	touch $@
filerule6: file\\[13]prereq
	@echo 'Rule $@ : file\\[13]prereq'
	@echo '$$^: $^'
	touch $@
filerule7: file\\\\*prereq
	@echo 'Rule $@ : file\\\\*prereq'
	@echo '$$^: $^'
	touch $@
	@echo
filerulenowc1: file\*prereq
	@echo 'Rule $@ : file\*prereq - literal *'
	@echo '$$^: $^'
	touch $@
filerulenowc2: file\\\*prereq
	@echo 'Rule $@ : file\\\*prereq - one literal \ and literal * - 2N+1 backslashes represents N backslashes'
	@echo '$$^: $^'
	touch $@
filerulenowc3: file\[15]prereq
	@echo 'Rule $@ : file\[15]prereq'
	@echo '$$^: $^'
	touch $@

clean:
	-@rm -vf file*prereq filerule*
