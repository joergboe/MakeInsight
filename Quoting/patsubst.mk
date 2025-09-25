# Pattern Substitution Function
# Escape %

# Usage: make -f patsubst.mk

$(info 1 $(patsubst ab%,AB%,abc abcccc ab%aaa))

$(info 2 $(patsubst ab%,AB,abc abcccc ab%aaa))

$(info 3 $(patsubst ab%,AB%%,abc abcccc ab%aaa))

$(info 4 $(patsubst ab%%,AB%%,abc% abcccc% ab%aaa%))

$(info 5 $(patsubst \%ab%,AB%%,%abc %abcccc %ab%aaa))

