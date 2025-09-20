# Static Pattern Rules

# Usage:   make -f 50_static_pattern_rules_quoting.mk
# Cleanup: make -f 50_static_pattern_rules_quoting.mk clean

.SUFFIXES:

sources := foobar1.src foo\bar2.src foo\\bar3.src
objects := $(sources:.src=.o)
$(info sources = $(sources))
$(info objects = $(objects))
$(info )

# build the final target
target : $(objects)
	@echo '--- rule $@ : $^ ---'
	cat $(foreach x,$^,'$(x)') > $@
	@echo

$(objects) : %.o : %.src fooconf
	@echo '--- rule $@ : $^ ---'
	@echo 'pattern stem $$* : $*'
	cat $(foreach x,$<,'$(x)') > '$@'
	@echo

# Create the 'source' files
$(sources) : %.src:
	@echo '--- rule $@ ---'
	@echo 'pattern stem $$* : $*'
	echo 'Text $@' > '$@'
	@echo

fooconf:
	@echo '--- run rule $@ ---'
	echo 'Configuration' > $@
	@echo

.PHONY: clean
clean:
	rm -rvf target fooconf
	rm -rvf $(foreach x,$(sources),'$(x)')
	rm -rvf $(foreach x,$(objects),'$(x)')
