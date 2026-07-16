# Function eval

# Usage: make -f 40_eval_function.mk

# See: https://www.gnu.org/software/make/manual/html_node/Eval-Function.html

# The eval function is very special: it allows you to define new makefile constructs that are not constant; which are
# the result of evaluating other variables and functions. The argument to the eval function is expanded, then the
# results of that expansion are parsed as makefile syntax. The expanded results can define new make variables, targets,
# implicit or explicit rules, etc.

# The result of the eval function is always the empty string; thus, it can be placed virtually anywhere in a makefile
# without causing syntax errors.

# The eval argument is expanded twice; first by the eval function, then the results of that expansion are expanded again
# when they are parsed as makefile syntax. This means you may need to provide extra levels of escaping for “$”
# characters when using eval.

# In function context special characters ;|:#\ and sometimes , go unmolested through.
text = 4 symbols $$$$$$$$ - 2 symbols $$$$ - 1 symbol $$ ;,|: \\\\\# 2 bs+hm \\\# 1 bs+hm \# hm # teststring
$(info $(value text))

$(eval $(info $(text))) # nothing to eval - info function expands to nothing - text is expanded once

$(eval $$(info $$(text))) # eval $(info $(text)) - text is expanded once

$(eval $$(info $(text))) # eval $(info 4 symbols ...) - text is expanded twice

# The value function prevents one level of expansion if text is a Recursively Expanded Variable.
$(eval $$(info $(value text))) # eval $(info 4 symbols ...) - text is expanded once
$(info )

text = Dollar $$ must be escaped twice; paranteses must match (in this example); and braches may not match{; \
comma, is possible; \# precede hashmark with bs; \\\# backslash hashmark must follow quoting rule; \
the literal function name $$(hsm);

$(info Escape $$ with another $$:)
$(eval $$(info $(subst $$,$$$$,$(text))))
$(info )

$(info If eval uses assignment, the hashmark introduces a comment!)
$(info NOTE: Simple hashmark substitution fails in case of backslash hashmark sequence.)
$(eval var = $(subst #,\#,$(subst $$,$$$$,$(text))))
$(info $(var))
$(info )

$(info Hide hashmark in a variable if eval uses assignment:)
hsm ::= \#
$(eval var = $(subst #,$$(hsm),$(subst $$,$$$$,$(text))))
$(info $(var))
$(info )

$(info Check the same substitution with eval and function context:)
$(eval $$(info $(subst #,$$(hsm),$(subst $$,$$$$,$(text)))))
$(info )

$(info Hide hashmark in a variable and use value function:)
hsm ::= \#
$(eval var = $(subst #,$$(hsm),$(value text)))
$(info $(var))
$(info )

$(info Check the same substitution with eval and function context:)
$(eval $$(info $(subst #,$$(hsm),$(value text))))
$(info )
all:
