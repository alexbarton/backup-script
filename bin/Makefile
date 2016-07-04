#
# backup-script system for cloning systems using rsync
# Copyright (c)2008-2015 Alexander Barton <alex@barton.de>
#

include ../lib/Makefile.ax

install-local:
	install -d -o $(USER) -g $(GROUP) -m 755 \
	 $(DESTDIR)$(PREFIX)/sbin
	install -o $(USER) -g $(GROUP) -m 755 backup-script \
	 $(DESTDIR)$(PREFIX)/sbin/backup-script
	install -o $(USER) -g $(GROUP) -m 755 backup-script-wrapper \
	 $(DESTDIR)$(PREFIX)/sbin/backup-script-wrapper
	install -o $(USER) -g $(GROUP) -m 755 backup-status \
	 $(DESTDIR)$(PREFIX)/sbin/backup-status

check-local:
	./backup-script --help | fgrep 'Usage: ' >/dev/null
	./backup-script --help | fgrep 'Configuration file is "' >/dev/null
	./backup-status --help | fgrep 'Usage: ' >/dev/null
