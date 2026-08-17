# Order Only Prerequisites

# Order order-only prerequisites are maintained even if the target is up to date.

# Usage: make -f 45_2_order_only_prerequisites.mk
#        rmdir build2
#        make -f 45_2_order_only_prerequisites.mk
# Expected: Directory 'build2' is created and all other files are untouched!

# Cleanup:make -f 45_2_order_only_prerequisites.mk clean

# build the final target
bin/target: build/f1.o build/f2.o build/f3.o | bin
	@echo "--- run rule $@ ---"
	@echo "print the normal prerequisites with \$$^ : $^"
	@echo "print the order only prerequisites with \$$| : $|"
	cat build/f1.o build/f2.o build/f3.o > $@

# create the bin directory
bin:
	@echo "--- run rule $@ ---"
	mkdir $@
	@echo

# Create the 'object files in build directory'
build/f1.o: f1 | build build2
	@echo "--- run rule $@ ---"
	cp $< $@
	@echo

build/f2.o: f2 | build build3
	@echo "--- run rule $@ ---"
	cp $< $@
	@echo

build/f3.o: f3 | build build4
	@echo "--- run rule $@ ---"
	cp $< $@
	
# create the build directory
build:
	@echo "--- run rule $@ ---"
	mkdir $@
	@echo

# NOTE: ‘%’ can match any nonempty substring
build%:
	@echo "--- run rule $@ ---"
	mkdir $@
	@echo

# Create the original files
f1:
	@echo "--- run rule $@ ---"
	echo "Text #1" > $@
	@echo

f2:
	@echo "--- run rule $@ ---"
	echo "Text #2" > $@
	@echo

f3:
	@echo "--- run rule $@ ---"
	echo "Text #3" > $@
	@echo

# cleanup all artifacts
clean:
	rm -fv f{1..3}
	rm -rfv build bin build{2..4}
.PHONY: clean
