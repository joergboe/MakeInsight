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
	@echo 'Start $@'
	@echo '4 MAKEFILE_LIST=$(MAKEFILE_LIST)'
	$(info 4 MAKE_RESTARTS=$(MAKE_RESTARTS))
	@useCpu.sh 3 $@ ''
	@touch $@
	@echo -e "End $@\n"
	
$(myobjects): %.o: %.xx
	@echo 'Start $@'
	@echo '3 MAKEFILE_LIST=$(MAKEFILE_LIST)'
	@echo '3 MAKE_RESTARTS=$(MAKE_RESTARTS)'
	@useCpu.sh 3 $@ ''
	@touch $@
	touch helper.mk
	@echo -e "End $@\n"

include helper.mk
$(info 1 MAKEFILE_LIST=$(MAKEFILE_LIST))
$(info 1 MAKE_RESTARTS=$(MAKE_RESTARTS))

helper.mk:
	@echo 'Executing $@'
	@echo '2 MAKEFILE_LIST=$(MAKEFILE_LIST)'
	@echo '2 MAKE_RESTARTS=$(MAKE_RESTARTS)'
	@echo -e '$$(info Start reading helper.mk)\n$$(info X MAKEFILE_LIST=$$(MAKEFILE_LIST))\n$$(info X MAKE_RESTARTS=$$(MAKE_RESTARTS))' > helper.mk
	@useCpu.sh 5 $@ ''
	@echo -e "End $@\n"
