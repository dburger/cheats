# get helpful colors when possible
git config --global color.ui auto

# to put the branch back to state before last commit, will make those
# changes not committed or staged, good for putting a WIP commit back
# in the working tree
git reset HEAD^

# to back out all changes no longer staged or in working tree
git reset --hard HEAD

# to grab a specific file from another branch, will stage it
git checkout BRANCH FILE

# show commit history tree with ref names
git log --graph --decorate

# merge forcing usage of a merge commit
git merge --no-ff BRANCH

# merge only allow fast forward, fails otherwise
git merge --ff-only BRANCH

# get an annotated view of a file to determine commit, when, and by who
git blame FILE

# look at the patch for a commit for a single file
git log COMMIT -p -1 FILE