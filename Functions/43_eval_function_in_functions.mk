# Nesting eval function in other functions

# Usage: make -f 43_eval_function_in_functions.mk

# Avoid unnecessary expansions, use variables instead.

list ::= item1 item2 item3 itemWith$$Dollar itemWith$$$$Dollars itemWith\#Hashmarks\\\# \item\\With\\\Backslash\\\\\
bsend\\

$(info Input list)
$(info )

$(info the local variable var is visible in eval context - var is expanded to res)
res ::=
$(foreach var,$(list),$(eval res += $$(var)))
$(info $(res))

# NOTE: Do not use references to local variables in global context!
$(info the local variable var is visible in eval context - var is appended as reference)
res =
$(foreach var,$(list),$(eval res += $$(var)))
$(info $(res))
$(info $(value res))
$(info )

$(info local variables in let function are visible in eval context)
$(let v1 v2 v3 rest,$(list),$(eval res ::= $$(v1) $$(v2) $$(v3) $$(rest)))
$(info $(res))
$(info )

$(info local variables in call function are visible in eval context)
concatenate9 = $1 $2 $3 $4 $5 $6 $7 $8 $9
$(let v1 v2 v3 v4 v5 v6 v7 v8 v9,$(list),\
    $(eval res ::= $$(call concatenate9,$$(v1),$$(v2),$$(v3),$$(v4),$$(v5),$$(v6),$$(v7),$$(v8),$$(v9))))
$(info $(res))
$(info )

target:;
