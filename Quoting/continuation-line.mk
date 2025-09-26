.PHONY: all
all: filesp\\\:1 \
  filesp\\\:1a

filesp\\\:1a\
filesp\\\:1:
	touch '$@'

.PHONY: clean
clean:
	rm -fv filesp*
