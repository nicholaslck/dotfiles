# This file is sourced by interactive shells

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "Aloxaf/fzf-tab"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"

# zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# zsh completions
fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)

# zsh compinit
source ~/.config/zsh/pnpm_comp.sh
source ~/.config/zsh/gitleaks_comp.sh
autoload -Uz compinit && compinit

# Custom aliases
alias la="ls -a"
alias ll="ls -lah"
alias c="clear"
alias reboot="sudo /sbin/reboot"
alias shutdown="sudo /sbin/shutdown -h now"
alias reload="exec zsh"

# neovim
alias vim="nvim"
alias vi="nvim"

# thefuck alias
eval $(thefuck --alias)

# lazygit alias
alias lgit="lazygit"

# custom llm caller alias
alias pplx="~/.config/zsh/scripts/pplx.sh"
alias update="~/.config/zsh/scripts/update.sh"

# zoxide to replace cd
eval "$(zoxide init --cmd "cd" zsh)"
