# Wrong usage of multiple targets in one rule:
# If a recipe produces more than one target file at once it seems to work at the first place,
# but it fails in case of parallel execution.

# We have:
# C++ module hello.cppm
# The module user main.cpp
# The compiler places the objects into the *.o files
# For module Hello the Module Interface is placed in Hello.pcm

# Usage:
# make -f 48_2_multiple_targets_wrong_usage.mk -j 1
# Seems ok - debug with -d option
# Run rule - hello.o hello.pcm : hello.cppm
# Run rule - main.o : main.cpp hello.pcm
# Run rule - main.out : main.o hello.o' > main.out

# make -f 48_2_multiple_targets_wrong_usage.mk -j 4
# Not what it should be.
# Run rule - hello.o hello.pcm : hello.cppm
# Run rule - hello.o hello.pcm : hello.cppm
# Run rule - main.o : main.cpp hello.pcm
# Run rule - main.out : main.o hello.o' > main.out

# Use a grouped target rule &: in place of the simple rule and try again
# Cleanup:
# make -f 48_2_multiple_targets_wrong_usage.mk clean

ifneq ($(STEP),2)
  $(shell touch hello.cppm)
  $(shell touch main.cpp)
  $(info hello.cppm and main.cpp touched)
  $(info )
endif
 
# Switch off the implicit rules
.SUFFIXES:


main.out: main.o hello.o
	echo '$@ : $^' > $@

main.o: main.cpp hello.pcm
	echo '$@ : $^' > $@

# Simple rule
hello.o hello.pcm: hello.cppm
	echo 'hello.o hello.pcm : $^' > hello.o; echo 'hello.o hello.pcm : $^' > hello.pcm

# Grouped target rule
#hello.o hello.pcm&: hello.cppm

.PHONY: clean
clean:
	rm -fv *.pcm *.o
	rm -fv main.out
	rm -fv hello.cppm main.cpp
