#!/bin/zsh
#
# This script simply asks a question to Perplexity AI and gets markdown output.

# List of dependencies to check
dependencies=("llm" "glow")
missing=()

for dependency in "${dependencies[@]}"; do
  if ! command -v "$dependency" &>/dev/null; then
    echo "$dependency is not installed. Run 'brew install $dependency'"
    missing+=("$dependency")
  fi
done

if ((${#missing[@]} > 0)); then
  exit 1
fi

llm -m sonar "$*" | glow
