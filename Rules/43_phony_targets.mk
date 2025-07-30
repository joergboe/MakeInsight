# PHONY Targets:

# see: https://www.gnu.org/software/make/manual/make.html#Phony-Targets
# A phony target is one that is not really the name of a file; rather it is just a name for a recipe
# to be executed when you make an explicit request (action goal).
# There are two reasons to use a phony target: to avoid a conflict with a file of the same name, and
# to improve performance.

# Usage:  make -f 43_phony_targets.mk # rule 'target' runs once
#         make -f 43_phony_targets.mk # rule 'target' does not run
#         make -f 43_phony_targets.mk cleanup # rule 'cleanup' runs always
#         make -f 43_phony_targets.mk cleanall # rule 'cleanup' and cleanall run always

# A rule with a normal file target does not run, when the target file is up to date.
target: #clean # A phony target should not be a prerequisite of a real target file
	@echo "--- run rule $@ ---"
	touch $@
	touch cleanup

cleanup:
	@echo "--- run rule $@ ---"
	rm -fv target cleanup

# Because the rm command does not create a file named cleanup, probably no such file will ever exist.
# Therefore, the rm command will be executed every time you say ‘make cleanup’.
# In this example, the clean target will not work properly if a file named cleanup is ever created
# in this directory. Since it has no prerequisites, cleanup would always be considered up to date and
# its recipe would not be executed. To avoid this problem you can explicitly declare the target to be
# phony by making it a prerequisite of the special target .PHONY (see Special Built-in Target Names) as follows:
.PHONY: cleanup

# Phony targets can have prerequisites.
.PHONY: cleanall all clean
# When one phony target is a prerequisite of another, it serves as a subroutine of the other.
# For example, here ‘make cleanall’ will delete more files than 'make cleanup'.
cleanall: cleanup
	@echo "--- run rule $@ ---"
	@echo "Enter more commands to clean here."

# A file target can be the prerequisite of an phony target.
# Now you can say just ‘make all’ to remake a couple of targets.
# Phoniness is not inherited: the prerequisites of a phony target are not themselves phony, unless
# explicitly declared to be so.
all: target

# A phony target should not be a prerequisite of a real target file; if it is, its recipe will be
# run every time make considers that file. As long as a phony target is never a prerequisite of a real
# target, the phony target recipe will be executed only when the phony target is a specified goal.
