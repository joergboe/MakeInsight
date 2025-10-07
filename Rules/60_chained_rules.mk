# Targets of chained implicit rules are intermediate by default.
# The object files will be cleared by make!

# see: https://www.gnu.org/software/make/manual/html_node/Chained-Rules.html

# Usage:
# make -f 60_chained_rules.mk target
# Expect:
# The target is produced and the object file target.o is deleted.

# Run the produced target:
# make -f 60_chained_rules.mk run

# Do not touch anything and run make again.
# make -f 60_chained_rules.mk STEP=2 target
# Expect:
# No rule is fired : make: 'target' is up to date.

# Listing a file as a prerequisite of the special target .NOTINTERMEDIATE
# forces it to not be considered intermediate.
# make -f 60_chained_rules.mk STEP=2 NOTI=1 target
# Expect:
# The object file and the target are re-created and the object is not deleted.

# Cleanup:
# make -f 60_chained_rules.mk clean


define text :=
#include <stdio.h>
int main(int argc, char* argv[]) {
	printf("Hello world!\n");
	return 0;
}

endef

ifeq ($(MAKECMDGOALS),target)
  ifneq ($(STEP),2)
    $(file > target.c,$(text))
    $(info target.c touched)
  endif
endif

ifdef NOTI
.NOTINTERMEDIATE: %.o
endif

# remove buildin rule %: %.c
%: %.c

.PHONY: run
run:
	./target

.PHONY: clean
clean:
	$(RM) target target.c target.o
