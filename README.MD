# git cheatsheet
since i work completely on my own the only features i need is committing and pushing solely for the purpose of version control.

git has so many features so i tried to figure out the most useful commands for my personal workflow. what do i need more?

## everyday cheatsheet

### initiate:
```console
git init
git remote add origin https://github.com/[USER]/[REPO].git
```

### normal work:
```console
# add and remove files to repository
git add FILE
git rm FILE
# commit distinct files or all recent changes
git commit -m"minor updates" filename_with_*wildcard
git commit -am"minor updates"
git commit -m"title" -m"message"
# edit or reuse commit messages
git commit --amend
git commit FILE --reuse-message=HEAD
(git push)
# rename
mv oldfilename newfilename
```

https://www.freecodecamp.org/news/how-to-write-better-git-commit-messages/

### tagging for snapshots of commit state
```console
git tag -a v1.0 -m "Version 1.0"
# tags have to be pushed extra
git push origin v1.0
```

### add but do not track
```console
git add database.php
git commit
git push
git update-index --assume-unchanged database.php

git update-index --no-assume-unchanged database.php
git commit -a
git update-index --assume-unchanged database.php
```

### in case of messed up commits
```console
# revert distinct file to previous state
git checkout commit# messedupfile
# reset head, keeping file changes, X is descending index of commits 
git reset HEAD~X --soft
# on troubles caused by occult opened editors or git processes
rm -force .git/index.lock
```

### branches:
```console
git branch NEW_BRANCHNAME
git checkout BRANCHNAME || master
git checkout -b NEW_BRANCHNAME (new branch and immediate change to branch)
git branch -d TO_BE_DELETED_BRANCH
(git push origin --delete TO_BE_DELETED_REMOTE_BRANCH)
```

### merge:
```console
git merge BRANCHNAME_TO_TAKE_FROM
git merge --abort
# accept current, incoming or both changes e.g. in vscode
git add file.ext
git add .
git commit
```

### show info
```console
# show commit history, q to quit
git log
# differences in commits between local and remote branch, commits and changes
git status
# show difference in source code between old (e.g. 3 commit back then) and new head. commit-hashes can be used instead of head
git diff HEAD~3 HEAD optional_distinct_file
```

### handling remote repositories on usb
```console
# init bare remote repository
git init --bare J:\repo_name
# cd to local repository
git remote add usb J:\repo_name
git checkout master
git push usb master
git pull usb master
# if usb shows up on different drive letter
git remote set-url usb K:\repo_name
```
*[shortened from stack overflow user binaryfunt](https://stackoverflow.com/questions/43569757/how-to-use-usb-drive-as-remote)*

### md styling
[https://gist.github.com/milkbread/5795012](https://gist.github.com/milkbread/5795012)

### how to exit vim
[https://www.fprintf.net/vimCheatSheet.html](https://www.fprintf.net/vimCheatSheet.html)

	:q(!)
	:wq(!)
