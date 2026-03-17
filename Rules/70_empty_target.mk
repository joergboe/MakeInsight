# Rules with empty target are ignored.

# Usage: make -f 70_empty_target.mk
# Expected: Rule 1 and 2 are ignored silently. Rules target and file1 executed.

  : file1
	@echo -e "rule $@\n"

$(empty) : file1
	@echo -e "rule $@\n"

target: file1
	@echo -e "rule $@\n"

file1:
	@echo -e "rule $@\n"
