#
# backup-script system for cloning systems using rsync
# Copyright (c)2008-2013 Alexander Barton, alex@barton.de
#

PREFIX = /usr/local

all:

clean:

distclean: clean

maintainer-clean: distclean

check:

install:
	install -d -o root -g root -m 755 \
	 $(DESTDIR)$(PREFIX)/sbin
	install -o root -g root -m 755 bin/backup-script \
	 $(DESTDIR)$(PREFIX)/sbin/backup-script
	install -o root -g root -m 755 bin/backup-script-wrapper \
	 $(DESTDIR)$(PREFIX)/sbin/backup-script-wrapper
	install -o root -g root -m 755 bin/backup-status \
	 $(DESTDIR)$(PREFIX)/sbin/backup-status
	install -d -o root -g root -m 755 \
	 $(DESTDIR)$(PREFIX)/etc/backup-script.d
	install -d -o root -g root -m 755 $(DESTDIR)/etc
	test -e $(DESTDIR)/etc/backup-script.d \
	 || ln -s $(DESTDIR)$(PREFIX)/etc/backup-script.d \
	      $(DESTDIR)/etc/backup-script.d

.PHONY = all clean distclean maintainer-clean check install
