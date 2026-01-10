#!/bin/zsh

# zap plugins
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
zap update all

# brew update and brew upgrade
brew update && brew upgrade
