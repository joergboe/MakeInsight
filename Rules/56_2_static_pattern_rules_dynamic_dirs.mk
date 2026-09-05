# Static Pattern Rules - Files are in several directories

# All variables and functions are expanded before the pattern match of the pattern rules is performed.
# Evaluation of automatic variables during the secondary expansion phase is possible.

# Usage:   make -f 56_2_static_pattern_rules_dynamic_dirs.mk
# Expected: directories src1..src3 and build and build/src1.. build/src3 are created and target is built.
# Cleanup: make -f 56_2_static_pattern_rules_dynamic_dirs.mk clean

builddir = build
sources = src1/f1.src src2/f2.src src3/f3.src
objects = $(addprefix $(builddir)/,$(sources:.src=.o))
build_dir_list ::= $(dir $(objects))

$(info sources = $(sources))
$(info objects = $(objects))
$(info build_dir_list = $(build_dir_list))

# build the final target - builddir is already existing
$(builddir)/target: $(objects)
	@echo -e "\n--- run rule $@ : $^ ---"
	cat $^ > $@

# create the 'object files in build directory'
# NOTE: This means every object depends on every build directory.
$(objects) : $(builddir)/%.o : %.src | $(build_dir_list)
	@echo -e "\n--- run rule $@ : $^ ---"
	@echo "pattern stem \$$* : $*"
	cat $^ > $@

# create the 'source' files
.SECONDEXPANSION:
# NOTE: Evaluation of automatic variables during the secondary expansion phase, especially of the target name variable
# $$@, behaves similarly to evaluation within recipes.
$(sources) : %.src : | $$(@D) # The dir function is also possible
	@echo -e "\n--- run rule $@ ---"
	@echo "pattern stem \$$* : $*"
	echo "Text $@" > $@

# create directories
$(build_dir_list) :
	@echo -e "\n--- run rule $@ ---"
	mkdir -p $@

# NOTE: Unlike dir function, variable @D has no trailing slash.
src1 src2 src3 :
	@echo -e "\n--- run rule $@ ---"
	mkdir $@

# cleanup all artifacts
clean :
	rm -rf $(builddir) src{1..3}
.PHONY : clean
