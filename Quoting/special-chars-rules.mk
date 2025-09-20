# Use of characters special to make in targets and prerequisites

# Usage:
# Demonstration of rules to generates files with non special characters
# make -f special-chars-rules.mk

# Check that all files are recognized as up to date: Nothing to be done for 'all'.
# make -f special-chars-rules.mk

# Show the generated files
# make -f special-chars-rules.mk show

# Cleanup
# make -f special-chars-rules.mk clean


ifneq (,$(findstring show,$(MAKECMDGOALS)))
  $(info Characters: :, # and <space>)
  $(info Files with special char (to be escaped in target and in prerequisites):)
  specialfiles := $(wildcard filesp1*s)
  $(info $(specialfiles))
  $(info )
  $(info Files with backslash preceding special char (to be escaped in target and in prerequisites):)
  $(info 2N+1 preceding backslashes represent N backslashes and the special char is taken literally)
  specialfiles := $(wildcard filesp1*sb*)
  $(info $(specialfiles))
  $(info )
  $(info Characters: <tab>)
  $(info Files with decayed tab character:)
  specialfiles := $(wildcard filesp2*)
  $(info $(specialfiles))
  $(info )
  $(info Character to be escaped in prerequisites only: | )
  $(info Special characters to make that must be escaped in prerequisites:)
  $(info 2N+1 preceding backslashes represent N backslashes and the special char is taken literally)
  $(info !N preceding backslashes represent N backslashes in targets!)
  specialfiles := $(wildcard filesp3*)
  $(info $(specialfiles))
  $(info )
  $(info Character to be escape in targets only: % )
  $(info Special characters to make that must be escaped in target only:)
  $(info 2N+1 preceding backslashes represent N backslashes and the special char is taken literally)
  $(info !N preceding backslashes represent N backslashes in prerequisites!)
  specialfiles := $(wildcard filesp4*)
  $(info $(specialfiles))
  $(info )
  $(info No escaping possible for characters: = and ; )
  $(info filesp1\=s filesp1\;s)
  $(info filesp1\=s: #*** recipe commences before first target.  Stop.)
  $(info filesp1\;s: #*** missing separator.  Stop.)
  $(info )
endif

#.POSIX:
.SUFFIXES:
.PHONY: all show
all: makespecials makespecials2 makespecials3 makespecials4 makespecials5

show:

# special chars to make - escape with backslash in target and prerequisite
.PHONY: makespecials
makespecials: filesp1\:s filesp1\#s filesp1\ s\
              filesp1\\\:sb filesp1\\\\\#sbb filesp1\\\\\\\ sbbb
	@echo '$@'
	@echo '$$^: $^'
	@echo '$$<: $<'
	@echo

filesp1\:s:
	# Special charaters to make must be quoted to make with a single backspace
	# Colon is a reserved word in the shell, thus it is allowed to use unquoted as second word.
	touch $@ # : no shell quoting required
filesp1\#s:
	touch '$@' # # - shell quoting required
filesp1\ s:
	touch '$@' # space  - shell quoting required
	@echo
filesp1\\\:sb:
	# Backslashes that would otherwise quote special characters can be quoted with more backslashes.
	# 2N+1 preceding backslashes represents N backslashes and the literal
	touch '$@' # One backslash
filesp1\\\\\#sbb:
	touch '$@' # Two backslashes
filesp1\\\\\\\ sbbb:
	touch '$@' # Three backslashes

# tab character
.PHONY: makespecials2
makespecials2: filesp2\ s1 filesp2\ s2 filesp2\ s3
	@echo '$@'
	@echo '$$^: $^'
	@echo '$$<: $<'
	@echo

#filesp2\	s1 'filesp2       s1', needed by 'makespecials2'.  Stop.
filesp2\	s1:
	# tab character decays to a single space in targets
	touch '$@'
filesp2\	s2 filesp2\	s3:
	touch '$@'

# special to make - escape in prerequisite only
.PHONY: makespecials3
makespecials3: filesp3\|o filesp3\\\|ob
	@echo '$@'
	@echo '$$^: $^'
	@echo '$$<: $<'
	@echo
# filesp3\\|o # a pure | character is not allowed in prerequisites -> Order-only target

filesp3|o:
	# special to make - escape in prerequisite only
	touch '$@' # in target no backslash required!
filesp3\|ob:
	touch '$@' # in target no backslash required - one backslash

# special to make - escape in target only
.PHONY: makespecials4
makespecials4: filesp4%sp1.o filesp4\%spb2.o filesp4\\%spbb3.o
	@echo '$@'
	@echo '$$^: $^'
	@echo '$$<: $<'
	# % character is !not! special to make in prerequisites
	@echo

filesp4\%sp1.o: filesp4%sp1
#filesp4%sp1.o: filesp4%sp1    # this does not! work this makes implicit rules
	@echo '$$@ = $@:	$$< = $<'
	touch $@ # literal %
filesp4\\\%spb2.o: filesp4\%spb2
#filesp4\\%spb2.o: filesp4\%spb2
	@echo '$$@ = $@:	$$< = $<'
	touch '$@' # one backspace + literal %
filesp4\\\\\%spbb3.o: filesp4\\%spbb3
#filesp4\\\\%spbb3.o: filesp4\\%spbb3
	@echo '$$@ = $@:	$$< = $<'
	touch '$@' # two backspaces + literal %

filesp4\%sp1:
#filesp4%sp1:
	# % character is special to make in targets only
	# 2N+1 preceding backslashes represents N backslashes and the special char is taken literally
	# 2N  preceding backslashes represents N backslashes and the literal % !!!"
	touch $@ # literal %
filesp4\\\%spb2:
#filesp4\\%spb2:
	touch '$@' # one backspace + literal %
filesp4\\\\\%spbb3:
#filesp4\\\\%spbb3:
	touch '$@' # two backspaces + literal %

# some expansion hacks
.PHONY: makespecials5
makespecials5: filesp5$(firstword =)s filesp5$(firstword %)s\
filesp5\$(firstword =)sb filesp5\$(firstword %)sb
#filesp5$(firstword |)s # this is recognized as order only rule anyway
#fiesp5$(firstword ;)s
	@echo '$@'
	@echo '$$^: $^'
	@echo '$$<: $<'
	@echo

filesp5$(firstword =)s:
	touch '$@'
filesp5\$(firstword %)s:
	touch '$@'	# must also escaped with \ to avoid implicit rule
filesp5\$(firstword =)sb:
	touch '$@'	# one bs required
filesp5\\\$(firstword %)sb:
	touch '$@'	# 3 bs required (2N+1)

#filesp5$(firstword |)s:
#	touch '$@'

#fiesp5$(firstword ;)s: # *** missing separator.  Stop.
#	touch '$@'

.PHONY: clean
clean:; rm -fv filesp1* filesp2* filesp3* filesp4* filesp5*
