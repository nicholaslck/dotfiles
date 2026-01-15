#!/bin/zsh

# zap plugins
echo "Updating zap plugins..."
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
zap update all

# brew update and brew upgrade
echo "Updating brew formulas and casks..."
brew update && brew upgrade

# yazi plugins upgrade
echo "Updating yazi plugins..."
ya pkg upgrade
