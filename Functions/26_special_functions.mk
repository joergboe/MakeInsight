# Special functions : shell, !=, file

# Usage: make -f 26_special_functions.mk

$(info -§1- The shell Function)
# see: https://www.gnu.org/software/make/manual/html_node/Shell-Function.html
# It takes as an argument a shell command and expands to the output of the command.
# The only processing make does on the result is to convert each newline (or carriage-return / newline pair)
# to a single space. If there is a trailing (carriage-return and) newline it will simply be removed.

files := $(shell echo *.mk)
$(info files = '$(files)')
# NOTE: The final newline or carriage-return / newline pair is removed if any.

$(info -§1a- Be careful with recursively expanded variables; these variables are expanded when they are used!)
from_shell = $(shell echo item1; echo -n item2; echo >&2 Shell runs)
$(info Use variable from_shell - from_shell = '$(from_shell)')
$(info Use variable from_shell - from_shell = '$(from_shell)')
# NOTE: The only processing make does on the result is to convert each newline (or carriage-return / newline pair) to a
# single space

#NOTE: see also expansion_export_loop.mk

$(info -§1b- The return result of the shell invokation is in variable .SHELLSTATUS)
$(info .SHELLSTATUS = '$(.SHELLSTATUS)')

$(info -§1c- Unsuccessful program execution.)
wrong := $(shell false)
$(intcmp $(.SHELLSTATUS),0,,$(warning Shell exit status is $(.SHELLSTATUS)))
$(info )

$(info -§2- The assignment !=)
# see: https://www.gnu.org/software/make/manual/html_node/Setting.html
# The shell assignment operator ‘!=’ can be used to execute a shell script and set a variable to its output.

CMD = for X in 1 2 3; do echo item$$X; done
from_shell != $(CMD)
$(info from_shell = '$(from_shell)')
# NOTE: The final newline is removed if any.

$(info -§5a- Now the variable has flavor = '$(flavor from_shell)')

$(info -§5b- The return result of the shell invokation is in variable .SHELLSTATUS)
$(info .SHELLSTATUS = '$(.SHELLSTATUS)')
$(info )

$(info -§3- The file function $$(file op filename[,text]))
# see: https://www.gnu.org/software/make/manual/html_node/File-Function.html

# The file function allows the makefile to write to or read from a file. Two modes of writing are supported:
# overwrite, where the text is written to the beginning of the file and any existing content is lost,
# and append, where the text is written to the end of the file, preserving the existing content.
# In both cases the file is created if it does not exist. It is a fatal error if the file cannot be opened for writing,
# or if the write operation fails.
# The file function expands to the empty string when writing to a file.

# When reading from a file, the file function expands to the verbatim contents of the file, except that the final
# newline (if there is one) will be stripped. Attempting to read from a non-existent file expands to the empty string.

list = item1 item2 item3
empty ::=
space ::= $(empty) $(empty)
define nl ::=


endef

$(info -§3a- Write to file (overwrite) $$(file > file1,$$(list)) '$(file > file1,$(list))')
# NOTE: The text is written verbatim and a final newline is appended.

$(info -§3b- Write list to file (overwrite) and convert to lines $$(file >file2,$$(subst $$(space),$$(nl),$$(list)))\
'$(file >file2,$(subst $(space),$(nl),$(list)))')
# NOTE: The space after op is optional.

$(info -§3c- Write empty list to file (overwrite) $$(file > file3,$$(empty)) '$(file > file3,$(empty))')
# NOTE: A a single newline is written.

$(info -§3d- Write empty file (overwrite) $$(file > file4) '$(file > file4)')
# NOTE Omit parameter text to write an empty file.

$(info -§3e- If a files is opened in append mode, the text is written line by line\
$(foreach v,$(list),$(file >>file5,$(v))))

$(info -§3f- Read from file with operator < $$(file <file1) = '$(file <file1)')
$(info -§3f- Read from file with operator < $$(file <file2) = '$(file <file2)')
# NOTE: The file is read verbatim and a final newline is removed if any.

$(info -§3g- Read from a non existing file yields the empty result $$(file <fileXXX) = '$(file <fileXXX)')

target:
	hexdump -C file1
	hexdump -C file2
	hexdump -C file3
	hexdump -C file4
	hexdump -C file5
	rm file*
