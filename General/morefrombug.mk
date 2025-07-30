# usage env TEST=stuff gmake -f morefrombug.mk
$(warning ${TEST})
$(warning echo $${TEST})
export TEST := blah
$(warning echo $${TEST})
$(export TEST)
$(warning echo $${TEST})
$(export TEST,something else)
$(warning echo $${TEST})
