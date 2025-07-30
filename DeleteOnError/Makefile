# If .DELETE_ON_ERROR is mentioned as a target anywhere in the makefile, then make will delete the
# target of a rule if it has changed and its recipe exits with a nonzero exit status,

all: one two three
	@echo all
	@touch all

one three:
	@echo $@
	touch one
	touch three
	
two:
	@echo $@
	touch two
	false
	@echo "Should not see this"

.PHONY: clean
clean:
	@echo 'Cleanup'
	@rm -vf all one two three

.DELETE_ON_ERROR:
