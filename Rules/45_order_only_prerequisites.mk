# Order Only Prerequisites

# see: https://www.gnu.org/software/make/manual/make.html#Prerequisite-Types
# There are two different types of prerequisites understood by GNU make: normal prerequisites, described in the previously,
# and order-only prerequisites. A normal prerequisite makes two statements:
# first, it imposes an order in which recipes will be invoked: the recipes for all prerequisites of a target will be completed
# before the recipe for the target is started.
# Second, it imposes a dependency relationship: if any prerequisite is newer than the target, then the target is
# considered out-of-date and must be rebuilt.
#
# Normally, this is exactly what you want: if a target’s prerequisite is updated, then the target should also be updated.
#
# Occasionally you may want to ensure that a prerequisite is built before a target, but without forcing the target to be updated
# if the prerequisite is updated. Order-only prerequisites are used to create this type of relationship.

# A rule with Order Only Prerequisites look like:
# targets : normal-prerequisites | order-only-prerequisites

# Example:
# Consider an example where your targets are to be placed in a separate directory, and that directory might not
# exist before make is run. In this situation, you want the directory to be created before any targets are placed into
# it but, because the timestamps on directories change whenever a file is added, removed, or renamed, we certainly don’t
# want to rebuild all the targets whenever the directory’s timestamp changes.

# Usage: make -f 45_order_only_prerequisites.mk
# Cleanup:make -f 45_order_only_prerequisites.mk clean

# build the final target
build/target: build/f1.o build/f2.o build/f3.o | build
	@echo "--- run rule $@ ---"
	@echo "print the normal prerequisites with \$$^ : $^"
	@echo "print the order only prerequisites with \$$| : $|"
	cat build/f1.o build/f2.o build/f3.o > $@

# create the build directory
build:
	@echo "--- run rule $@ ---"
	mkdir $@

# Create the 'object files in build directory'
build/f1.o: f1 | build
	@echo "--- run rule $@ ---"
	cp $< $@

build/f2.o: f2 | build
	@echo "--- run rule $@ ---"
	cp $< $@

build/f3.o: f3 | build
	@echo "--- run rule $@ ---"
	cp $< $@

# Create the original files
f1:
	@echo "--- run rule $@ ---"
	echo "Text #1" > $@

f2:
	@echo "--- run rule $@ ---"
	echo "Text #2" > $@

f3:
	@echo "--- run rule $@ ---"
	echo "Text #3" > $@

# cleanup all artifacts
clean:
	rm -rfv f{1..3} build
.PHONY: clean
