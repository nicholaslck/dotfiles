# zsh-zap
if [ ! -d "$ZAP_DIR" ]; then
  zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep
fi

# brew
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi

# brew formulas and casks
brew bundle install --file ~/.config/homebrew/Brewfile

# symlink zshrc
~/.config/zsh/links.sh

echo "Done. Please restart your terminal."
