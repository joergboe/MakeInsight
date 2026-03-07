# Convert a list of pathnames
# Absolut pathes into canonicalized absolute name
# Relative pathes into canonicalized relative name if the resolved file name is below the given base directory
# and a canonicalized absolute name otherwise

SHELL = /bin/bash
.SHELLFLAGS ::= -ec

#real_base_path = $(abspath $(foreach dir,$(1),$(if $(patsubst /%,,$(dir)),,$(dir))))$\
	$(shell realpath --relative-base=$2 $(foreach dir,$(1),$(if $(patsubst /%,,$(dir)),$(dir))))$\
	$(if $(subst 0,,$(.SHELLSTATUS)),,$(warning realpath returns failure $(.SHELLSTATUS)))

real_base_path = $(abspath $(foreach dir,$2,$(if $(patsubst /%,,$(dir)),,$(dir))))\
	$(shell realpath --relative-base=$1 -m -s $(foreach dir,$2,$(if $(patsubst /%,,$(dir)),$(dir))))$\
	$(if $(subst 0,,$(.SHELLSTATUS)),$(warning realpath returns failure $(.SHELLSTATUS)))


list = /usr/bin /opt/../usr/bin ./src ../aa/bb/cc /home/joergboe

$(info real_base_path = '$(call real_base_path,/home,$(list))')

target:
