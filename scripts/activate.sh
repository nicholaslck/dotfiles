#!/bin/zsh
#
# Find venv in current or parent directories
__find_venv__() {
  local dir="$PWD"
  while [[ "$dir" != "/" ]]; do
    if [[ -d "$dir/.venv" ]]; then
      echo "$dir/.venv"
      return 0
    fi
    dir="$(dirname "$dir")"
  done
  return 1
}

# Function to automatically activate/deactivate venv
__python_venv__() {
  local venv_path
  venv_path=$(__find_venv__)

  if [[ -n "$venv_path" ]] && [[ -f "$venv_path/bin/activate" ]]; then
    # Found venv with activate script, check if already activated
    if [[ "$VIRTUAL_ENV" != "$venv_path" ]]; then
      # If a different venv is running, deactivate it first
      [[ -n "$VIRTUAL_ENV" ]] && deactivate >/dev/null 2>&1
      # Activate the found venv
      source "$venv_path/bin/activate" >/dev/null 2>&1
    fi
  else
    # No venv found, check if current directory is still within previous venv scope
    if [[ -n "$VIRTUAL_ENV" ]]; then
      local parentdir="$(dirname "$VIRTUAL_ENV")"
      # If current path is not under venv parent directory, deactivate
      if [[ "$PWD"/ != "$parentdir"/* ]]; then
        deactivate >/dev/null 2>&1
      fi
    fi
  fi
}

# Add function to chpwd hook
autoload -U add-zsh-hook
add-zsh-hook chpwd __python_venv__

activate() {
  local venv_path
  venv_path=$(__find_venv__)
  # Check if .venv directory exists and activate script exists
  if [[ -n "$venv_path" ]] && [[ -f "$venv_path/bin/activate" ]]; then
    source "$venv_path/bin/activate"
  else
    echo "No executable .venv/bin/activate found"
  fi
}
