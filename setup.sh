#!/bin/zsh

# install zsh-zap
if [ ! -d "$ZAP_DIR" ]; then
  zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep
fi

# install brew
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi

# install just
brew install just

## install rust
curl https://sh.rustup.rs -sSf | sh

just install

# start background services
brew services start borders
brew services start sketchybar

# start AeroSpace immediately
APP_AEROSPACE="/Applications/AeroSpace.app"
[ -d $APP_AEROSPACE ] && open $APP_AEROSPACE

# config git to load catppuccin theme for delta
echo "[include]" >> $HOME/.gitconfig
echo "\tpath = ~/.config/delta/config" >> $HOME/.gitconfig


echo ""
echo "Setup done."
echo "Remember to reload Ghostty config by pressing [ Shift + Cmd + , ] in Ghostty."
echo "Please restart your computer."
