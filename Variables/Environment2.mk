# A make bug:
# $(shell) doesn't have the same environment as a sub-process
# It seems that $(shell) inherits the environment in which the make was started
# The new environment is provided in sub processes in recipes
# Start with:
# > export FOO=foo BAR=bar
# > unset BAZ BAZ2
# Now try :
# make -f Environment.mk
# make --warn-undefined-variables -f Environment.mk
# make --environment-overrides -f Environment.mk

# Variables in make are taken from environment
# The command line option --warn-undefined-variables warns when an undefined variable is referenced
$(info *** variables inherited from environment: ***)
$(info FOO: $(FOO) origin: $(origin FOO))
$(info BAR: $(BAR) origin: $(origin BAR))
$(info BAZ: $(BAZ) origin: $(origin BAZ))
$(info BAZ2: $(BAZ2) origin: $(origin BAZ2))

# Variables from the makefile overwrite normally the inherited values
# The command line option -e, --environment-overrides disables this behavior
FOO := new foo
export BAR := new bar
BAZ := new baz
export BAZ # the export is the same as above
# it works also with the recursive variable flower
export BAZ2 = $(BAZ)

$(info *** now the variables seen from make are: ***)
$(info FOO: $(FOO) origin: $(origin FOO))
$(info BAR: $(BAR) origin: $(origin BAR))
$(info BAZ: $(BAZ) origin: $(origin BAZ))
$(info BAZ2: $(BAZ2) origin: $(origin BAZ2))
# But the variables seen in the $(shell) function are from the original environment
$(info $(shell echo '*** the shell still sees: ***'))
$(info $(shell echo FOO=$$FOO))
$(info $(shell echo BAR=$$BAR))
$(info $(shell echo BAZ=$$BAZ))
$(info $(shell echo BAZ2=$$BAZ2))

all::
	@echo "*** subprocesses see the correct values (exported from make) ***"
	@echo "FOO=$$FOO"
	@echo "BAR=$$BAR"
	@echo "BAZ=$$BAZ"
	@echo "BAZ2=$$BAZ2"
	@echo
	@echo "*** Recursion into the nex make level ***"
	$(MAKE) -f Environment_recursion.mk # Use here variable MAKE. The options are inherited!
