!#/bin/zsh

_TMUX_BIN=/opt/homebrew/bin/tmux

if [[ -z "$TMUX" ]]; then
  if $_TMUX_BIN ls &>/dev/null; then
    exec $_TMUX_BIN attach-session # auto attach
  else
    exec $_TMUX_BIN new-session
  fi
fi
