# AGENTS.md

## Must follow rules

The following commands must ask user for permission:

- `git`
- `just`
- `dotbot` (use `just link` instead)

The repo is a central repository for all my configs and scripts, some of the files will be symlink to external locations. Therefore, if any actions that would affect how the symlinks structures or the folder structures, ALWAYS ask the user for permission.

The symlink mapping can be referred to file `dotbot.yml`

## Directory structure

- `bin/`: contains all custom executables. Make sure all files here are executable, if not, use `chmod +x` to make them so. These executables should be symlink to `~/.local/bin` via dotbot
- `config/`: contains all configs. The corresponding symlink mapping can be referred to `dotbot.yml`
- `scripts/`: contains all shell scripts.

## Others

- For compinit related scripts, append "-comp" in the filename.
- For compinit related scripts, make sure to sources them before the `compinit` call in `.zshrc`
- By default, `PATH` setting must be placed in `.zprofile` instead of `.zshrc`

## How to change certain files

- `Brewfile`: instead of manaully update or modify this file, we only use `just save_brew` to dump the current Brew bundle to `Brewfile`
