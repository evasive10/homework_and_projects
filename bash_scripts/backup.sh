#! /bin/bash

mkdir -p /var/backup
mv /var/backups/home.tar.gz /var/backups/home.last.tar.gz
tar zcvvf /var/backups/home.tar.gz /home
ls -hl /var/backups > /var/backups/file_report.txt
free -h > /var/backups/disk_report.txt
