# The targets which .SECONDARY depends on are treated as intermediate files, except
# that they are never automatically deleted.
# .SECONDARY can be used to avoid redundant rebuilds in some unusual situations.

# see: https://www.gnu.org/software/make/manual/html_node/Special-Targets.html#index-special-targets

# see: https://www.gnu.org/software/make/manual/html_node/Chained-Rules.html

# Usage:
# make -f 62_secondary_files.mk STEP=1 target
# Expect:
# The target is produced as usual.

# Run the produced target:
# ./target

# Do not touch anything and run make again.
# make -f 62_secondary_files.mk STEP=2 target
# Expect:
# No rule is fired : make: 'target' is up to date.

# Remove one object file an run make again
# rm file1.o
# make -f 62_secondary_files.mk STEP=2 target
# Expect:
# No rule is fired : make: 'target' is up to date.

# Touch one source file and run make again
# make -f 62_secondary_files.mk STEP=3 target
# Expect:
# object files file1.o and file2.o are re-build
# target is re-build

# Cleanup:
# make -f 62_secondary_files.mk clean


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

.SECONDARY: target.o file1.o file2.o file3.o

target: target.o file1.o file2.o file3.o
	$(LINK.o) $^ $(LOADLIBES) $(LDLIBS) -o $@

.PHONY: run
run:
	./target

.PHONY: clean
clean:
	$(RM) target target.c target.o file{1..3}.o file{1..3}.c
