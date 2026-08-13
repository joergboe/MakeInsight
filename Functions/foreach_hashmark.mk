# Hashmark in context of a function.
#
# Usage: make -f foreach_hashmark.mk
#
# Hashmark has no special meaning in a function body.

list = aa bb\#b cc\\\#c

$(info list = $(list))
$(info foreach $(foreach var,$(list),$(var)))

target:;
