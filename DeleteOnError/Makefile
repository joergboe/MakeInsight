# Delete on error

# Usage                     Expected result
# > make                    'one' touched; 'two' removed
# > make clean
# > make --keep-going       'one' touched; 'two' removed; 'three' touched
# > make clean
# > make --ignore-errors    'one' touched; 'two' touched; 'three' touched; 'target' touched
# > make clean

# If .DELETE_ON_ERROR is mentioned as a target anywhere in the makefile, then make will delete the
# target of a rule if it has changed and its recipe exits with a nonzero exit status,

target: one two three
	@echo 'Rule $@'
	touch $@

one three:
	@echo 'Rule $@'
	touch $@

two:
	@echo 'Rule $@'
	touch two
	false
	@echo "Should see this only with Make option -i, --ignore-errors"

.PHONY: clean
clean:
	@echo 'Cleanup'
	@rm -vf target one two three

.DELETE_ON_ERROR:
