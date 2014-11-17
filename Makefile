#
# backup-script system for cloning systems using rsync
# Copyright (c)2008-2014 Alexander Barton, alex@barton.de
#

include ./Makefile.ax

install-local:
	install -d -o $(USER) -g $(GROUP) -m 755 \
	 $(DESTDIR)$(PREFIX)/sbin
	install -o $(USER) -g $(GROUP) -m 755 bin/backup-script \
	 $(DESTDIR)$(PREFIX)/sbin/backup-script
	install -o $(USER) -g $(GROUP) -m 755 bin/backup-script-wrapper \
	 $(DESTDIR)$(PREFIX)/sbin/backup-script-wrapper
	install -o $(USER) -g $(GROUP) -m 755 bin/backup-status \
	 $(DESTDIR)$(PREFIX)/sbin/backup-status
	install -d -o $(USER) -g $(GROUP) -m 755 \
	 $(DESTDIR)$(PREFIX)/etc/backup-script.d
