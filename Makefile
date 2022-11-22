#
# backup-script system for cloning systems using rsync
# Copyright (c)2008-2022 Alexander Barton, alex@barton.de
#

SUBDIRS = bin etc examples

include ./lib/Makefile.ax

install-local:
	install -d -o "$(USER)" -g "$(GROUP)" -m 755 \
	 "$(DESTDIR)$(PREFIX)/etc/backup-script.d"
