# Use and Disable Builtin Rules

# Make has a lot of builtin pattern rules and builtin old-fashioned Suffix Rules.
# See: https://www.gnu.org/software/make/manual/html_node/Implicit-Rules.html

# The build in rule database can be disabled with command line option:
# -r, --no-builtin-rules      Disable the built-in implicit rules.

# You can cancel a built-in implicit rule by defining a pattern rule with the same target
# and prerequisites, but no recipe.
# See: https://www.gnu.org/software/make/manual/html_node/Canceling-Rules.html

# Suffix rules are the old-fashioned way of defining implicit rules for make. Suffix rules are
# obsolete because pattern rules are more general and clearer. They are supported in GNU make
# for compatibility with old makefiles.
# See: https://www.gnu.org/software/make/manual/html_node/Suffix-Rules.html

# Usage:
# Use the default rule database.
# Expected: The executable is build from Hello.c to Hello
# rm Hello
# make -f 59_use_delete_implicit_rules.mk Hello

# Disable pattern rule %: %.c
# Expected: The executable is build from Hello.c to Hello.o to Hello
# The intermediate file Hello.o is deleted.
# rm Hello
# make -f 59_use_delete_implicit_rules.mk Hello DIS_PATT_C=1

# Disable pattern rule %: %.c and %.o: %.c
# Expected: No rule to make target.
# rm Hello
# make -f 59_use_delete_implicit_rules.mk Hello DIS_PATT_C=1 DIS_PATT_CO=1
# Note: No suffix rule comes into play, although the suffix rules .c, .c.o and .o are in the database.
# Check with option -p, --print-data-base

# Disable suffixes .c and .o
# Expected: No rule to make target.
# rm Hello
# make -f 59_use_delete_implicit_rules.mk Hello DIS_SUFF_C_O=1
# Note: The suffix rules .c, .o and .c.o are still in the database, but not effective because
# suffixes .o and .c are removed from the suffix list (target .SUFFIXES)
# The equivalent pattern rules %: %.c, %.o: %c and %: %.o are removed.
# Check with option -p, --print-data-base

# Disable suffix .o and pattern rule %: %.c
# Expected: No rule to make target.
# rm Hello
# make -f 59_use_delete_implicit_rules.mk Hello DIS_SUFF_O=1 DIS_PATT_C=1

# Disable the entire rule database.
# Expected: No rule to make target
# rm Hello
# make -f 59_use_delete_implicit_rules.mk --no-builtin-rules Hello

# Cleanup:
# rm Hello

# Summary:
# 1. If a pattern rule is written without a recipe, the pattern rule and the appropriate suffix rules
# become ineffective.
# 2. If a suffix is deleted from the suffix list, the suffix rules become ineffective and the appropriate
# pattern rules are deleted.

$(info Run Makefile)

ifdef DIS_PATT_C
%: %.c
$(info Patternrule %: %.c disabled.)
endif

ifdef DIS_PATT_O
%: %.o
$(info Patternrule %: %.o disabled.)
endif

ifdef DIS_PATT_CO
%.o: %.c
$(info Patternrule %.o: %.c disabled.)
endif

# All Suffixes:
$(info All builtin SUFFIXES)
$(info $(SUFFIXES))

ifdef DIS_SUFF_O
.SUFFIXES:
.SUFFIXES: $(filter-out .o,$(SUFFIXES))
$(info Suffix .o deleted)
endif

ifdef DIS_SUFF_C_O
.SUFFIXES:
.SUFFIXES: $(filter-out .c,$(filter-out .o,$(SUFFIXES)))
$(info Suffixes .o .c deleted)
endif

$(info )
