#!/bin/bash
# inspired by https://documentation.ubuntu.com/server/how-to/backups/back-up-using-shell-scripts/

backup_files="/home/dev/Documents /home/dev/.config/OrcaSlicer/user/default /var/www"
exclude_pattern=".git"
destination_path="/mnt/nas_smb/doc"

# archive filename.
hostname=$(hostname -s)
archive_file="$hostname.tar"

# Print start status message.
echo "Backing up $backup_files to $destination_path/$archive_file"
date
    
# Backup and update newer files using tar.
tar --exclude="$exclude_pattern" -uvf $destination_path/$archive_file $backup_files
    
# Print end status message.
echo
echo "Backup finished"
date