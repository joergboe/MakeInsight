# Processing of continuation lines in recipes

# usage: make -f 14_long_line_in_recipe.mk

# see: https://www.gnu.org/software/make/manual/html_node/Splitting-Recipe-Lines.html

# One of the few ways in which make does interpret recipes is checking for a backslash just before the newline.

# The backslash/newline pairs in recipes are not removed. Both the backslash and the newline characters are preserved
# and passed to the shell. How the backslash/newline is interpreted depends on your shell. If the first character of
# the next line after the backslash/newline is the recipe prefix character (a tab by default), then that character
# (and only that character) is removed. Whitespace is never added to the recipe.

all :
	@echo no\
space
	@echo no\
	space
	@echo one \
	space
	@echo one\
	 space
	@echo 'hello \
	world' ; echo "hello \
    world"
