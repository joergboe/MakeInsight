# MAKEFLAGS
# usage make -f makeflags2.mk -st --no-silent -j16 all clean CYY-jC=4

$(info MAKEFLAGS='$(MAKEFLAGS)' origin=$(origin MAKEFLAGS) flavor=$(flavor MAKEFLAGS))
$(info MFLAGS='$(MFLAGS)' origin=$(origin MFLAGS) flavor=$(flavor MFLAGS))

$(info firstword - '$(firstword -$(MAKEFLAGS))') - the - is significant!
$(info find s      '$(findstring s,$(firstword -$(MAKEFLAGS)))')
$(info filter -j%j '$(filter -j%,$(MAKEFLAGS))')
$(info filter -j%j '$(filter -j%,$(MFLAGS))')

$(info )
$(info END!)
