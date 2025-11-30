#!/bin/bash
# inspired by https://documentation.ubuntu.com/server/how-to/backups/back-up-using-shell-scripts/
# and https://www.geeksforgeeks.org/devops/daily-system-backup-script-with-versioning-auto-cleanup/

backup_files="/home/dev/Documents /home/dev/.config/OrcaSlicer/user/default /var/www"
exclude_pattern="\.git"
destination_path="/mnt/nas_smb/doc"
retention_days=10

# archive filename.
day=$(date +%Y-%m-%d)
hostname=$(hostname -s)
archive_file="$hostname-$day.tar.gz"

# Print start status message.
echo "Backing up $backup_files to $destination_path/$archive_file"
date
    
# Backup files using tar.
tar --exclude="$exclude_pattern" -cvf $destination_path/$archive_file $backup_files

# Check if tar was successful
if [ $? -eq 0 ]; then
    echo "Backup saved to: $destination_path/$archive_file"
else
    echo "Backup failed!"
    exit 1
fi

# delete older backups
echo "If found delete all backups older than 10 days"
find $destination_path/$hostname*.tar.gz -type f -mtime +$retention_days -delete

date