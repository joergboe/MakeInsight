# Target-specific Variable Values

# usage: make -f 45_target_specific_variables.mk

# See: https://www.gnu.org/software/make/manual/html_node/Target_002dspecific.html

# Variable values in make are usually global; that is, they are the same regardless of where they are evaluated.
# Exceptions to that are variables defined with the let function or the foreach function and automatic variables.

# Another exception are target-specific variable values. This feature allows you to define different values for the same
# variable, based on the target that make is currently building. As with automatic variables, these values are only
# available within the context of a target’s recipe (and in other target-specific assignments).

# Target-specific variable assignments can be prefixed with any or all of the special keywords export, unexport,
# override, or private; these apply their normal behavior to this instance of the variable only.

# A target-specific variable that variable value is also in effect for all prerequisites of this target, and all their
# prerequisites, etc. (unless those prerequisites override that variable with their own target-specific variable value)

# Be aware that a given prerequisite will only be built once per invocation of make, at most. If the same file is a
# prerequisite of multiple targets, and each of those targets has a different value for the same target-specific variable,
# then the first target to be built will cause that prerequisite to be built and the prerequisite will inherit the
# target-specific value from the first target. It will ignore the target-specific values from any other targets.

global_var = Global variables are visible from the point of definition

private private_var = A global variable marked private will be visible in the global scope but will not be inherited by any\
 target, and hence will not be visible in any recipe.

$(info global_var = $(global_var))
$(info late_var = $(late_var))
$(info private_var = $(private_var))
$(info )

target: target_var = target.exe A target-specific variable that variable value is also in effect for all prerequisites\
of this target, and all their prerequisites, etc.

target: private private_target_var := Any variable marked private will be visible to its local target but will not be\
inherited by prerequisites of that target.

target: obj1 obj2
	@echo "*** Rule - $@ ***"
	@echo "target_var = $(target_var)"
	@echo "obj_var = $(obj_var)"
	@echo "src_var = $(src_var)"
	@echo "header_var = $(header_var)"
	@echo "global_var = $(global_var)"
	@echo "late_var = $(late_var)"
	@echo "private_var = $(private_var)"
	@echo "private_target_var = $(private_target_var)"
	@echo

obj1: obj_var = obj1.o
obj1: src1 header1 header2
	@echo "*** Rule - $@ ***"
	@echo "target_var = $(target_var)"
	@echo "obj_var = $(obj_var)"
	@echo "src_var = $(src_var)"
	@echo "header_var = $(header_var)"
	@echo "private_target_var = $(private_target_var)"
	@echo

obj2: obj_var = obj2.o
obj2: src2 header1 header2
	@echo "*** Rule - $@ ***"
	@echo "target_var = $(target_var)"
	@echo "obj_var = $(obj_var)"
	@echo "src_var = $(src_var)"
	@echo "header_var = $(header_var)"
	@echo

src1: src_var = src1.cc
src1:
	@echo "*** Rule - $@ ***"
	@echo "target_var = $(target_var)"
	@echo "obj_var = $(obj_var)"
	@echo "src_var = $(src_var)"
	@echo "header_var = $(header_var)"
	@echo

src2: src_var = src2.cc
src2:
	@echo "*** Rule - $@ ***"
	@echo "target_var = $(target_var)"
	@echo "obj_var = $(obj_var)"
	@echo "src_var = $(src_var)"
	@echo "header_var = $(header_var)"
	@echo

header1: header_var = header1.h
header1:
	@echo "*** Rule - $@ ***"
	@echo "target_var = $(target_var)"
	@echo "obj_var = $(obj_var)"
	@echo "src_var = $(src_var)"
	@echo "header_var = $(header_var)"
	@echo "common_header_var = $(common_header_var)"
	@echo

header2: header_var = header2.h
header2:
	@echo "*** Rule - $@ ***"
	@echo "target_var = $(target_var)"
	@echo "obj_var = $(obj_var)"
	@echo "src_var = $(src_var)"
	@echo "header_var = $(header_var)"
	@echo "common_header_var = $(common_header_var)"
	@echo

# Multiple target values create a target-specific variable value for each member of the target list individually.
header1 header2: common_header_var := Multiple target values create a target-specific variable value for each member of the target list individually.

late_var = If a variable is not (yet) defined it expands to the empty string.
