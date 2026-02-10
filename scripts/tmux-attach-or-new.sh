#!/bin/zsh

if [[ -z "$TMUX" ]]; then
  if tmux ls &>/dev/null; then
    exec tmux attach-session # auto attach
  else
    exec tmux new-session
  fi
fi
