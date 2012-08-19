#!/bin/bash

function OldestBackupName () {
  heroku pgbackups --app barslice | grep ^b | sort -r | tail -n 1 | cut -d"|" -f 1
}

function LastBackupName () {
  heroku pgbackups --app barslice | grep ^b | sort | tail -n 1 | cut -d"|" -f 1
}

# This part assumes you have a low limit on no. of backups allowed
old_backup=$(OldestBackupName)
heroku pgbackups:destroy $old_backup --app barslice

heroku pgbackups:capture --app barslice
new_backup=$(LastBackupName)
curl $(heroku pgbackups:url $new_backup --app barslice) > temporary_backup.dump
pg_restore --verbose --clean --no-acl --no-owner -h localhost -d barslice_development temporary_backup.dump
rm -f temporary_backup.dump