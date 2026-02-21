# How make Processes a Makefile

# see: https://www.gnu.org/software/make/manual/make.html#How-Make-Works

# By default, make starts with the first target (not targets whose names start with ‘.’ unless they also contain one
# or more ‘/’). This is called the default goal.
# Goals are the targets that make strives ultimately to update.
# You can override this behavior using the command line or with the .DEFAULT_GOAL special variable.

# The other rules are processed because their targets appear as prerequisites of the goal.
# If some other rule is not depended on by the goal (or anything it depends on, etc.), that rule is not processed,
# unless you tell make to do so (with a command such as make -f 01_makefile_processing.mk target2).

# Usage: make -f 01_makefile_processing.mk
# Rule target1 and the prerequisites 11..13 are triggered

# Usage: make -f 01_makefile_processing.mk target2
# Rule target2 and the prerequisites 21..22 are triggered

target1: prerequisite11 prerequisite12 prerequisite13
	@echo 'Rule target1'

prerequisite11:
	@echo 'Rule prerequisite11'

prerequisite12:
	@echo 'Rule prerequisite12'

prerequisite13:
	@echo 'Rule prerequisite13'

target2: prerequisite21 prerequisite22
	@echo 'Rule target2'

prerequisite21:
	@echo 'Rule prerequisite21'

prerequisite22:
	@echo 'Rule prerequisite22'

# If a prerequisite does not exists and there is no rule with this prerequisite as target
# make reports an error and exits
# Usage: make -f 01_makefile_processing.mk target3

target3: no_rule
