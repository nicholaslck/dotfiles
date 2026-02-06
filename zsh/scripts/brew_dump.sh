#!/bin/zsh
#
$XDG_CONFIG_HOME/homebrew/bundle_dump.sh

_GIT_DIR=$XDG_CONFIG_HOME
git -C $_GIT_DIR add homebrew/Brewfile
git -C $_GIT_DIR commit -m "Backup Homebrew bundle $(date +%Y-%m-%d_%H:%M:%S)"
git -C $_GIT_DIR push
