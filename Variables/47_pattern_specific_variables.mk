# Pattern-specific Variable Values

# usage: make -f 47_pattern_specific_variables.mk

# See: https://www.gnu.org/software/make/manual/html_node/Pattern_002dspecific.html

# In addition to target-specific variable values, GNU make supports pattern-specific variable values. In this form,
# the variable is defined for any target that matches the pattern specified.

#  As with target-specific variable values, multiple pattern values create a pattern-specific variable value for each
# pattern individually. The variable-assignment can be any valid form of assignment. Any command line variable setting
# will take precedence, unless override is specified.

# If a target matches more than one pattern, the matching pattern-specific variables with longer stems are interpreted
# first. This results in more specific variables taking precedence over the more generic ones,


target_var := target.exe
target: file1.oo file2.oo
	@echo "*** Rule - $@ ***"
	@echo "target_var = $(target_var)"
	@echo

%.oo: obj_var = objects
%.oo: %.src header1 header2
	@echo "*** Rule - $@ ***"
	@echo "target_var = $(target_var)"
	@echo "obj_var = $(obj_var)"
	@echo "individually_var = $(individually_var)"
	@echo


%.src: src_var = source
%.src:
	@echo "*** Rule - $@ ***"
	@echo "target_var = $(target_var)"
	@echo "obj_var = $(obj_var)"
	@echo "src_var = $(src_var)"
	@echo "individually_var = $(individually_var)"
	@echo

header1:
	@echo "*** Rule - $@ ***"
	@echo

header2:
	@echo "*** Rule - $@ ***"
	@echo

# Can define target and pattern variables for a target.
obj1.oo: individually_var := obj1.oo
obj2.oo: individually_var := obj2.oo
