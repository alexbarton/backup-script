# Backup Script

A script for cloning systems using rsync.  
Copyright (c)2008-2015 Alexander Barton <alex@barton.de>


## Usage

### backup-script

Backup all or individual systems.

Usage: `backup-script [<options>] [<system> [<system> [...]]]`

Options:

- `-p`, `--progress`: Show progress, see rsync(1).
- `-n`, `--dry-run`: Test run only, don't copy any data.

When no *system* is given, all defined systems are backed up.

### backup-script-wrapper

Backup all systems and mail the report to "root".

Usage: `backup-script-wrapper`

### backup-status

Show information about backups.

Usage: `backup-status [-q] [<system> [<system> [...]]]`

Options:

- `-q`: *quick mode*, don't calculate backup sizes.


## Configuration

All default configuration variables are read from the first file found of this
list: `/usr/local/etc/backup-scrupt.conf`, `/etc/backup-script.conf` or
from `/etc/backup-script.d/backup-script.conf` (deprecated).

All systems which should be backed-up are configured using  individual files
in the configuration directory, which is `/usr/local/etc/backup-script.d/` or
`/etc/backup-script.d/` by default (whichever is found first), and can be
specified using the `conf_d` variable in the main configuration file.

The must be one file for each system to backup (files ending in `*.sh` are
skipped, as well as files named `backup-script.conf`). Please avoid spaces and
other "special" characters! The filename is used as hostname for the system by
default, but this can be overwritten using the `system` configuration variable.

Variables in `backup-script.conf` must be prefixed with `default_` to define
default values for all systems.

All defaults can be overwritten in the individual system configuration files.

For example:

- `/etc/backups-script.conf`: defaults for all hosts
- `/etc/backups-script.d/host01.example.net`: configuration for host 1
- `/etc/backups-script.d/clientXY.example.com`: configuration for host 2


## Configuration Variables

### system

System host name. Default: file name.

*Note:* There is no `default_system` variable!

### [default_]backup_type

Backup type to use. Default: `rsync`.

- `rsync`: system backup using rsync(1).
  Use `source_root` to specify the root directory to save.

- `scp`: file backup using scp(1).
  Use `files` to specify the files to copy.

Please note that neither `ssh_args_add`, `rsync_args_add`, `compress`, nor any
"exclude" parameters are supported when using the "scp" backup type! And There
"scp" backup type never _deletes_ files from the backup store; so if you reduce
the list of files to backup, old files will still be kept, because they were
already saved in an older generation (but no longer updated).

### [default_]user

Remote user. Default: `root`.

### [default_]source_root

Remote *root* directory, must end with a slash ("/") character! Default: "/".

When saving the whole (remote) system ("/"), default excludes are set up
automatically, which exclude standard system directories like /sys and /proc.

### [default_]file

Space separated list of files to copy when using the "scp" `backup_type`.
Default: "running-config".

### [default_]target

Local backup directory. The backup of each system is stored in a folder named
like the system (see `system` variable) inside of this target directory.

*Note:* There is *no* default, you have to specify this variable, for example as
`default_target` in the `backups-script.conf` file!

### [default_]ssh_args_add

Additional parameters for `ssh`. Default: none.

### [default_]rsync_args_add

Additional parameters for `rsync`. Default: none.

### [default_]exclude_args_add

Additional (exclude) parameters for `rsync`. Default: none.

*Deprecated! Use "exclude_dirs_add" instead!*

### [default_]exclude_dirs_add

Additional directory path names to exclude from the backup. Use full path names
separated by spaces. Default: none.

### [default_]compress

Enable (1) or disable (0) rsync transfer compression. Default: 1 (on).

### [default_]ping

Enable (1) or disable (0) ping'ing the target system to make sure that it is
reachable before calling `rsync`. Default: 1 (on).

### [default_]local

Enable (1) or disable (0) *local mode*: when local mode is in effect, `rsync` is
called without using `ssh`, which is a good idea when saving the local system.
Default: 0 (off; use ssh).

### [default_]generations

Number of generations to keep. Default: 0 (none).

On a suitable target file systems (see `target` variable), this script can
generate generations using snapshots: the script creates a new snapshot
named with the time stamp for each generation inside of the system directory
inside of the target directory.

Supported file systems are:

 * *btrfs*:
   All generations are btrfs subvolumes and named after the date and time.
 * *ZFS*:
   All generations are ZFS file systems. Latest generation is named `current`,
   elders are links to the ZFS snapshot directories.

The latest snapshot is always reachable using a symlink named `latest`
inside the system directory.

### [default_]job_pre_exec

Optional script to execute before `rsync` starts. Default: none.

When the `job_pre_exec` script returns an error (exit code is not 0), the backup
run is skipped!

### [default_]job_post_exec

Optional script to execute after `rsync` exited. Default: none.

### Compatibility Variables

The following configurations variables used by the backup-pull(1) script in job
definition files are automatically mapped to the new backup-script variables:

* host -> system
* source -> source_root
* pre_exec -> job_pre_exec
* post_exec -> job_post_exec


## Exit codes

- 1: Unspecific Error!
- 2: Usage information has been shown.
- 3: Can't read system definition
- 4: PID-file exists!
- 5: Pre-exec command failed!
- 6: There have been systems with errors!
- 7: Not all jobs were run!
- 9: Aborted (CTRL-C)!
