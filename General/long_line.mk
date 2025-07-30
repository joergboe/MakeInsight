# Processing of continuation lines in make syntax

# usage: make -f long_line.mk

var1 = aa bb\
cc dd

var2 = aa bb      \
cc dd

var3 = aa bb\
    cc dd

var4 = aa bb\
\
\
cc dd

$(info var1='$(var1)')
$(info var2='$(var2)')
$(info var3='$(var3)')
$(info var4='$(var4)')
