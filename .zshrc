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

BREW_PREFIX=$(brew --prefix)

# Added by LM Studio CLI (lms)
export PATH="$HOME/.lmstudio/bin:$PATH"

# ruby (via homebrew)
export PATH="$BREW_PREFIX/opt/ruby/bin:$PATH"
export PATH="$BREW_PREFIX/lib/ruby/gems/3.4.0/bin:$PATH"

# Added by Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# zsh completions
fpath=($BREW_PREFIX/share/zsh/site-functions $fpath)

# zsh compinit
autoload -Uz compinit && compinit

# Custom aliases
alias la="ls -a"
alias ll="ls -lah"
alias c="clear"
alias reboot="sudo /sbin/reboot"
alias shutdown="sudo /sbin/shutdown -h now"
alias reload="exec zsh"
alias checkin="brew update && brew upgrade"

# neovim
alias vim="nvim"
alias vi="nvim"

# thefuck alias
eval $(thefuck --alias)

# lazygit alias
alias lgit="lazygit"

# custom llm caller alias
alias pplx="~/.config/.scripts/pplx.sh"

# Ollama origins for Obsidian Copilot
# **Disabled the following lines because I no longer run Ollama services here**
# export OLLAMA_ORIGINS=*
# export OLLAMA_HOST="127.0.0.1"
# launchctl setenv OLLAMA_ORIGINS $OLLAMA_ORIGINS
# launchctl setenv OLLAMA_HOST $OLLAMA_HOST

# compdef pnpm
###- begin-pnpm-completion -###
if type compdef &>/dev/null; then
  _pnpm_completion() {
    local reply
    local si=$IFS

    IFS=$'\n' reply=($(COMP_CWORD="$((CURRENT - 1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" SHELL=zsh pnpm completion-server -- "${words[@]}"))
    IFS=$si

    if [ "$reply" = "__tabtab_complete_files__" ]; then
      _files
    else
      _describe 'values' reply
    fi
  }
  # When called by the Zsh completion system, this will end with
  # "loadautofunc" when initially autoloaded and "shfunc" later on, otherwise,
  # the script was "eval"-ed so use "compdef" to register it with the
  # completion system
  if [[ $zsh_eval_context == *func ]]; then
    _pnpm_completion "$@"
  else
    compdef _pnpm_completion pnpm
  fi
fi
###- end-pnpm-completion -###

# zoxide to replace cd
eval "$(zoxide init --cmd "cd" zsh)"
