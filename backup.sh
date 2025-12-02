#!/bin/bash
# inspired by https://documentation.ubuntu.com/server/how-to/backups/back-up-using-shell-scripts/
# and https://www.geeksforgeeks.org/devops/daily-system-backup-script-with-versioning-auto-cleanup/

backup_files="/home/dev/Documents /home/dev/.config/OrcaSlicer/user/default /var/www"
destination_path="/mnt/nas_smb/doc"
retention_days=10
# git files will be ignored by default, because *i* do not have important local-only git projects and it would take forever
# to speed things up my file system contains *legacy* directories, that are not supposed to be included in regular backups due to non existant changes but required availability on my system
# extend to any pattern that should be excluded with the l option
standard=(".git" "legacy/*")
legacy=(".git")

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

# function to construct chained exclusions with passed setting
exclude(){
    local -n dir_list=$1 # passed list by name reference
    excluded=""
    for pattern in "${dir_list[@]}"; do
        excluded=$excluded" --exclude=$pattern"
    done
    echo $excluded # can't return string, only integer. echo is fine
}

# backup files using tar based on choice to lower case
# wrapping the function call with parameter in backticks uses the result
case "${choice,,}" in
    "s")
        tar `exclude standard` -cvf $destination_path/$archive_file $backup_files
        ;;
    "l")
        # full backup filename has a modified filename to not being autodeleted
        # the legacy dir should not be excluded, but this is the legacy setting ;)
        tar `exclude legacy` -cvf $destination_path/full_with_legacy_$archive_file $backup_files
        ;;
    *)
        exit 1
        ;;
esac

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