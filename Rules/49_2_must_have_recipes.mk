# Rules with Grouped Targets

# see: https://www.gnu.org/software/make/manual/make.html#Multiple-Rules

# Unlike independent targets, a grouped target rule must include a recipe. However, targets that are 
# members of a grouped target may also appear in independent target rule definitions that do not have recipes.

# Usage  : make -f 49_2_must_have_recipes.mk
#          49_2_must_have_recipes.mk:21: *** grouped targets must provide a recipe.  Stop.

res1 res2 res3&: f1
	@echo -e "\n---- run res1 res2 res3 ----"
	@echo "Triggered by \$$@: $@"
	echo "$^ used for generating: res1" > res1
	cat $^ >> res1
	echo "$^ used for generating: res2" > res2
	cat $^ >> res2
	echo "$^ used for generating: res3" > res3
	cat $^ >> res3

res1 res2 res3&: f2
