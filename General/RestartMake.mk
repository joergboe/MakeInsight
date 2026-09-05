# usage make -f RestartMake.mk

$(info Start reading RestartMake.mk)
$(info 0 MAKEFILE_LIST=$(MAKEFILE_LIST))
$(info 0 MAKE_RESTARTS=$(MAKE_RESTARTS))
$(info 0 MAKECMDGOALS=$(MAKECMDGOALS))
$(info 0 MAKEFLAGS=$(MAKEFLAGS))

all-numbers := 0 1 2 3 4
myfiles := $(foreach i,$(all-numbers),file_$i.xx)
myobjects := $(foreach i,$(all-numbers),file_$i.o)
$(info $(myfiles))
$(shell touch $(myfiles))

.PHONY: all
all: program
	@echo 'Executing $@'

program: $(myobjects) helper.mk
	@echo 'Executing $@'
	@./useCpu.sh -i $@ 3
	@touch $@
	@echo -e "End $@\n"
	
$(myobjects): %.o: %.xx
	@echo 'Executing $@'
	@./useCpu.sh -i $@ 3
	@touch $@
	touch helper.mk
	@echo -e "End $@\n"

include helper.mk
$(info 1 MAKEFILE_LIST=$(MAKEFILE_LIST))
$(info 1 MAKE_RESTARTS=$(MAKE_RESTARTS))

helper.mk:
	@echo 'Executing $@'
	@echo -e '$$(info Start reading helper.mk)\n$$(info X MAKEFILE_LIST=$$(MAKEFILE_LIST))\n$$(info End reading helper.mk)' > helper.mk
	@./useCpu.sh -i $@ 5
	@echo -e "End $@\n"

.PHONY: clean
clean:
	rm -f $(myfiles) $(myobjects) program helper.mk