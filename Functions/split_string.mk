# demon function
# make -f split_string.mk

comma:= ,
empty:=
space:= $(empty) $(empty)
spaces:= $(empty)   $(empty)
define nl :=


endef

$(info strip)
$(info strip a    b   = '$(strip a      b   )')
$(info strip empty    = '$(strip $(empty))')
$(info strip nl       = '$(strip $(nl))')
$(info )

# call param1, param2
print_param = '$(1)' '$(2)'
$(info parameter)
$(info call print_param,' a ',' b ' = $(call print_param, a , b ))
$(info call print_param,\n'a',\n' b ' = $(call print_param,\
a,\
    b))
pa = a
pb = b
$(info call print_param,'pa' , 'pb' = $(call print_param, $(pa) , $(pb) ))
$(info call print_param,\n'pa',\n'b' = $(call print_param,\
$(pa),\
$(pb)))

$(info )
$(info let)
$(info $(let v1 v2 v3 v4 v5,111 222 333 444 555 666,$(v1) $(v5)))
$(info $(let v1 v2 v3 v4 v5,   111 222 333 444 555 666   ,$(v1) $(v5)))
$(info )

$(info reverse)
reverse = --- $(2) $(1) ----
$(info $(call reverse,55,66))

$(info reverse list)
reverse_list = $(let first rest,$(1),$(if $(rest),$(call reverse_list,$(rest)) )$(first))
$(info $(call reverse_list,11 22 33 44))
$(info pretty reverse list)
pretty_reverse = $(let first rest,$(1),\
                $(if $(rest),$(call pretty_reverse,$(rest)) )$(first))
$(info $(call pretty_reverse,11 22 33 44))

$(info compare equal)
# call eq,param1,param2
# Expands to 'true' if param1 and param2 are equal or to the empty string otherwise
eq = $(if $(subst $(2),,$(1)),,true)
$(info eq 1 2 = $(call eq,1,2))
$(info eq 1 1 = $(call eq,1,1))
$(info eq -- -- = $(call eq,--,--))
$(info eq -- - - = $(call eq,--,- -))

$(info compare not equal)
# call neq,param1,param2
# Expands to 'true' if param1 and param2 are not equal or to the empty string otherwise
neq = $(if $(subst $(2),,$(1)),true)
$(info neq 1 2 = $(call neq,1,2))
$(info neq 1 1 = $(call neq,1,1))
$(info neq -- -- = $(call neq,--,--))
$(info neq -- - - = $(call neq,--,- -))

$(info more)
# call tail,separator,wordlist
# Expands to the rest of the word list that follows the separator word.
tail = $(let first rest,$(2),$(if $(and $(rest),$(call neq,$(1),$(first))),$(call tail,$(1),$(rest)),$(rest)))

teststring1 = -t -j18 --no-silent -- CXX=clang C--14=21
$(info teststring1 = $(teststring1))
$(info tail = $(call tail,--,$(teststring1)))

teststring2 =
teststring3 =  -t -j18 --no-silent
teststring4 =  -t -j18 --no-silent --    #
teststring5 = $(space) -t -j18 --no-silent -- CXX=clang C--14=21$(spaces)
teststring6 = $(comma) -t -j18 --no-silent -- CXX=clang --C--14=21$(comma)53 CXX=g++
teststring7 := $(space)-t -j18 --no-silent -- CXX=clang --C--14=21$(nl)53 CXX=g++
teststring8 := -- CXX=clang --C--14=2153 CXX=g++
teststring9 := --CXX=clang --C--14=2153 CXX=g++
teststring10 =  -t -j18 --no-silent --

$(foreach x,1 2 3 4 5 6 7 8 9 10,\
$(info teststring$(x) = '$(teststring$(x))')\
$(info tail = '$(call tail,--,$(teststring$(x)))'))

$(info --------------)
$(info teststring6 = '$(teststring6)')
$(info tail = '$(sort $(call tail,--,$(teststring6)))')
$(info --------------)

append_separator = $(let first rest,$(2),$(if $(rest),$(first)$(1)$(call append_separator,$(1),$(rest)),$(first)))

ts1 =
ts2 = aa
ts3 = aa bb
ts4 = $(spaces)aa bb$(spaces)
ts5 = aa$(comma) bb cc

$(foreach x,1 2 3 4 5,\
$(info ts$(x) = '$(ts$(x))')\
$(info list = '$(call append_separator,$(comma),$(ts$(x)))'))
