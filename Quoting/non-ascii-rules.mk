# Use of non ascii characters in targets and prerequisites

# Usage:
# Demonstration of rules to generates files
# make -f non-ascii-rules.mk

# Check that all files are recognized as up to date: Nothing to be done for 'all'.
# make -f non-ascii-rules.mk

# Show the generated files
# make -f non-ascii-rules.mk show

# Cleanup
# make -f non-ascii-rules.mk clean

ifneq (,$(findstring show,$(MAKECMDGOALS)))
  notspecialfiles1 := $(wildcard filenascii*)
  notspecialfiles2 := $(wildcard filenascib*)
  $(info Files with non ascii chars:)
  $(info $(notspecialfiles1))
  $(info )
  $(info Files with non ascii chars preceeded by a \ :)
  $(info N preceding backslashes represents N backslashes)
  $(info $(notspecialfiles2))
  $(info )
endif

#.POSIX:
.SUFFIXES:
.PHONY: all show
all: notspecial notspecial2

show:

.PHONY: notspecial
notspecial: filenasciinaïve filenasciiDänemark filenasciiFærøerne filenasciiRønne\
            filenascii变量 filenasciiéè filenasciiszß

filenasciinaïve:
	touch $@

filenasciiDänemark:
	touch $@

filenasciiFærøerne:
	touch $@

filenasciiRønne:
	touch $@

filenascii变量:
	touch $@

filenasciiéè:
	touch $@

filenasciiszß:
	touch $@
	@echo


.PHONY: notspecial2
notspecial: filenascibna\ïve filenascibD\änemark filenascibF\ær\\øerne filenascibR\ønne\
            filenascib\变量 filenascib\é\è filenascibsz\ß

filenascibna\ïve:
	touch '$@'

filenascibD\änemark:
	touch '$@'

filenascibF\ær\\øerne:
	touch '$@'

filenascibR\ønne:
	touch '$@'

filenascib\变量:
	touch '$@'

filenascib\é\è:
	touch '$@'

filenascibsz\ß:
	touch '$@'
	@echo


.PHONY: clean
clean:; rm -fv filenascii* filenascib*
