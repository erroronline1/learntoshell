# git cheatsheet
since i work completely on my own the only features i need is committing and pushing solely for the purpose of version control.

git has so many features so i tried to figure out the most useful commands for my personal workflow. what do i need more?

## everyday cheatsheet

### initiate:
	git init
	(git remote add origin https://github.com/[USER]/[REPO].git)

### normal work:
	git add (. || FILE)
	(git rm FILE)
	git commit -am "minor updates"
	git commit --amend
	git commit FILE --reuse-message=HEAD
	(git push)

### in case of messed up commits
	rm -force .git/index.lock

### branches:
	git branch NEW_BRANCHNAME
	git checkout BRANCHNAME || master
	git checkout -b NEW_BRANCHNAME (new branch and immediate change to branch)
	git branch -d TO_BE_DELETED_BRANCH
	(git push origin --delete TO_BE_DELETED_REMOTE_BRANCH)

### merge:
	git merge BRANCHNAME_TO_TAKE_FROM