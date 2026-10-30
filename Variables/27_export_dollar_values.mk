# Export variables with values containing dollar signs.
#
# Variables from environment or from the command line are considered recursive variables. Thus a
# single dollar symbol starts a variable expansion.
# This means, that dollar symbol must be escaped in environment in variables used in make.
#
# NOTE: Dollar symbols in exported variables which are used in nested make levels are never preserved!
# To preserve dollar symbols in environment variables we must use the value function.
#
# Usage:
# 1)
# make -f 27_export_dollar_values.mk EXT='EXT contains two $$ signs.'
#
# 2)
# EXT='EXT contains two $$ signs.' make -f 27_export_dollar_values.mk
#
# 3)
# export EXT='EXT contains two $$ signs.'
# make -f 27_export_dollar_values.mk

$(info **** MAKELEVEL=$(MAKELEVEL) ****)
SHELL = /bin/bash
.SHELLFLAGS ::= -c

ifeq (0,${MAKELEVEL})
  export FOO =    FOO contains one $$ sign.
  export BAR ::=  BAR contains one $$ sign.
  export BAZ :::= BAZ contains one $$ sign.
  # export FOO BAR BAZ
  $(info Define variables in Make level 0.)
else
  $(info Using variables exported from level 0 in nested Makefile context.)
endif

$(info Read variables in Makefile context.)
$(foreach x,FOO BAR BAZ EXT,\
  $(info $(x) expands to '$($(x))' flavor=$(flavor $x) value='$(value $x)' origin=$(origin $x))\
)

.PHONY : all
all :
	@echo 'Executing rule all. Expanding variables in shell context.'
	@echo "$${FOO}"
	@echo "$${BAR}"
	@echo "$${BAZ}"
	@echo "$${EXT}"
	@declare -p FOO
	@declare -p BAR
	@declare -p BAZ
	-@declare -p EXT
	@echo
ifeq (0,${MAKELEVEL})
	$(MAKE) -f 27_export_dollar_values.mk
endif

$(info )
