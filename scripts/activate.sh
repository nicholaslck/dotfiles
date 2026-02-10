#!/bin/zsh

activate() {
  # Check if .venv directory exists and activate script is executable
  if [ -d ".venv" ] && [ -f ".venv/bin/activate" ]; then
    source .venv/bin/activate
  else
    echo "No executable .venv/bin/activate found"
  fi
}
