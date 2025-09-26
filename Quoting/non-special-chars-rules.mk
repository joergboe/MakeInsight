# Use of characters non special to make in targets and prerequisites

# Usage:
# Demonstration of rules to generates files with non special characters
# make -f non-special-chars-rules.mk

# Check that all files are recognized as up to date: Nothing to be done for 'all'.
# make -f non-special-chars-rules.mk

# Show the generated files
# make -f non-special-chars-rules.mk show

# Cleanup
# make -f non-special-chars-rules.mk clean

ifneq (,$(findstring show,$(MAKECMDGOALS)))
  notspecialfiles1 := $(wildcard filensp*)
  notspecialfiles2 := $(wildcard filebnsp*nb)
  notspecialfiles3 := $(wildcard filebnsp*nbb*)
  notspecialfiles4 := $(wildcard filenope*)
  $(info Number of files found: $(words $(allfiles)))
  $(info )
  $(info Files with non special chars:)
  $(info $(notspecialfiles1))
  $(info )
  $(info Files with non special chars preceeded by a \ :)
  $(info N preceding backslashes represents N backslashes)
  $(info $(notspecialfiles2))
  $(info $(notspecialfiles3))
  $(info )
  $(info Ther no such thing as :)
  $(info $(notspecialfiles4))
  $(info )
endif

#.POSIX:
.SUFFIXES:
.PHONY: all show
all: notspecial notspecial2 nope

show:

# characters with no special meaning to make
.PHONY: notspecial
notspecial: filensp@n filensp&n& filensp!n filensp+n filensp-n filensp_n filensp<n filensp>n filensp~n\
            filensp"n filensp'n filensp,n filensp.n filensp(n filensp)n filensp{n filensp}n
filensp@n:
	# Characters with no special meaning to make:
	# Some characters have special meaning to the shell and thus must be quoted in receipts.
	touch $@
filensp&n& :
	touch '$@' # shell metacharacter; At least one space between & and : required!
filensp!n:
	touch $@ # shell reserved word
filensp+n:
	touch $@
filensp-n:
	touch $@
filensp_n:
	touch $@
filensp<n:
	touch '$@' # shell metacharacter
filensp>n:
	touch '$@' # shell metacharacter
filensp~n:
	touch '$@' # ~ has special meaning at the beginning of a name
filensp"n:
	touch '$@' # ! shell quoting with ''
filensp'n:
	touch "$@" # ! shell quoting with ""
filensp,n:
	touch $@
filensp.n:
	touch $@
filensp(n:
	touch '$@' # shell metacharacter
filensp)n:
	touch '$@' # shell metacharacter
filensp{n:
	touch $@ # shell reserved word
filensp}n:
	touch $@ # shell reserved word
	@echo

# characters with no special meaning to make preceded by a slash
.PHONY: notspecial2
notspecial2: filebnsp\@nb filebnsp\\@nbb filebnsp\\\@nbbb\
             filebnsp\&nb filebnsp\!nb filebnsp\+nb filebnsp\-nb filebnsp\_nb\
             filebnsp\<nb filebnsp\>nb filebnsp\~nb filebnsp\"nb filebnsp\'nb filebnsp\,nb filebnsp\.nb\
             filebnsp\(nb filebnsp\)nb filebnsp\{nb filebnsp\}nb
filebnsp\@nb:
	# Characters with no special meaning to make
	# Preceding backslashes go unmolested - N preceding backslashes represents N backslashes
	touch '$@'
filebnsp\&nb:
	touch '$@'
filebnsp\!nb:
	touch '$@'
filebnsp\+nb:
	touch '$@'
filebnsp\-nb:
	touch '$@'
filebnsp\_nb:
	touch '$@'
filebnsp\<nb:
	touch '$@'
filebnsp\>nb:
	touch '$@'
filebnsp\~nb:
	touch '$@' # ~ has special meaning at the beginning of a name
filebnsp\"nb:
	touch '$@'
filebnsp\'nb:
	touch "filebnsp\\'nb" # in shellstrings quoted with ".." a backslash must be quoted with a single backslash
filebnsp\,nb:
	touch '$@'
filebnsp\.nb:
	touch '$@'
filebnsp\(nb:
	touch '$@'
filebnsp\)nb:
	touch '$@'
filebnsp\{nb:
	touch '$@'
filebnsp\}nb:
	touch '$@'
	@echo
filebnsp\\@nbb:
	touch '$@'
filebnsp\\\@nbbb:
	touch '$@'
	@echo

.PHONY: nope
nope: filenope\t1 filenope\n2
filenope\t1:
	# Escape sequences \t and \n are not interpreted as tab or newline!
	touch '$@'
filenope\n2:
	touch '$@'


.PHONY: clean
clean:
	rm -fv filensp* filebnsp* filenope*
