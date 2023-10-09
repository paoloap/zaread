install: 
	cp zaread $(DESTDIR)$(PREFIX)/bin
	cp zaread.desktop $(DESTDIR)$(PREFIX)/usr/share/applications
	chmod 755 $(DESTDIR)$(PREFIX)/bin/zaread
