# Targets of chained implicit rules are intermediate by default.
# The intermediate files will be cleared by make!
# The secondary files will not be cleared by make!

# see: https://www.gnu.org/software/make/manual/html_node/Chained-Rules.html

# Usage:
# make -f 63_chained_rules_inference.mk STEP=1 target
# Expect:
# The target is produced and all module files are deleted.

# Run the produced target:
# make -f 63_chained_rules_inference.mk run

# Do not touch anything and run make again.
# make -f 63_chained_rules_inference.mk STEP=2 target
# Expect:
# No rule is fired : make: 'target' is up to date.

# Touch one source file and run make again.
# make -f 63_chained_rules_inference.mk STEP=3 target
# Expect:
# file2.o is build.
# module1..module3 rules fired
# target is build

# use with secondary files module1..3
# make -f 63_chained_rules_inference.mk STEP=1 SEC=1 target
# Expect:
# The target is produced and no module files are deleted.

# Do not touch anything and run make again.
# make -f 63_chained_rules_inference.mk STEP=2 SEC=1 target
# Expect:
# No rule is fired : make: 'target' is up to date.

# Touch one source file and run make again.
# make -f 63_chained_rules_inference.mk STEP=3 SEC=1 target
# Expect:
# file2.o is build.
# only module2.rule fires
# target is build

# Cleanup:
# make -f 63_chained_rules_inference.mk clean


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

target: target.o module1 module2 module3
	$(LINK.o) target.o file1.o file2.o file3.o $(LOADLIBES) $(LDLIBS) -o $@

ifndef SEC
.INTERMEDIATE: module1 module2 module3
$(info .INTERMEDIATE: module1 module2 module3)
else
.SECONDARY: module1 module2 module3
$(info .SECONDARY: module1 module2 module3)
endif

# %.o files are mentioned only in pattern rules -> they are intermediate
.NOTINTERMEDIATE: %.o
module%: file%.o
	touch $@

.PHONY: run
run:
	./target

.PHONY: clean
clean:
	$(RM) target target.c target.o file{1..3}.o file{1..3}.c module{1..3}
