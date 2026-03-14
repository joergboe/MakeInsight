# Empty lines or lines with spaces in recipes do not trigger a shell process.

# Usage: > make --file=34_empty_recipe_line_one_shell.mk
# Expected: Empty lines are passed to the shell.

SHELL = /bin/bash
.SHELLFLAGS = -cev
$(info SHELL = '$(SHELL)')
$(info .SHELLFLAGS = '$(.SHELLFLAGS)')

.ONESHELL:

target:
	@
			
	     
	echo "\$$0=$$0 \$$-=$$-"
	unknown_command

