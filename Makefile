DEST ?= /usr

.PHONY: install uninstall

install:
	mkdir -p "$(DEST)/bin" "$(DEST)/share/applications"
	cp zaread "$(DEST)/bin/zaread"
	chmod 755 "$(DEST)/bin/zaread"
	cp zaread.desktop "$(DEST)/share/applications/zaread.desktop"

uninstall:
	rm -f "$(DEST)/bin/zaread"
	rm -f "$(DEST)/share/applications/zaread.desktop"
