# Static Pattern Rules
# Escaping rule for % and : character and

# Usage:   make -f 56_static_pattern_rules_quoting1.mk
# Cleanup: make -f 56_static_pattern_rules_quoting1.mk clean

.SUFFIXES:

sources = mod1:f%1.src mod1:f%2.src mod1:f%3.src
objects := $(sources:.src=.o)
$(info objects = $(objects))

# build the final target
target : mod1\:f%1.o mod1\:f%2.o mod1\:f%3.o
	@echo -e "\n--- run rule $@ : $^ ---"
	cat $^ > $@

# Create the 'object files in build directory'
# !!! Can no add a prerequisite with a literal % - % is substituted with the stem
# !!! And \% is interpreted as literal \ followed by a literal %
mod1\:f\%1.o mod1\:f\%2.o mod1\:f\%3.o : %.o : %.src mod1\:conf
	@echo -e "\n--- run rule $@ : $^ ---"
	@echo "pattern stem \$$* : $*"
	cat $^ > $@

# Create the 'source' files
mod1\:f\%1.src mod1\:f\%2.src mod1\:f\%3.src : %.src :
	@echo -e "\n--- run rule $@ ---"
	@echo "pattern stem \$$* : $*"
	echo "Text $@" > $@

mod1\:conf:
	@echo -e "\n--- run rule $@ ---"
	echo "Configuration" > $@

# cleanup all artifacts
clean:
	@echo "--- run rule $@ ---"
	rm -rvf target $(sources) $(objects) mod1:conf
.PHONY: clean
