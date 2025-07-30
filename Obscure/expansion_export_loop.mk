# All variables that are marked as export will also be passed to the shell started by the shell
# function. It is possible to create a variable expansion loop:

# usage: make -f expansion_export_loop.mk [target]

# In this obscure case make will use the value of the variable from the environment provided to make,
# or else the empty string if there was none, rather than looping or issuing an error.
export HI = $(shell echo hi)
all: ; @echo $$HI

# or
export PATH = $(shell echo /xxxxxx:$$PATH)
# better  use a simply-expanded variable here (‘:=’)

target: ; @echo $$PATH

