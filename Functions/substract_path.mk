# Remove the leading components from a path

supstract_path = $(patsubst $2/%,%,$1)

p1 = /d1/d2/d3/d4
p2 = /d1/d2
$(info $(p1) - $(p2) = '$(call supstract_path,$(p1),$(p2))')

p1 = /d1/d2/d3/d4
p2 = /d1
$(info $(p1) - $(p2) = '$(call supstract_path,$(p1),$(p2))')

p1 = /d1/d2/d3/d4
p2 = 
$(info $(p1) - $(p2) = '$(call supstract_path,$(p1),$(p2))')

p1 = /d1
p2 = /d1/d2
$(info $(p1) - $(p2) = '$(call supstract_path,$(p1),$(p2))')

p1 = /d1/d2/d3/d4
p2 = /dx/dy
$(info $(p1) - $(p2) = '$(call supstract_path,$(p1),$(p2))')
