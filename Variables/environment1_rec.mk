# Second makefile for environment1.mk
$(info )
$(info Now we are in a recursive context)
$(info MAKELEVEL=$(MAKELEVEL))
$(info MAKEFILE_LIST=$(MAKEFILE_LIST))

# Check whether the variables are available:
$(info Variables from the environment or command line:)
$(info The origin is preserved)
$(info FOO=$(FOO) origin=$(origin FOO) flavor=$(flavor FOO))
$(info BAR=$(BAR) origin=$(origin BAR) flavor=$(flavor BAR))
$(info BAZ=$(BAZ) origin=$(origin BAZ) flavor=$(flavor BAZ))
$(info  )

$(info now we check makefile generated variables:)
$(info Non exported variables are undefined.)
$(info Flavor of simple variables has changed!)
$(info VARS1=$(VARS1) origin=$(origin VARS1) flavor=$(flavor VARS1))
$(info VARR1=$(VARR1) origin=$(origin VARR1) flavor=$(flavor VARR1))
$(info VARS2=$(VARS2) origin=$(origin VARS2) flavor=$(flavor VARS2))
$(info VARR2=$(VARR2) origin=$(origin VARR2) flavor=$(flavor VARR2))
$(info )

# and finally default variables generated from make program
$(info default variables:)
$(info CC=$(CC) origin=$(origin CC) flavor=$(flavor CC))
$(info Changes of default variables in the calling makefile are not propagated if not exported)
$(info CXX=$(CXX) origin=$(origin CXX) flavor=$(flavor CXX))
#CXX = clang
#$(info CXX=$(CXX) origin=$(origin CXX) flavor=$(flavor CXX) after change of CXX)
$(info )

all:
	@echo $(CXX)
