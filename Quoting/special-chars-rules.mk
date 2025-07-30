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
  $(info Files with special char (to be escaped in tareget and in prerequisites):)
  specialfiles := $(wildcard filesp1*s)
  $(info $(specialfiles))
  $(info )
  $(info Files with backslash preceding special char (to be escaped in tareget and in prerequisites):)
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
all: makespecials makespecials2 makespecials3 makespecials4

show:

# special chars to make - escape with backslash in target and prerequisite
.PHONY: makespecials
makespecials: filesp1\:s filesp1\#s filesp1\ s\
              filesp1\\\:sb filesp1\\\\\#sbb filesp1\\\\\\\ sbbb

filesp1\:s:
	# Special charaters to make must be quoted to make with a single backspace
	# Colon is a reserved word in the shell, thus it is allowed to use unquoted as second word.
	touch $@ # : same escaping rules in shell
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
	@echo

# tab character
.PHONY: makespecials2
makespecials2: filesp2\ s1 filesp2\ s2 filesp2\ s3
#filesp2\	s1 'filesp2       s1', needed by 'makespecials2'.  Stop.
filesp2\	s1:
	# tab character decays to a single space in the prerequisites
	touch '$@'
filesp2\	s2 filesp2\	s3:
	touch '$@'
	@echo

# special to make - escape in prerequisite only
.PHONY: makespecials3
makespecials3: filesp3\|o filesp3\\\|ob
# filesp3\\|o # a pure | character is not allowed in prerequisites -> Order-only target

filesp3|o:
	# special to make - escape in prerequisite only
	touch '$@' # in target no backslash required!
filesp3\|ob:
	touch '$@' # in target no backslash required - one backslash
	@echo

# special to make - escape in target only
.PHONY: makespecials4
makespecials4: filesp4%sp1 filesp4\%spb2 filesp4\\%spbb3 filesp4\%spbx

filesp4\%sp1:
	# % character is special to make but must be escaped in targets only
	# 2N preceding backslashes represents N backslashes and the special char is taken literally
	touch $@ # Rule filesp4\%sp1 - literal %
filesp4\\\%spb2:
	touch '$@' # Rule filesp4\\\%spb2- one backspace + literal
filesp4\\\\\%spbb3:
	touch '$@' # Rule filesp4\\\\\%spbb3 - two backspaces + literal
filesp4\\%spbx:
	touch '$@' # filesp4\\%spbx - also one backspace!
	@echo

.PHONY: clean
clean:
	rm -fv filesp1* filesp2* filesp3* filesp4*
