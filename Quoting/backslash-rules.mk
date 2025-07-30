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
  $(info Files with embedded or starting backslashes preceding non special character :)
  myfiles = $(wildcard filem* *filea[0-9])
  $(info $(myfiles))
  $(info )
  $(info Files with backslash before special char <space> or <tab> :)
  #myfiles = $(foreach var,$(wildcard filebe[0-9]*),'$(var)')
  myfiles = $(shell for x in filebe[0-9]*; do echo -n "'$$x' "; done)
  $(info $(myfiles))
  $(info 2N+1 preceding backslashes represent N backslashes and the special char is taken literally.)
  $(info 2N preceding backslashes represent N backslashes.)
  $(info )
  $(info Files with backslash before <newline> :)
  myfiles = $(shell for x in filebee*; do echo -n "'$$x' "; done)
  $(info $(myfiles))
  $(info A backslash before a newline is never interpreted as before a special char such as space.)
  $(info Whitespace between words is folded into single space characters; leading and trailing whitespace is discarded.)
  $(info Different number of backslashes in prerequisite and target.)
  $(info )
endif


#.POSIX:
.SUFFIXES:
.PHONY: all show
all: backslash1 backslash2

show:

# embedded or starting backslashes
.PHONY: backslash1
backslash1: filem\m1 filem\\m2 filem\\\m3 filem\\\\m4 \filea1 \\filea2 \\\filea3 \\\\filea4
filem\m1:
	# embedded or starting backslashes preceding non special character go unmolested by make
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
# backslash before special char (space or tab) are divided in half
backslash2: filebe1\  filebe2\\ filebe3\\\  filebe4\\\\	end2
filebe1\ :
	# backslash at end
	touch '$@'
filebe2\\ :
	# backslash before special char (space or tab) are divided in half
	touch '$@'
filebe3\\\ :
	touch '$@'
filebe4\\\\  :
	touch '$@' # tab follows
	@echo

.PHONY: end2
end2: filebee1\ 
filebee1\\ :
	# A backslash before a newline is never interpreted as before a special char such as space...
	# Whitespace between words is folded into single space characters; leading and trailing whitespace is discarded. 
	touch '$@'

end2: filebee2\\ 
filebee2\\\\ :
	touch '$@'

end2: filebee3\\\	 
filebee3\\\\\\ :
	touch '$@'
	@echo

.PHONY: clean
clean:
	rm -fv filem* filebe*
	rm -fv \\filea* \\\\filea* \\\\\\filea* \\\\\\\\filea*
