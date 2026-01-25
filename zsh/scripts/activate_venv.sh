#!/bin/zsh
#
# Paste the following into .zshrc to install this command
#
# ```
# source ~/.config/zsh/scripts/activate_venv.sh
# ```

__activate_venv() {
  # Check if .venv directory exists and activate script is executable
  if [ -d ".venv" ] && [ -f ".venv/bin/activate" ]; then
    source .venv/bin/activate
  else
    echo "No executable .venv/bin/activate found"
  fi
}

alias activate=__activate_venv
