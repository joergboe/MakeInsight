# cat_dir - concatenates two directory components and discards dot directory components
# usage: $(call cat_dir,dir1,dir2)
cat_dir = $(if $(subst .,,$1),$\
  $(if $(subst .,,$2),$1/$2,$1)$\
,$\
  $(if $(subst .,,$2),$2)$\
)

$(info d1 d2 = $(call cat_dir,d1,d2))
$(info . d2 = $(call cat_dir,.,d2))
$(info d1 . = $(call cat_dir,d1,.))
$(info . . = $(call cat_dir,.,.))
