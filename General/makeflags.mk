# MAKEFLAGS
# usage make -f makeflags.mk -st --no-silent -j16 all clean CYY-jC=4

$(info MAKEFLAGS='$(MAKEFLAGS)' origin=$(origin MAKEFLAGS) flavor=$(flavor MAKEFLAGS))
$(info MFLAGS='$(MFLAGS)' origin=$(origin MFLAGS) flavor=$(flavor MFLAGS))
$(info wrong evaluation:)
$(info option s=$(findstring s,$(MFLAGS)))
$(info option t=$(findstring t,$(MFLAGS)))

$(info better like this:)
$(info $(firstword -$(MAKEFLAGS)))
$(info option s=$(findstring s,$(firstword $(MAKEFLAGS))))
$(info option t=$(findstring t,$(firstword $(MAKEFLAGS))))
ifeq (s,$(findstring s,$(firstword -$(MAKEFLAGS))))
  silent_mode = 1
endif
$(info silent_mode=$(silent_mode))

$(info filter argument variables:)
$(info firstword $(firstword -$(MAKEFLAGS)))
$(info makeflags $(MAKEFLAGS))
$(info find -j   $(findstring -j,$(MAKEFLAGS)))
$(info filter -j $(filter -j%, $(MAKEFLAGS)))
$(info comb      $(findstring -j,$(filter -j%, $(MAKEFLAGS))))
$(info filter -% $(filter -%, $(MAKEFLAGS)))
$(info find --   $(findstring --,$(MAKEFLAGS)))
$(info patsu -- xxx $(patsubst --,xxx,$(MAKEFLAGS)))
$(info patsu -% xxx $(patsubst -%,xxx,$(MAKEFLAGS)))
$(info )
$(info realcheck)
$(info find -j filter -% : $(findstring -j,$(filter -%,$(MAKEFLAGS))))
$(info first filter-out --% $())
$(info )
single_make_options = $(firstword $(MAKEFLAGS))
$(info single_make_options = '$(single_make_options)')
$(info single_make_options = 'filter-out -% '$(filter-out -%,$(single_make_options))')
$(info single_make_options = 'filter %=%    '$(filter %=%,$(single_make_options))')
$(info single_make_options = 'filter %=%    '$(filter %=,$(MAKEFLAGS))')
$(info single_make_options = 'filter %=%    '$(filter =%,$(MAKEFLAGS))')

$(info ssss $(firstword -$(MAKEFLAGS)))

filter_cmd_line_options =
$(info filter=$(filter var% ,$(MAKEFLAGS)))

$(info )
$(info MAKECMDGOALS='$(MAKECMDGOALS)' origin=$(origin MAKECMDGOALS) flavor=$(flavor MAKECMDGOALS))
$(info lastword=$(lastword $(MAKECMDGOALS)))
$(info )
$(info MAKEFILE_LIST=$(lastword $(MAKEFILE_LIST)))
$(info )
$(info END!)
