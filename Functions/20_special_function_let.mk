# Special function let
# make -f 20_special_function_let.mk

comma:= ,
empty:=

$(info -§1- The let Function - $$(let var [var ...],[list],text))
# See: https://www.gnu.org/software/make/manual/html_node/Let-Function.html
mylist := 111 222 333 444 555 666
$(info mylist = $(mylist))
$(info )

$(info -§1a- Assign mylist to var1, var2 and rest =\
$(let var1 var2 rest,$(mylist),var1 = $(var1) var2 = $(var2) rest = $(rest)))
$(info )

$(info -§1b- Iterate recursively through a list =\
$(let first rest,$(mylist),$(first) $(let first rest,$(rest),$(first) ...)))
$(info )

$(info -§1c- Flavor of local variables is simple expanded)
$(let v1 v2,aa bb cc,$(info type v1 = $(flavor v1) type v2 = $(flavor v2)))
$(info )

$(info -§1d- Variables v1, v2 and v3 are stripped but spaces in rest are are preserved! =\
$(let v1 v2 v3 rest,   111   222	333    444   555	666   ,'$(v1)' '$(v2)' '$(v3)' '$(rest)'))
$(info )

$(info -§1e- Empty list yields empty vars $(let v1 v2 rest,$(empty),v1='$(var1)' v2='$(var2)' rest='$(rest)'))
$(info )

$(info -§1f- Empty list yields flavors $(let v1 v2 rest,$(empty),v1 $(flavor v1) v2 $(flavor v2) rest $(flavor rest)))
$(info )

# Error in GNU Make 4.4.1: make: *** virtual memory exhausted
$(info -§1g- Spaces in list $(let v1 rest, ,'$(v1)' '$(rest)'))
$(info )

target:
