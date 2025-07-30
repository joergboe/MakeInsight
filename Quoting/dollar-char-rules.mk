# Dollar character prerequisites and targets.

# dollar-char-rules.mk - Quoting of $

# Usage:
# Demonstration of rules to generates files with wildcard characters
# make -f dollar-char-rules.mk

# Check that all files are recognized as up to date: Nothing to be done for 'all'.
# make -f dollar-char-rules.mk

# Show the generated files
# make -f dollar-char-rules.mk show

# Cleanup
# make -f dollar-char-rules.mk clean

ifneq (,$(findstring show,$(MAKECMDGOALS)))
  dollarfiles := $(wildcard filedol[1-9]*d)
  dollarfiles_one_bs := $(wildcard filedol[1-9]*db)
  dollarfiles_two_bs := $(wildcard filedol[1-9]*dbb)
  dollarfiles_secondary := $(wildcard filedols*)

  $(info Generated files targets 1..4 $ found:)
  $(info $(dollarfiles))
  $(info )
  $(info N preceding backslashes represent N backslashes)
  $(info Generated files targets one backslash:)
  $(info $(dollarfiles_one_bs))
  $(info )
  $(info Generated files targets two backslashes:)
  $(info $(dollarfiles_two_bs))
  $(info )
  $(info Generated files after secondary expansion:)
  $(info $(dollarfiles_secondary))
  $(info If the prerequisites of a rule are expanded a second time (Secondary Expansion),)
  $(info the number of dollar signs must be doubled for these prerequisites.)
 $(info )
endif

v = --

.SUFFIXES:

.PHONY: all
all: dollar1 dollar2
.PHONY: show
show:

# dollar sign
.PHONY: dollar1
dollar1: filedol1$vd filedol2$$d filedol3$$$vd filedol4$$(abc)d filedol5$$$$(abc)d\
         filedol1\$vdb filedol2\$$db filedol3\\$$dbb

filedol1$vd:
	# dollar sign
	# dollar sign has special meaning for the shell -> shell quoting in recipes required
	touch '$@' # filedol1$$vd - expands variable v
filedol2$$d:
	touch '$@' # filedol2$$$$d
filedol3$$$vd:
	touch '$@' # filedol3$$$$$$vd -> expands variable v
filedol4$$(abc)d:
	touch '$@' # filedol4$$$$(abc)d
filedol5$$$$(abc)d:
	touch '$@' # filedol5$$$$$$$$(abc)d
filedol1\$vdb:	
	touch '$@' # filedol1\$$vdb -> N preceding backslashes represent N backslashes
filedol2\$$db:
	touch '$@' # filedol2\$$$$db
filedol3\\$$dbb:
	touch '$@' # filedol3\\\\$$$$dbb - N  preceding backslashes represent N backslashes
	@echo

# dollar sign and secondary expansion
.SECONDEXPANSION:
.PHONY: dollar2
dollar2: filedols1$$$$dd filedols2\$$$$ddb filedols3\\$$$$ddbb

filedols1$$dd:
	# dollar sign and secondary expansion
	# the prerequisites are expanded a second time!
	touch '$@' # filedols1$$$$$$$$dd
filedols2\$$ddb:
	touch '$@' # filedols2\$$$$$$$$ddb
filedols3\\$$ddbb:
	touch '$@' # filedols3\\$$$$$$$$ddbb
	@echo

.PHONY: clean
clean:
	rm -fv filedol*
