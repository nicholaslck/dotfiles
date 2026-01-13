#!/bin/zsh
#

_PWD=$(pwd)

cd ~/.config
~/.config/homebrew/bundle_dump.sh

git add homebrew/Brewfile
git commit -m "Backup Homebrew bundle $(date +%Y-%m-%d_%H:%M:%S)"
git push

cd $_PWD
