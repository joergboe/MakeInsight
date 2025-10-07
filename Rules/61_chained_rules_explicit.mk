# Targets of chained implicit rules are intermediate by default.
# A file is not intermediate if it is mentioned in the makefile as a target or prerequisite.
# You can explicitly mark a file as intermediate by listing it as a prerequisite of the special
# target .INTERMEDIATE. This takes effect even if the file is mentioned explicitly in some other way. 

# see: https://www.gnu.org/software/make/manual/html_node/Chained-Rules.html

# Usage:
# make -f 61_chained_rules_explicit.mk STEP=1 target
# Expect:
# The target is produced and all object files are deleted.

# Run the produced target:
# make -f 61_chained_rules_explicit.mk run

# Do not touch anything and run make again.
# make -f 61_chained_rules_explicit.mk STEP=2 target
# Expect:
# No rule is fired : make: 'target' is up to date.

# Touch one source file and run make again.
# make -f 61_chained_rules_explicit.mk STEP=3 target
# Expect:
# All object files are re-created and the target is linked.
# All object files are deleted.

# Cleanup:
# make -f 61_chained_rules_explicit.mk clean


ifeq ($(MAKECMDGOALS),target)
  ifeq ($(STEP),1)

define text :=
void greetings1(void);
void greetings2(void);
void greetings3(void);

int main( ) {
	greetings1();
	greetings2();
	greetings3();
	return 0;
}
endef
    $(file > target.c,$(text))
    $(info target.c touched)

define text :=
#include <stdio.h>
void greetings1(void) {
	printf("Hello 1!\n");
}
endef
    $(file > file1.c,$(text))
    $(info file1.c touched)

define text :=
#include <stdio.h>
void greetings2(void) {
	printf("Hello 2!\n");
}
endef
    $(file > file2.c,$(text))
    $(info file2.c touched)

define text :=
#include <stdio.h>
void greetings3(void) {
	printf("Hello 3!\n");
}
endef
    $(file > file3.c,$(text))
    $(info file3.c touched)
  endif

  ifeq ($(STEP),3)
    $(shell touch file2.c)
    $(info touch file2.c)
  endif
endif

# remove buildin rule %: %.c
%: %.c

.INTERMEDIATE: target.o file1.o file2.o file3.o

target: target.o file1.o file2.o file3.o
	$(LINK.o) $^ $(LOADLIBES) $(LDLIBS) -o $@

.PHONY: run
run:
	./target

.PHONY: clean
clean:
	$(RM) target target.c target.o file{1..3}.o file{1..3}.c
