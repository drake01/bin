#!/bin/sh

# Run git-update.sh for all git repositories in this directory.
#
# All arguments are passed to git-update.sh.


find . -name .git -type d -exec git-update.sh "$@" {} \; | less
