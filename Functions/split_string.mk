# demon function
# make -f split_string.mk

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
