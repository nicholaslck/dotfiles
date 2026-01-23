#!/bin/zsh

# The default `brew bundle` command exports all formulas that includes
# those act as dependencies but not manually installed by users.
# I don't like that.
# Therefore, the following scripts does the job.

BREWFILE=$HOME/.config/homebrew/Brewfile

echo "# Exported on $(date "+%Y-%m-%d %H:%M:%S")" >$BREWFILE

# export tabs
echo "fetching taps"
brew tap | xargs -I {} echo "tap \"{}\"" >>$BREWFILE
echo "" >>$BREWFILE

# export formulas manually installed by user
echo "fetching formulas"
brew leaves -r | xargs -I {} echo "brew \"{}\"" >>$BREWFILE
echo "" >>$BREWFILE

# export casks
echo "fetching casks"
brew list --casks | xargs -I {} echo "cask \"{}\"" >>$BREWFILE
echo "" >>$BREWFILE

echo "Brew bundle completed. Please review the file at $BREWFILE"
echo ""
