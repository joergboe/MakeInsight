
SHELL = /bin/bash
.SHELLFLAGS ::= -ec

# Convert a list of path names:
# - Absolut paths into canonicalized absolute name
# - Relative paths 
# -- into canonicalized relative name if the resolved file name is below the given base directory
# -- into a canonicalized absolute name otherwise
# call real_base_path,base_dir,path_names
real_base_path = $(abspath $(foreach dir,$2,$(if $(patsubst /%,,$(dir)),,$(dir))))\
	$(shell realpath --relative-base=$1 -m -s $(foreach dir,$2,$(if $(patsubst /%,,$(dir)),$(dir))))$\
	$(if $(subst 0,,$(.SHELLSTATUS)),$(warning realpath returns failure $(.SHELLSTATUS)))


$(info CURDIR = '$(CURDIR)')
$(info )

list = /usr/bin /opt/../usr/bin ./src ../aa/bb/cc /home/joergboe

$(info list = '$(list)')
$(info real_base_path = '$(call real_base_path,/home,$(list))')

target:
