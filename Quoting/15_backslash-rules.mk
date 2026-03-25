# Use of backslash characters in targets and prerequisites
# Backslash

# Usage:
# Demonstration of rules to generates files with backslashes in name
# make -f 15_backslash-rules.mk

# Check that all files are recognized as up to date.
# Expected: Nothing to be done for 'all'.
# make -f 15_backslash-rules.mk

# Show the generated files
# make -f 15_backslash-rules.mk show

# Cleanup
# make -f 15_backslash-rules.mk clean

# Demonstration of rules to generates files with backslashes in name in posix mode
# make -f 15_backslash-rules.mk USE_POSIX=1

# Cleanup
# make -f 15_backslash-rules.mk clean

ifneq (,$(findstring show,$(MAKECMDGOALS)))
  $(info Files with embedded bs - N backspaces represent N backspaces in file name)
  $(info $(wildcard filebm*))
  $(info )
  $(info Files start with bs - N backspaces represent N backspaces in file name)
  $(info $(wildcard *fileba*))
  $(info )
  $(info Files end with bs (before space, tab, :, #) - 2N+1 backspaces represent N backspaces in file name)
  $(info $(wildcard filebe*))
  $(info )
  $(info Files end with even number of bs before nl - 2N backspaces represent 2N backspaces in file name)
  $(info A space/tab or space(s) + comment may follow after last prerequisite and before newline (stripped line end))
  $(info $(wildcard filebne*))
  $(info )
  $(info Files end with odd number of bs before nl - 2N+1 backspaces represent 2N backspaces in file name)
  $(info A space/tab or space(s) + comment is required after last prerequisite and before newline)
  $(info $(wildcard filebno*))
  $(info )
  $(info Files end with bs direct before nl - odd number of bs introduces a continuation line)
  files = $(shell for x in filebx*; do echo "'$${x}'"; done)
  $(info $(files))
  $(info )
  $(info Files with special char after bs - 2N+1 backspaces represent N backspaces in file name)
  files = $(shell for x in filess*; do echo "'$${x}'"; done)
  $(info $(files))
  $(info )
endif

ifdef USE_POSIX
.POSIX:
endif

.SUFFIXES:
.PHONY: all show clean
all: target-bs-embedded target-bs-begin target-bs-end target-bs-nl-even target-bs-nl-odd target-bs-nl-odd2 target-bs-sp

show:

# embedded target-bs-ends
target-bs-embedded: filebm\1b filebm\\2b filebm\\\3b filebm\\\\4b
	touch $@
	@echo '$$^ = $^'
	@echo -e '*** END: embedded backslashes ***\n'
filebm\1b:
	# Starting or embedded backslashes preceding non special character go unmolested by make.
	touch '$@' # shell quoting is required
filebm\\2b:
	touch '$@'
filebm\\\3b:
	touch '$@'
filebm\\\\4b:
	touch '$@'

target-bs-begin:  \fileba1b \\fileba2b \\\fileba3b \\\\fileba4b
	touch $@
	@echo '$$^ = $^'
	@echo -e '*** END: backslashes at start ***\n'
\fileba1b:
	touch '$@' # shell quoting is required
\\fileba2b:
	touch '$@'
\\\fileba3b:
	touch '$@'
\\\\fileba4b:
	touch '$@'

target-bs-end: filebe2b\\ filebe4b\\\\	filebe6b\\\\\\# comment
	touch $@
	@echo '$$^ = $^'
	@echo -e '*** END: backslashes at end before <space>, <tab>, : or # ***\n'
filebe2b\\ :
	# NOTE: 2N backslashes required before special char (<space>, <tab>, : and #)
	touch '$@'
filebe4b\\\\	:
	touch '$@' # before <tab>
filebe6b\\\\\\:
	touch '$@'

target-bs-nl-even: filebne2b\\
	# NOTE: 2N backslashes before newline represent 2N backslashes.
	# NOTE: a space/tab or space(s) + comment may follow after last prerequisite and newline
	touch $@
	@echo '$$^ = $^'
	@echo -e '*** END: even number of backslashes at end before <nl> ***\n'
target-bs-nl-even: filebne4b\\\\ 
target-bs-nl-even: filebne6b\\\\\\  	# comment
filebne2b\\\\ :
	touch '$@'
filebne4b\\\\\\\\:
	touch '$@'
filebne6b\\\\\\\\\\\\:
	touch '$@'

target-bs-nl-odd: filebno1b\	# There must be a space or tab before nl
	touch '$@'
	@echo '$$^ = $^'
	@echo -e '*** END: odd number of backslashes at end before <nl> ***\n'
target-bs-nl-odd: filebno3b\\\ 
filebno1b\\:
	# NOTE: An odd number of backslashes at the end of the last prerequisite require a space/tab before nl
	#       Otherwise a continuation line is introduced.
	# NOTE: a space(s) + comment may also follow after last prerequisite
	touch '$@'
filebno3b\\\\\\:
	touch '$@'

target-bs-nl-odd2: filebx1b\
filebx3b\\\
filebx5b\\\\\
filebx9b\\\\\\\\\
filebx4b\\\\
	# 2N backslashes before a newline are taken as is.
	# 2N+1 backslashes before a newline introduce a continuation line. 2N+1 backslashes
	# represent N backslashes in the continuation line.
	# Whitespace between words is folded into single space character.
	# In the continuation line whitespace between words is folded into single space characters.
	# Remaining backslashes in the continuation line are control the meaning of special characters
	# in the concatenated line.
	touch '$@'
	# NOTE: Filenames with space are not properly handled in lists.
	@echo '$$^ = $(foreach x,$^,"$(x)")'
	@echo -e '*** END: odd number of backslashes directly before <nl> ***\n'
filebx1b:
	# A single backslash introduces the continuation line, the space introduced with continuation line separates words.
	touch '$@'
filebx3b\ filebx5b\\:
	# Backslashes in continuation lines are counted.
	# 3 bs: One bs introduces the continuation line and 2 bs are folded into one bs, thus the space is taken literally
	# 5 bs: One bs introduces the continuation line and 4 bs are folded into 2 bs, thus the space keeps significance
	touch '$@'
filebx9b\\\\:
	# 9 bs: One bs introduces the continuation line and 8 bs are folded into 4 bs, thus the space keeps significance
	touch '$@'
filebx4b\\\\\\\\:
	# 4 bs: No continuation line, all bs are taken as is
	touch '$@'
	@echo

target-bs-sp: filess1b\  filess3b\\\ 	filess5b\\\\\# filess7b\\\\\\\:
	# 2N+1 backslashes in script text means N backslashes and the literal character
	# NOTE: Filenames with space are not properly handled in lists.
	touch '$@'
	@echo '$$^ = $(foreach x,$^,"$(x)")'
	@echo 'END'
filess1b\ :
	# backslash before space
	touch '$@'
filess3b\\\	:
	# backslash before tab: decays to space!
	touch '$@'
filess5b\\\\\# :
	touch '$@'
filess7b\\\\\\\::
	touch '$@'


clean:
	rm -fv filebm* filebe* filebn* filebx* filess*
	rm -fv \\fileba* \\\\fileba* \\\\\\fileba* \\\\\\\\fileba*
	rm -fv target-bs*
