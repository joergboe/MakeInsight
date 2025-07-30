var = -MT"m2.cc" -sa -MD"m2.dd" -MD"m2.d\d"

$(info start file)
$(info $(var))
$(info $(var:"=\"))
$(info $(var:%"=%\"))
$(info $(subst ",\",$(var)))
$(info $(subst ",\",$(subst \,\\,$(var))))

files = $(wildcard testfile*)
$(info $(files))
$(info number of words $(words $(files)))

$(file > xxxxxx,asasdasd)
