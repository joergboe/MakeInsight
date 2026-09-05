# Variable and function expansion before pattern matching


# Usage:   make -f 55_2_expansion_and_pattern_apparatus.mk

$(info START reading makefile.)

sources = f1.src f2.src
objects = f1.o f2.o

# build the final target
target : $(objects)
	@echo -e "\n--- run rule $@ : $^ ---"

# rule *.o
$(objects) : %.o $(info Rule *.o : Target %) : %.src $(info rule *.o : Function and variables are evaluated/expanded before the rule applies the pattern. %.o)
	@echo -e "\n--- run rule $@ : $^ ---"
	@echo "pattern stem \$$* : $*"

.SECONDEXPANSION :
# rule *.src
$(sources) : %.src $(info Rule *.src : Target %) : $$(info Rule *.src : Secondary expansion takes place after rule pattern processing. %.src)
	@echo -e "\n--- run rule $@ ---"
	@echo "pattern stem \$$* : $*"

$(info END reading makefile.)
