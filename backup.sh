#!/bin/bash
# inspired by https://documentation.ubuntu.com/server/how-to/backups/back-up-using-shell-scripts/
# and https://www.geeksforgeeks.org/devops/daily-system-backup-script-with-versioning-auto-cleanup/

backup_files="/home/dev/Documents /home/dev/.config/OrcaSlicer/user/default /var/www"
destination_path="/mnt/nas_smb/doc"
retention_days=10
# git files will be ignored by default, because *i* do not have important local-only git projects and it would take forever
# extend to any pattern that should be excluded with any option
exclude_always=(".git")
# to speed things up my file system contains *legacy* directories,
# that are not supposed to be included in regular backups
# due to non existant changes but required availability on my system
# extend to any pattern that should be excluded with the l option
exclude_standard=("legacy/*")

# archive filename.
hostname=$(hostname -s)
day=$(date +%Y-%m-%d)
archive_file="$hostname-$day.tar.gz"

# check if option is passed as argument, for use with cron, startup, whatnot
# you can launch with `sudo ./backup.sh -s`
if [ "$#" -lt 1 ]; then
    # no arguments, ask for method
    read -p "[s]tandard / [l]egacy folders included / [C]ancel: " choice
else
    # remove - from the first argument string $1, could have gone without but arguments with minus are more intuitive
    choice=${1:1:1}
fi

# construct chained standard exclusions
always_exclude=""
for pattern in "${exclude_always[@]}"; do
    always_exclude=$always_exclude" --exclude=$pattern"
done
# construct chained legacy exclusions
standard_exclude=""
for pattern in "${exclude_standard[@]}"; do
    standard_exclude=$standard_exclude" --exclude=$pattern"
done

# backup files using tar based on choice to lower case
if [ "${choice,,}" == "s" ]; then
    tar $always_exclude $standard_exclude -cvf $destination_path/$archive_file $backup_files
elif [ "${choice,,}" == "l" ]; then
    # full backup filename has a modified filename to not being autodeleted
    tar $always_exclude -cvf $destination_path/full_with_legacy_$archive_file $backup_files
else
    exit 1
fi

# check if tar was successful, exit on fail
if [ $? -eq 0 ]; then
    echo "Backup saved to: $destination_path"
else
    echo "Backup failed!"
    exit 1
fi

# if backup has been successful, check if older backups can be found and prompt for deletion
deletions=$(find $destination_path/$hostname*.tar.gz -type f -mtime +$retention_days)
if [ -n "$deletions" ]; then
    read -p "$deletions are older than $retention_days days. Delete [y/N]? " choice
    if [ "${choice,,}" == "y" ]; then
        find $destination_path/$hostname*.tar.gz -type f -mtime +$retention_days -delete
    fi
fi

echo "Finished `date`"