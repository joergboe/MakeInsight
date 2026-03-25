# Use of special characters in targets and prerequisites

# Usage:
# Demonstration of rules to generates files with special characters
# make -f 10_special-chars-rules.mk

# Check that all files are recognized as up to date.
# Expected: Nothing to be done for 'all'.
# make -f 10_special-chars-rules.mk

# Show the generated files
# make -f 10_special-chars-rules.mk show
# Cleanup
# make -f 10_special-chars-rules.mk clean


ifneq (,$(findstring show,$(MAKECMDGOALS)))
  $(info Characters: :, # and <space>)
  $(info Files with special char (to be escaped in target and in prerequisites):)
  $(info $(wildcard filesp1*s))
  $(info )
  $(info Files with backslash preceding special char (to be escaped in target and in prerequisites):)
  $(info 2N+1 preceding backslashes represent N backslashes and the special char is taken literally)
  $(info $(wildcard filesp1*sb*))
  $(info )
  $(info Characters: <tab>)
  $(info Files with decayed tab character:)
  $(info $(wildcard filesp2*))
  $(info )
  $(info Character to be escaped in prerequisites only: | )
  $(info Special characters to make that must be escaped in prerequisites:)
  $(info Prerequisites: 2N+1 preceding backslashes represent N backslashes and the special char is taken literally.)
  $(info Targets: N preceding backslashes represent N backslashes!)
  $(info $(wildcard filesp3*))
  $(info $(specialfiles))
  $(info )
  $(info Character to be escape in targets only: % )
  $(info Special characters to make that must be escaped in target only:)
  $(info Targets: 2N+1 preceding backslashes represent N backslashes and the special char is taken literally.)
  $(info Prerequisites: N preceding backslashes represent N backslashes!)
  $(info $(wildcard filesp4*.s))
  $(info $(wildcard filesp4*.o))
  $(info )
  $(info No direct escaping possible for characters: = and ; )
  $(info filesp5\=s: #*** recipe commences before first target.  Stop.)
  $(info filesp5\;s: #*** missing separator.  Stop.)
  $(info but with hack $$(firstword =) and $$(firstword %))
  $(info $(wildcard filesp5*))
  $(info )
endif

#.POSIX:
.SUFFIXES:*** recipe commences before first target.  Stop.

.PHONY: all show
all: filemakesp1 filemakesp2 filemakesp3 filemakesp4 filemakesp5

show:

# special chars to make - escape with backslash in target and prerequisite
filemakesp1: filesp1\:s filesp1\#s filesp1\ s filesp1\\\:sb filesp1\\\\\#sbb filesp1\\\\\\\ sbbb
	touch '$@'
	@echo '$$^: $^'
	@echo '$$<: $<'
	@echo

filesp1\:s:
	# The special characters <space>, # and : must be quoted in targets and prerequisites with a single backslash.
	# NOTE: Colon is a reserved word in the shell, thus it is allowed to use unquoted as second word.
	touch $@ # : no shell quoting required
filesp1\#s:
	touch '$@' # # - shell quoting required
filesp1\ s:
	touch '$@' # space  - shell quoting required
	@echo
filesp1\\\:sb:
	# NOTE: Backslashes that would otherwise quote special characters can be quoted with more backslashes.
	# 2N+1 preceding backslashes represents N backslashes and the literal special character.
	touch '$@' # One backslash
filesp1\\\\\#sbb:
	touch '$@' # Two backslashes
filesp1\\\\\\\ sbbb:
	touch '$@' # Three backslashes

# tab character
filemakesp2: filesp2\ s1 filesp2\ s2 filesp2\ s3
	touch '$@'
	@echo '$$^: $^'
	@echo '$$<: $<'
	@echo

#filesp2\	s1 'filesp2       s1', needed by 'filemakesp2'.  Stop.
filesp2\	s1:
	# NOTE: tab character decays to a single space in targets - a tab character can not be used in targets!
	touch '$@'
filesp2\	s2 filesp2\	s3:
	touch '$@'

# special to make - escape in prerequisite only
filemakesp3: filesp3\|s filesp3\\\|sb
	touch '$@'
	@echo '$$^: $^'
	@echo '$$<: $<'
	@echo
# filesp3\\|s # a pure | character is not allowed in prerequisites -> Order-only target

filesp3|s:
	# The | character must be escaped in prerequisite only.
	touch '$@' # in target no backslash required!
filesp3\|sb:
	touch '$@' # NOTE: One backslash before | - yields one backslash before | in targets.

# special to make - escape in target only
filemakesp4: filesp4%s.o filesp4\%sb.o filesp4\\%sbb.o
	# % character is special to make in targets only
	# In targets 2N+1 preceding backslashes represents N backslashes and the special char is taken literally.
	# NOTE: In prerequisites one backslash before % - yields one backslash before %.
	touch '$@'
	@echo '$$^: $^'
	@echo '$$<: $<'
	# NOTE: One backslash before % - yields one backslash before % in prerequisites.
	@echo

filesp4\%s.o: filesp4%s.s
#filesp4%s: filesp4%s.s    # this does not! work this makes implicit rules
	@echo '$$@ = $@:	$$< = $<'
	touch $@ # literal %
filesp4\\\%sb.o: filesp4\%sb.s
#filesp4\\%sb.o: filesp4\%sb.s
	@echo '$$@ = $@:	$$< = $<'
	touch '$@' # one backspace + literal %
filesp4\\\\\%sbb.o: filesp4\\%sbb.s
#filesp4\\\\%sbb.o: filesp4\\%sbb.s
	@echo '$$@ = $@:	$$< = $<'
	touch '$@' # two backspaces + literal %

filesp4\%s.s:
#filesp4%s.s:
	touch $@ # literal %
filesp4\\\%sb.s:
#filesp4\\%sb.s:
	touch '$@' # one backspace + literal %
filesp4\\\\\%sbb.s:
#filesp4\\\\%sbb.s:
	touch '$@' # two backspaces + literal %

# NOTE: No escape possible for ;
# filesp6\;s: # *** missing separator.  Stop.

# NOTE: No escape possible for =
# filemakesp6: filesp6\=s # *** recipe commences before first target.  Stop.
#	touch '$@'

#filesp6\=s : # *** recipe commences before first target.  Stop.
#	touch '$@'

# some expansion hacks
filemakesp5: filesp5$(firstword =)s filesp5$(firstword %)s\
filesp5\$(firstword =)sb filesp5\$(firstword %)sb
#filesp5$(firstword |)s # this is recognized as order only rule anyway
#fiesp5$(firstword ;)s
	touch '$@'
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
clean:; rm -fv filesp1* filesp2* filesp3* filesp4* filesp5* filemakesp*
