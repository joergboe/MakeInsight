# Chained rules and a prerequisite is not always updated

# Create a source and build target
# > touch source
# > make -f 90_targets_not_updated.mk
# Expect:
# Run rules stage1, stage2 and target

# Update source and build target
# > touch source
# > make -f 90_targets_not_updated.mk
# Expect:
# Run rules stage1, stage2 and target

# Update source and build target - Now stage2 is not updated
# > touch source
# > NO_UPDATE=1 make -f 90_targets_not_updated.mk
# Expect:
# Run rule stage1 and stage2
# NOTE: Rule for target does not run!

# Do not update source and build target - Now stage2 is not updated
# > NO_UPDATE=1 make -f 90_targets_not_updated.mk
# Expect:
# Run rule stage2
# NOTE: rule2 runs even if nothing has changed!

# Cleanup:
# > make -f 90_targets_not_updated.mk clean

target: stage2
	touch $@

stage2: stage1
	@if [ -z "$${NO_UPDATE}" ]; then echo touch $@; touch $@; else echo "Do not touch $@"; fi

stage1: source
	touch $@


.PHONY: clean
clean:
	rm -f target stage2 stage1 source
