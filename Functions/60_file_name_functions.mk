# File Name Functions

# Usage: make -f 60_file_name_functions.mk

# Several of the built-in expansion functions relate specifically to taking apart file names or lists of file names.
# see: https://www.gnu.org/software/make/manual/html_node/File-Name-Functions.html
empty =

$(info -§1- Dir Function $$(dir names…) - Extracts the directory-part of each file name in names.)

$(info -§1a- $$(dir src/foo.c hacks /bin/bash /opt/mktsimple) = '$(dir src/foo.c hacks /bin/bash /opt/mktsimple)')
# NOTE:  The directory-part of the file name is everything up through (and including) the last slash in it. If the file
# name contains no slash, the directory part is the string ‘./’.

$(info -§1b- Empty list $$(dir $$(empty)) = '$(dir $(empty))')

$(info -§1c- Dir up $$(dir ../src/src.cpp ./../src/src.cpp src/../src2/f1.cpp) =\
  '$(dir ../src/src.cpp ./../src/src.cpp src/../src2/f1.cpp)')

$(info -§1d- Dots only $$(dir . ./ .. ../ ./src ../src) = '$(dir . ./ .. ../ ./src ../src)')
# NOTE: Error with .. GNU Make 4.4.1
$(info )

$(info -§2- Notdir Function $$(notdir names…) - Extracts all but the directory-part of each file name in names.)

$(info -§2a- $$(notdir src/foo.c hacks ../file) = '$(notdir src/foo.c hacks ../file)')
# NOTE: If the file name contains no slash, it is left unchanged.

$(info -§2b- $$(notdir src/ ./src/headers// ../src/./ /opt/) = '$(notdir src/ ./src/headers// ../src/./ /opt/)')
# NOTE: A file name that ends with a slash becomes an empty string.

$(info -§2c- $$(notdir /bin/bash /opt/mktsimple) = '$(notdir /bin/bash /opt/mktsimple)')
$(info )

$(info -§3- Suffix Function $$(suffix names…) - Extracts the suffix of each file name in names.)

$(info -§3a- $$(suffix src/foo.c src-1.0/bar.c src/foo.c.o hacks src.xx/foo) =\
  '$(suffix src/foo.c src-1.0/bar.c src/foo.c.o hacks src.xx/foo)')
# NOTE: If the file name contains a period, the suffix is everything starting with the last period.
# NOTE: The suffix is the empty string, if no period in last component
$(info )

$(info -§4- Basename Function $$(basename names…) - Extracts all but the suffix of each file name in names.)

$(info -§4a- $$(basename src/foo.c src-1.0/bar hacks) = '$(basename src/foo.c src-1.0/bar hacks)')
# NOTE: Periods in the directory part are ignored.
# NOTE: If there is no period, the basename is the entire file name.

$(info -§4a- $$(basename . ./ .. ../) = '$(basename . ./ .. ../)')
# NOTE: Fails with dots only!
$(info )

$(info -§5- $$(addsuffix suffix,names…) - Append suffix to all names)

$(info -§5a- $$(addsuffix .c,foo bar src/bar /bin/bash) = '$(addsuffix .c,foo bar src/bar /bin/bash)')
$(info )

$(info -§6- $$(addprefix prefix,names…) - The value of prefix is prepended to the front of each individual name.)

$(info -§6a- $$(addprefix src/,foo bar) = '$(addprefix src/,foo bar)')
$(info )

$(info -§7- $$(join list1,list2) - Concatenates the two arguments word by word.)

$(info -§7a- $$(join a b,.c .o) = '$(join a b,.c .o)')

$(info -§7b- $$(join a b c,.c .o) = '$(join a b c,.c .o)')
$(info -§7b- $$(join a b,.c .o .d) = '$(join a b,.c .o .d)')
# NOTE: If one argument has more words that the other, the extra words are copied unchanged into the result.
$(info )

$(info -§8- Wildcard Function $$(wildcard pattern) - Expands to a space-separated list of the names of existing files\
that match the pattern.)
# see also: https://www.gnu.org/software/make/manual/html_node/Wildcards.html

# The wildcard characters in make are *, ? and […]
$(info -§8a- * Matches any string, including the null string.)
$(info $$(wildcard *.mk) = '$(wildcard *.mk)')
# NOTE: If an expression matches multiple files then the results will be sorted.

$(info -§8b- ? Matches any single character.)
$(info $$(wildcard 2?_special_functions.mk) = '$(wildcard 2?_special_functions.mk)')

$(info -§8c- [...] Matches any one of the characters enclosed between the brackets.)
$(info $$(wildcard [234]?_*.mk) = '$(wildcard [234]?_*.mk)')

$(info -§8d- ~ At the beginning of a file name represents the home sirectory.)
$(info $$(wildcard ~/*) = '$(wildcard ~/*)')

$(info -§8e- Wildcard function can search a list of patterns)
$(info $$(wildcard 6*.mk 3*.mk 2*.mk) = '$(wildcard 6*.mk 3*.mk 2*.mk)')
# NOTE: The result is not globally sorted!

$(info -§8f- The special significance of a wildcard character can be turned off by preceding it with a backslash.)
$(file > foo_bar)
$(file > foo*bar)
$(file > foo?bar)
$(info $$(wildcard foo*bar) = '$(wildcard foo*bar)')
$(info $$(wildcard foo\*bar) = '$(wildcard foo\*bar)')
$(info $$(wildcard foo\?bar) = '$(wildcard foo\?bar)')

$(info -§8g- If no file matches the pattern wildcard expands to the empty string. - Test file exists)
$(info $$(wildcard foo-bar) = '$(wildcard foo-bar)')

$(info -§8g- No canonical path returned)
$(info $$(wildcard src/headers/../../foo_bar) = '$(wildcard src/headers/../../foo_bar)')
$(info )

$(info -§9- Realpath Function $$(realpath names…) - For each file name in names return the canonical absolute name.)
$(info -§9a- File must exist $$(realpath 00_functions.mk ./src/headers/../10_text_functions.mk hacks) =\
  '$(realpath 00_functions.mk ./src/headers/../../10_text_functions.mk hacks)')
# NOTE: Function realpath follows symlinks
$(info )

$(info -§10- Abspath Function $$(abspath names…) - For each file name in names return the canonical absolute name.)
$(info -§10a- File may exist $$(abspath 00_functions.mk ./src/headers/../10_text_functions.mk hacks ../../notexists/./file.cpp) =\
  '$(abspath 00_functions.mk ./src/headers/../../10_text_functions.mk hacks ../../notexists/./file.cpp)')
# NOTE: Function abspath does not follow symlinks
$(info )

target:
	rm foo_bar foo\*bar foo\?bar
