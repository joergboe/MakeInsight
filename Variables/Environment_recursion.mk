# Second makefile for Environment.mk
$(info )
$(info Now we are in a recursive context)
$(info MAKEFILE_LIST=$(MAKEFILE_LIST))
$(info *** variables inherited from environment: ***)
$(info FOO: $(FOO) origin: $(origin FOO))
$(info BAR: $(BAR) origin: $(origin BAR))
$(info BAZ: $(BAZ) origin: $(origin BAZ))
$(info BAZ2: $(BAZ2) origin: $(origin BAZ2))

FOO := newer foo
export BAR := newer bar
export BAZ := newer baz
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

recursion::
	@echo "*** subprocesses see the correct values (exported from make) also in recursions ***"
	@echo "FOO=$$FOO"
	@echo "BAR=$$BAR"
	@echo "BAZ=$$BAZ"
	@echo "BAZ2=$$BAZ2"
