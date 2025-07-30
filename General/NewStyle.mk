# A new style makefile
# using an include directive to force make to execute the clean rule before the other targets are executed.
# usage make -f NewStyle.mk

$(info *** Start reading RestartMake.mk ***)
$(info MAKE_RESTARTS=$(MAKE_RESTARTS))
$(info MAKECMDGOALS=$(MAKECMDGOALS))
$(info MAKEFLAGS=$(MAKEFLAGS))
$(info MAKEFILE_LIST=$(MAKEFILE_LIST))

ifeq "$(filter clean,$(MAKECMDGOALS))" "clean"
  ifeq ($(filter all,$(MAKECMDGOALS)),all)
    $(error The goals 'clean' and 'all' must not be used together. Use goal 'clean-all' instead.)
  endif
endif

# define the shell commands to create the dummy file clean-done.mk
define make-help-file :=
  echo -e '$$(info *** Start reading clean-done.mk ***)\n$$(info MAKEFILE_LIST=$$(MAKEFILE_LIST))\n' > clean-done.mk
endef

ifeq "$(filter clean-all,$(MAKECMDGOALS))" "clean-all"
  $(info Goal 'clean-all' requested!)
  $(shell rm -f clean-done.mk)
else
  $(info Other goal than 'clean-all' requested. Make the file 'clean-done.mk'.)
  $(warning $(shell $(make-help-file)))
endif

# define delete receipt
# No recursive variable expansion is required), thus prefer direct expanded variable flower.
define do-cleanup :=
  @echo 'Cleanup!'
  $(RM) *.o program
endef

# Make all source files
all-numbers := 0 1 2 3 4 5 6 7 8 9 A B C D E F G
src-files := $(foreach i,$(all-numbers),file_$i.xx)
object-files := $(foreach i,$(all-numbers),file_$i.o)
$(info $(src-files))
#$(shell touch $(src-files))

.PHONY: all clean clean-all
all: program

program: $(object-files)
	@echo 'Start making of $@'
	@useCpu.sh 3 $@ ''
	@touch $@
	@echo 'End making $@'

$(object-files): %.o: %.xx
	@echo 'Start making of $@'
	@useCpu.sh 3 $@ ''
	@touch $@
	@echo 'End making $@'

clean:
	$(do-cleanup)

clean-all: all
	@echo 'Executing $@. All done.'

include clean-done.mk

clean-done.mk:
	@echo 'Start making of $@'
	#@$(make-help-file)
	@useCpu.sh 5 $@ ''
	$(do-cleanup)

$(info *** End reading RestartMake.mk ***)