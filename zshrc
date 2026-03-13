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
fpath=("/Users/nicholaslck/.zsh/completions" $fpath)

# zsh compinit
source ~/dotfiles/scripts/pnpm-comp.sh
source ~/dotfiles/scripts/gitleaks-comp.sh
eval "$(op completion zsh)"; compdef _op op
autoload -Uz compinit
compinit

# zoxide to replace cd
eval "$(zoxide init --cmd "cd" zsh)"

# Custom aliases

alias c="clear"
alias reboot="sudo /sbin/reboot"
alias shutdown="sudo /sbin/shutdown -h now"
alias reload="exec zsh"

# neovim
alias vim="nvim"
alias vi="nvim"
export EDITOR=nvim
export VISUAL=nvim

# thefuck alias
eval $(thefuck --alias)

# lazygit alias
alias lgit="lazygit"

# just alias
alias j="just"

# custom llm caller alias
alias oc="opencode"
alias kc="kilocode"

alias ls="eza"
alias lsa="eza -a"
alias ll="eza -lah"
alias lt="eza -T -L=2"
alias lta="eza -T -L=2 -a"

# yazi
source ~/dotfiles/scripts/yazi-shorthand.sh

# uv venv
source ~/dotfiles/scripts/activate.sh

if [ "$TERM_PROGRAM" = "ghostty" ] && [ -z "$TMUX" ]; then
  tmux has-session && exec tmux attach || exec tmux
fi

typeset -U PATH path
