# The flowers of variables - Multiline variables.

# Usage:
# make -f 21_variable_flowers_multiline.mk

$(info Recursively Expanded Variables - define y [=])
# Multiline variable definition (or define y =):
xr = foo
define yr
    $(xr)
    bar
endef
$(info expansion of xr - $(xr))
$(info expansion of yr)
$(info $(yr))

xr = later
$(info expansion of xr - $(xr))
$(info expansion of multiline yr)
$(info $(yr))
$(info )

$(info Simply Expanded Variables - define y :=|::=)
xs ::= foo
define ys ::=
    $(xs)
    bar
endef
$(info expansion of xs - $(xs))
$(info expansion of multiline ys)
$(info $(ys))
$(info )
xs ::= later
$(info expansion of xs - $(xs))
$(info expansion of multiline ys)
$(info $(ys))
$(info )


$(info Immediately Expanded Variables define y :::=)
xi :::= one$$two
define yi :::=
    $(xi)
    three$$four
endef
$(info expansion of xi - $(xi))
$(info expansion of multiline yi)
$(info $(yi))

xi :::= three$$four
$(info expansion of xi - $(xi))
$(info expansion of multiline yi)
$(info $(yi))
$(info )
$(info define y :::= leads to a direct expansion of the right hand side and creates a recursive variable flower.)
$(info )

$(info flavors - yr=$(flavor yr) ys=$(flavor ys) yi=$(flavor yi))
$(info )

all:
