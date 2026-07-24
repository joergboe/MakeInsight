# Special characters in filenames stored in variaiables

# Usage: make -f 70_special_chars_in_variables.mk dollarfiles
# Expected: success with escaped dollar

# Usage: make -f 70_special_chars_in_variables.mk hashmarkfiles
# Expected: success

# Usage: make -f 70_special_chars_in_variables.mk wildcardfiles
# Expected: success

# Usage: make -f 70_special_chars_in_variables.mk touchwildcard1
# Usage: make -f 70_special_chars_in_variables.mk wildcardfiles
# Expected: success - unescaped wildcards

# Usage: make -f 70_special_chars_in_variables.mk touchwildcard2
# Usage: make -f 70_special_chars_in_variables.mk wildcardfiles
# Expected: success - escaped wildcards are taken literally

# Usage: make -f 70_special_chars_in_variables.mk spacefiles
# Expected: success

# Usage: make -f 70_special_chars_in_variables.mk specialfiles2
# Expected: success

# Usage: make -f 70_special_chars_in_variables.mk specialfiles3
# Expected: success

# Usage: make -f 70_special_chars_in_variables.mk specialfiles4
# Expected: error

# Cleanup: make -f 70_special_chars_in_variables.mk clean

dollarfiles = file$$1.1.exe file$$$$1.2.exe file\$$1.3.exe # escape $ with another $

hashmarkfiles ::= file\#2.1.exe file\\\#2.2.exe file\\\\\#2.3.exe # quote hash mark in assignment with backslash 2n+1 rule

# in assignments wildcard character are taken as is
wildcardfiles ::= file*3.1.exe file\*3.2.exe file\\*3.3.exe file?4.1.exe file\?4.2.exe file[XY]5.1.exe file\[XY]5.2.exe

specialfiles  ::= file]6.1.exe file\]6.2.exe file,8.exe file\9.1.exe file\\9.2.exe file@10.1.exe file\@10.2.exe

spacefiles = file\ 11.1.exe file\ \ \ \ 11.2.exe file\\\ 11.3.exe # backslashes are taken literally into the variable

specialfiles2 ::= file=12.1.exe file\=12.1.exe

specialfiles3 ::= file\;13.1.exe file\\\;13.2.exe file\:13.4.exe file\\\:13.5.exe

specialfiles4 ::= file|14.1.exe # makes an order only prerequisite
#specialfiles4 ::= file\|14.2.exe # different quoting rules in target and prerequisite
#specialfiles4 ::= file%14.4.exe # introduces an implicit rule
#specialfiles4 ::= file\%14.5.exe # different quoting rules in target and prerequisite


empty ::=

.PHONY : all
all : dollarfiles hashmarkfiles wildcardfiles specialfiles spacefiles specialfiles2 specialfiles3

# NOTE: dollar symbol is automatically escaped in recursively expanded variables
.PHONY : dollarfiles
dollarfiles : $(dollarfiles)
	@echo 'Run $@ due to $?'
	$(info $(empty)       dollarfiles = $(dollarfiles))
	$(info $(empty) value dollarfiles = $(value dollarfiles))
	@echo

$(dollarfiles) :
	@echo 'Run rule $@'

# NOTE: hashmark is taken as is
.PHONY : hashmarkfiles
hashmarkfiles : $(hashmarkfiles)
	@echo 'Run $@ due to $?'
	$(info $(empty)       hashmarkfiles = $(hashmarkfiles))
	$(info $(empty) value hashmarkfiles = $(value hashmarkfiles))
	@echo

$(hashmarkfiles) :
	@echo 'Run rule $@'

.PHONY : wildcardfiles
wildcardfiles : $(wildcardfiles)
	@echo 'Run $@ due to $?'
	$(info $(empty)       wildcardfiles = $(wildcardfiles))
	$(info $(empty) value wildcardfiles = $(value wildcardfiles))
	@echo

$(wildcardfiles) :
	@echo 'Run rule $@'

# NOTE: !!! unescaped wildcard symbols in variables are taken as wildcards !!!
.PHONY : touchwildcard1
touchwildcard1 :
	touch 'fileXXX3.1.exe' 'file\YYY3.3.exe' 'fileX4.1.exe' 'fileY5.1.exe'

# NOTE: backslash escapes wildcard symbols in variables (2N+1) rule
.PHONY : touchwildcard2
touchwildcard2 :
	touch 'file\XXX3.2.exe' 'file\X4.2.exe' 'fileX4.1.exe' 'file\X5.2.exe'

# NOTE: these special characters are taken literally
.PHONY : specialfiles
specialfiles : $(specialfiles)
	@echo 'Run $@ due to $?'
	$(info $(empty)       specialfiles = $(specialfiles))
	$(info $(empty) value specialfiles = $(value specialfiles))
	@echo

$(specialfiles) :
	@echo 'Run rule $@'

# NOTE: can escape spaces in filenames in variables with 2N+1 backslashes (but no list processing possible)
.PHONY : spacefiles
spacefiles : $(spacefiles)
	@echo 'Run $@ due to $?'
	$(info $(empty)       spacefiles = $(spacefiles))
	$(info $(empty) value spacefiles = $(value spacefiles))
	@echo

$(spacefiles) :
	@echo 'Run rule $@'

# NOTE: equation sign is not special in this context
.PHONY : specialfiles2
specialfiles2 : $(specialfiles2)
	@echo 'Run $@ due to $?'
	$(info $(empty)       specialfiles2 = $(specialfiles2))
	$(info $(empty) value specialfiles2 = $(value specialfiles2))
	@echo

$(specialfiles2) :
	@echo 'Run rule $@'

# NOTE: escape ; and : as usual
.PHONY : specialfiles3
specialfiles3 : $(specialfiles3)
	@echo 'Run $@ due to $?'
	$(info $(empty)       specialfiles3 = $(specialfiles3))
	$(info $(empty) value specialfiles3 = $(value specialfiles3))
	@echo

$(specialfiles3) :
	@echo 'Run rule $@'

.PHONY : specialfiles4
specialfiles4 : $(specialfiles4)
	@echo 'Run $@ due to $?'
	$(info $(empty)       specialfiles4 = $(specialfiles4))
	$(info $(empty) value specialfiles4 = $(value specialfiles4))
	@echo

$(specialfiles4) :
	@echo 'Run rule $@'

.PHONY : clean
clean :
	rm -f 'fileXXX3.1.exe' 'file\YYY3.3.exe' 'fileX4.1.exe' 'fileY5.1.exe'
	rm -f 'file\XXX3.2.exe' 'file\X4.2.exe' 'fileX4.1.exe' 'file\X5.2.exe'
