# Static Pattern Rules
# Escaping rule for %

# Usage:   make -f 51_static_pattern_rules_quoting.mk
# Cleanup: make -f 51_static_pattern_rules_quoting.mk clean

.SUFFIXES:

sources   := foobar%1.src foo\bar\%2.src foo\\bar\\%3.src
sources_t := foobar\%1.src foo\bar\\\%2.src foo\\bar\\\\\%3.src
objects   := $(sources:.src=.o)
objects_t := $(sources_t:.src=.o)

$(info sources = $(sources))
$(info objects = $(objects))
$(info sources_t = $(sources_t))
$(info objects_t = $(objects_t))

$(info )

# build the final target
target : $(objects)
	@echo '--- rule $@ : $^ ---'
	cat $(foreach x,$^,'$(x)') > $@
	@echo

$(objects_t) : %.o : %.src fooconf
	@echo '--- rule $@ : $^ ---'
	@echo 'pattern stem $$* : $*'
	cat $(foreach x,$<,'$(x)') > '$@'
	@echo

# Create the 'source' files
$(sources_t) : %.src:
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
