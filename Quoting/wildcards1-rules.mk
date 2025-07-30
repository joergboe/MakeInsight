# Wildcard characters of GNU Make in prerequisites and targets.
# Characters: *, ?, [ .. ]

# wildcards1.mk - Quoting of wildcard characters

# Usage:
# Demonstration of rules to generates files with wildcard characters
# make -f wildcards1-rules.mk

# Check that all files are recognized as up to date: Nothing to be done for 'all'.
# make -f wildcards1-rules.mk

# Show the generated files
# make -f wildcards1-rules.mk show

# Cleanup
# make -f wildcards1-rules.mk clean

ifneq (,$(findstring show,$(MAKECMDGOALS)))
  wcfiles := $(wildcard filewc*wc filewc*wcx)
  wcfiles_one_bs := $(wildcard filewc*wcb)
  wcfiles_two_bs := $(wildcard filewc*wcbb)
  wcfiles_not_special := $(wildcard filensp*)
  $(info Generated files with wildcards characters found:)
  $(info $(wcfiles))
  $(info )
  $(info The characters *, ?, [ and ] (special chars) require:)
  $(info 2N+1 preceding backslashes represent N backslashes and the following char is taken literally)
  $(info Generated files targets one backslash:)
  $(info $(wcfiles_one_bs))
  $(info )
  $(info Generated files targets two backslashes:)
  $(info $(wcfiles_two_bs))
  $(info )
  $(info The character ] if used unpaired (non special char) requires:)
  $(info N preceding backslashes represent N backslashes and the following char is taken literally)
  $(info $(wcfiles_not_special))
  $(info )
endif

.SUFFIXES:
.PHONY: all show clean specialchars1 specialchars2
all: specialchars1 specialchars2 notspecial

show:

specialchars1: filewc1\*wc filewc2\?wc filewc3\[15]wc filewc4\[wc filewc5[wcx

filewc1\*wc:
	# In targets and prerequisites Make understands the same wildcard characters as
	# the Bourne shell: *, ?, [ and ]
	# The special significance of a wildcard character can be turned off by preceding it with a backslash.
	touch $@ # Matching shell make escape rules - no quoting required
filewc2\?wc:; touch $@ # Matching shell make escape rules - no quoting required
filewc3\[15]wc:; touch $@ # Matching shell make escape rules - no quoting required
filewc4\[wc:
	touch $@ # Matching shell make escape rules - no quoting required
filewc4[wc:
	touch $@ # file[wc and file\[wc are effectively the same rule.
filewc5[wcx:
	touch '$@' # Unpaired [ represents the same character as the escaped one \[
	@echo

specialchars2: filewc1\\\*wcb filewc2\\\?wcb filewc3\\\[15]wcb filewc4\\\[wcb filewc5\\\\\*wcbb\
               filewc6\\\\\[15]wcbb filewc7\\\\\[16\\\\\]wcbb

filewc1\\\*wcb:
	# Characters *, ? and [ are special to Make
	# 2N+1 preceding backslashes represents N backslashes and the literal *, ? and [
	touch $@
filewc2\\\?wcb:; touch $@ # one backslash
filewc3\\\[15]wcb:; touch $@ # one backslash
filewc4\\\[wcb:; touch $@ # one backslash
filewc5\\\\\*wcbb:; touch $@ # two backslashes
filewc6\\\\\[15]wcbb:; touch $@ # two backslashes
filewc7\\\\\[16\\\\\]wcbb:; touch $@ # two backslashes
	@echo

notspecial: filensp]wc filensp\]wcb filensp\\]wcbb

filensp]wc:
	# An unpairedcharacter ] is not special to make
	# N preceding backslashes represent N backslashes
	touch $@
filensp\]wcb:
	touch '$@' # one backslash
filensp\\]wcbb:
	touch '$@' # two backslashes
	@echo

clean:
	@rm -vf filewc* filensp*
