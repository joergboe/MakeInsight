# Empty lines or lines with spaces in recipes do not trigger a shell process.

# Usage: > make --file=33_empty_recipe_line.mk
# Expected: The unknown_programm is attempted only once in line # $@...
#           Empty line and lies with spaced only are skipped.

SHELL = /bin/bash
$(info SHELL = '$(SHELL)')
$(info .SHELLFLAGS = '$(.SHELLFLAGS)')

target:
	
			
	     
	# $@ : First line that does not contain only spaces.
	unknown_programm
