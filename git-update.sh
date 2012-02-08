#!/bin/sh

# Push current commits to all remotes and fetch from all remotes. Then display
# unmerged commits and changes in the repositories.
#
# If --local is given as option, no fetching/pushing is performed.
#
# If an argument is given cd to this directory before running the commands.
#
# Very useful to sync multiple remotes.


LOCAL=
if [ x$1 = x--local ];then
    LOCAL=1
    shift
fi

if [ x$1 != x ]; then
    echo $1
    cd "$1"
fi

if [ x$LOCAL = x ]; then
    # Get all remote changes.
    git remote update 2>&1 | grep -v Fetching
    # Push all local changes to remote(s).
    for remote in `git remote`; do
        git push $remote 2>&1 | grep -v 'Everything up-to-date'
        git push --tags $remote 2>&1 | grep -v 'Everything up-to-date'
    done
fi
# Show unmerged changes.
git branch -rv --color --no-merged
# Show uncommitted changes.
if `echo "$1" | grep '\.git\$' > /dev/null`; then
    cd ..
fi
git status | grep 'Changes to be committed:' > /dev/null \
    && echo '-> modified (staged)'
git status | grep 'Changed but not updated:' > /dev/null \
    && echo '-> modified'
git status | grep 'Untracked files:' > /dev/null \
    && echo '-> modified (untracked)'

echo
