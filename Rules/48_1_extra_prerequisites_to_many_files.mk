# Multiple Rules for One Target extra prerequisites to many files


# Usage: make -f 48_1_extra_prerequisites_to_many_files.mk # all rules run
#        make -f 48_1_extra_prerequisites_to_many_files.mk # only rule all runs
#        touch f2
#        make -f 48_1_extra_prerequisites_to_many_files.mk # 'result' and 'f2.o' runs
#        touch config1
#        make -f 48_1_extra_prerequisites_to_many_files.mk # 'result', 'f1.o', 'f2.o' and 'f3.o' runs
#        inject another configuration file by setting variable config from the command line
#        echo "config2" > config2
#        make -f 48_1_extra_prerequisites_to_many_files.mk config=config2 # rule result runs only if config2 is newer than result !!
# Cleanup: make -f 48_1_extra_prerequisites_to_many_files.mk clean

objects = f1.o f2.o f3.o
config = config1

.PHONY: all clean

all: result
	@echo "---- run $@ ----"
	cat $<

result: f1.o f2.o f3.o
	@echo "---- run $@ because $? are newer than target ----"
	cat $^ > $@

f1.o: f1
	@echo "---- run $@ ----"
	cat $^ > $@

f2.o: f2
	@echo "---- run $@ ----"
	cat $^ > $@

f3.o: f3
	@echo "---- run $@ ----"
	cat $^ > $@

# see: https://www.gnu.org/software/make/manual/make.html#Multiple-Rules
# An extra rule with just prerequisites can be used to give a few extra prerequisites to many files
# at once. For example, makefiles often have a variable, such as objects, containing a list of all
# the compiler output files in the system being made. An easy way to say that all of them must be
# recompiled if config1 changes:
$(objects): $(config)

f1:
	@echo "---- run $@ ----"
	echo $@ > $@

f2:
	@echo "---- run $@ ----"
	echo $@ > $@

f3:
	@echo "---- run $@ ----"
	echo $@ > $@

config1:
	@echo "---- run $@ ----"
	echo $@ > $@

clean:
	rm -fv result f{1..3} f{1..3}.o config1 config2
