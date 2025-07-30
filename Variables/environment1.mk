# A running make script inherits all variables from the environment.
# Additionally you can add variables to the environment with the make command.
# Try the script with the following command sequence:
# > export FOO=foo
# > BAR=bar make -f environment1.mk BAZ=baz

# Check whether the variables are available:
$(info variables from the environment or command line:)
$(info FOO=$(FOO) origin=$(origin FOO) flavor=$(flavor FOO))
$(info BAR=$(BAR) origin=$(origin BAR) flavor=$(flavor BAR))
$(info BAZ=$(BAZ) origin=$(origin BAZ) flavor=$(flavor BAZ))
$(info  )

VARS1 := vars1
VARR1 =  varr1
# Both variants of export have the same effect.
VARS2 := vars2
export VARS2
export VARR2 = varr2 and $(VARS1)

$(info now we check makefile generated variables:)
$(info VARS1=$(VARS1) origin=$(origin VARS1) flavor=$(flavor VARS1))
$(info VARR1=$(VARR1) origin=$(origin VARR1) flavor=$(flavor VARR1))
$(info VARS2=$(VARS2) origin=$(origin VARS2) flavor=$(flavor VARS2))
$(info VARR2=$(VARR2) origin=$(origin VARR2) flavor=$(flavor VARR2))
$(info )

# and finally default variables generated from make program
$(info default variables:)
$(info CC=$(CC) origin=$(origin CC) flavor=$(flavor CC))
$(info CXX=$(CXX) origin=$(origin CXX) flavor=$(flavor CXX))
# change value of a default variable but do not export
CXX = clang
$(info CXX=$(CXX) origin=$(origin CXX) flavor=$(flavor CXX) after change of CXX)
$(info )

all:
	@-for X in FOO BAR BAZ VARS1 VARR1 VARS2 VARR2 CC CXX; do declare -p $$X; done
	$(MAKE) -f environment1_rec.mk
