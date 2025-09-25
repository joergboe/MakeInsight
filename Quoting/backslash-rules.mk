# Use of characters special to make in targets and prerequisites
# Backslash

# Usage:
# Demonstration of rules to generates files with non special characters
# make -f backslash-rules.mk

# Check that all files are recognized as up to date: Nothing to be done for 'all'.
# make -f backslash-rules.mk

# Show the generated files
# make -f backslash-rules.mk show

# Cleanup
# make -f backslash-rules.mk clean

ifneq (,$(findstring show,$(MAKECMDGOALS)))
  $(info Files names with starting or embedded backslashes preceding non special character :)
  myfiles = $(wildcard filem* *filea[0-9])
  $(info $(myfiles))
  $(info Starting or embedded backslashes preceding non special character go unmolested by make.)
  $(info )
  $(info Files with backslash before special char <space>, <tab> or <:> :)
  #myfiles = $(foreach var,$(wildcard filebe[0-9]*),'$(var)')
  myfiles = $(shell for x in filebe[0-9]*; do echo -n "'$$x' "; done)
  $(info $(myfiles))
  $(info 2N+1 preceding backslashes represent N backslashes and the special char is taken literally.)
  $(info 2N preceding backslashes represent N backslashes.)
  $(info )
  $(info Files with backslash before <newline> :)
  myfiles = $(shell for x in filebee*; do echo -n "'$$x' "; done)
  $(info $(myfiles))
  $(info 2N+1 backslashes before a newline introduces a contionuation line.)
  $(info In the continuation line whitespace between words is folded into single space characters.)
  $(info Remaining backslashes in the continuation line are control the meaning of special characters)
  $(info in the concatenated line.)
  $(info Different number of backslashes in prerequisite and target.)
  $(info )
endif


#.POSIX:
.SUFFIXES:
.PHONY: all show
all: backslash1 backslash2 backslash3

show:

# embedded or starting backslashes
.PHONY: backslash1
backslash1: filem\m1 filem\\m2 filem\\\m3 filem\\\\m4 \filea1 \\filea2 \\\filea3 \\\\filea4
filem\m1:
	# Starting or embedded backslashes preceding non special character go unmolested by make.
	touch '$@' # shell quoting is required
	@echo if unquoted shell sees: $@
filem\\m2:
	touch '$@'
	@echo if unquoted shell sees: $@
filem\\\m3:
	touch '$@'
	@echo if unquoted shell sees: $@
filem\\\\m4:
	touch '$@'
	@echo if unquoted shell sees: $@
\filea1:
	touch '$@'
\\filea2:
	touch '$@'
\\\filea3:
	touch '$@'
\\\\filea4:
	touch '$@'
	@echo

.PHONY: backslash2
# 2N backslashes before special char (space, tab or colon) are divided in half
# 2N backslashes before newline survive.
backslash2: filebe2\\ filebe4\\\\	filebee6\\\\\\
filebe2\\ :
	# backslash before special char (space, tab or colon) are divided in half
	touch '$@'
filebe4\\\\	:
	touch '$@' # tab follows
filebee6\\\\\\\\\\\\:
	touch '$@'
	@echo

.PHONY: backslash3
# 2N+1 backslashes before special char (space, tab or colon) represent N backslashes
# and the special meaning of the following character is removed.
backslash3: filebe1\  filebe3\\\ 	 end2
filebe1\ :
	# backslash before space
	touch '$@'
filebe3\\\	:
	# backslash before tab: decays to space!
	touch '$@'
	@echo

.PHONY: end2
end2: filebee1\
filebee3\\\
filebee5\\\\\
filebee4\\\\
# 2N backslashes before a newline are taken as is.
# 2N+1 backslashes before a newline introduce a continuation line. 2N+1 backslashes
# represent N backslashes in the continuation line.
# Whitespace between words is folded into single space character.
# 4N backslashes before newline means: newline keeps special meaning and
filebee1:
	# A backslash is removed, the space separates words.
	touch '$@'

filebee3\ filebee5\\:
	# Backslashes in continuation lines are counted.
	# 2N+1 backslashes in the concatenated line and the space is taken literally
	touch '$@'

filebee4\\\\\\\\:
	# All backslashes survive.
	touch '$@'
	@echo

.PHONY: clean
clean:
	rm -fv filem* filebe*
	rm -fv \\filea* \\\\filea* \\\\\\filea* \\\\\\\\filea*
